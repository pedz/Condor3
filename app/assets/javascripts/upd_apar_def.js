/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

/* Assume condor3.js has already defined condor3 object. */

/**
   An object used to process the upd_apar_def table.  The processing
   happens in stages.  Each stage uses jsrender and the
   upd_apar_def_row template to render JSON into the rows of the
   table.  At initialization time, the current location is passed in
   which is usually window.location.href.  It is a separate parameter
   to facilitate testing.  The return of the constructor is a hash of
   public functions which is also done for testing purposes.
   Otherwise, this could be a big anonymous function.

   @constructor
   @param {string} currentLocation - A string of the URL of the
   current page.
*/

condor3.UpdAparDef = function (currentLocation) {
    var thisThis = this;	// the `this' of this object.
    var $window = $(window);
    var containers;
    var currentLocationArray;
    var lastPage;
    var pageIndex;
    var script_element;
    var sortIndex;
    var sortOrder;
    var tbody;
    var instanceCounter;

    /**
       called when a GET request completes.  The GET request is
       triggered by the scrolling of the page to (roughly) the end of
       the page.  The parameters follow what jQuery requires.

       @param {JSON} atad - the JSON returned in the GET request.
       @param {integer} status - the HTTP status returned.
       @param {XHR} jqXHR - the XHR object.
    */
    function load_succ(atad, status, jqXHR) {
	/* reached the end of the atad */
	if (!atad || atad.length == 0) {
	    return;
	}
    
	var offset = $('.upd_apar_defs tbody tr').length + 1;
	$('.upd_apar_defs tbody').append($.render.upd_apar_def_row({items: atad, offset: offset}));
	/* Hook back up for next page */
	$window.on('scroll', thisThis.myScrollFunction);
    };

    /**
       called when a GET request for the next batch of JSON elements
       fails.The parameters follow what jQuery requires.

       @param {JSON} atad - the JSON returned in the GET request.
       @param {integer} status - the HTTP status returned.
       @param {XHR} jqXHR - the XHR object.
    */
    function load_fail(a, b, c) {
	alert('Fetch of additional results failed');
    };

    /**
       Returns the URL to use for the AJAX request to fetch the next
       set of elements to display.

       @return {string} the URL to GET.
    */
    function next_page_url() {
	var tmp;
	lastPage += 1;
	tmp =  currentLocationArray.slice(0, pageIndex);
	tmp.push(lastPage);
	return tmp.join('/') + '.json';
    };
    

    /*
     * These are hooked up to allow for spies.  They are not defined
     * within the closure so that the spies will take effect.
     */

    /**
       Bound to the scroll event of the window.  When the window is
       scrolled to within 100 rows of the bottom, an AJAX GET is done
       using what next_page_url returns and load_succ is called upon
       successful completion of the request. 

       @param {event} event - a jQuery event object
     */
    thisThis.myScrollFunction = function (event) {
	var window_height = $window.height();
	var document_scroll = $(document).scrollTop();
	var all_trs = $('table.upd_apar_defs tbody tr');
	var last_tr = $(all_trs[all_trs.length - 1]);
	var tr_height = last_tr.height();
	var o = last_tr.offset();
	var top = o.top;
	
	if ((window_height + document_scroll) > (top - (100 * tr_height))) {
	    $window.off('scroll', thisThis.myScrollFunction);
	    $.when( $.get(next_page_url(), null, null, 'json') )
		.done(load_succ)
		.fail(load_fail);
	}
    };

    /**
       Bound to the click event for the upd_apar_def_inner_td_span
       class of elements.  These are the little down arrow things that
       many of the elements in the page have.  The down arrow is
       clicked to pop up a context sensitive menu.

       @param {event} event - a jQuery event object
     */
    thisThis.click = function (event) {
	var arrow_span = $(this);
	var td = arrow_span.parents('td');
	var ui = td.find('.upd_apar_def_commands');
	var link = td.find('.upd_apar_def_link');

	thisThis.pickLi = function (event) {
	    ui.contextMenu('close');
	};

	arrow_span.hide();
	ui.contextMenu({
	    close: function () {
		arrow_span.show();
		ui.off('click', 'li', thisThis.pickLi);
	    },
	    bottom: -ui.outerHeight(),
	    left: link.width() - ui.width()
	}).on('click', 'li', thisThis.pickLi);
	return false;
    };

    /**
       Bound to the click event of upd_apar_defs_header_span class
       elements.  These are the header elements of the table.  When
       these are clicked, the sort order is changed and then a new
       request is sent if appropriate.

       @param {event} event - a jQuery event object
     */
    thisThis.alterSort = function (event) {
	var th = $(this).parent();
	var klass = th.attr('class');
	var column = klass.split('-')[1];
	var urlArray;

	if (column == sortOrder[0].column) {
	    if (sortOrder[0].prefix == "-")
		sortOrder[0].prefix = "";
	    else
		sortOrder[0].prefix = "-";
	} else if (column == sortOrder[1].column) {
	    sortOrder = [ sortOrder[1], sortOrder[0], sortOrder[2] ];
	} else if (column == sortOrder[2].column) {
	    sortOrder = [ sortOrder[2], sortOrder[0], sortOrder[1] ];
	} else {
	    sortOrder = [ { prefix: "", column: column }, sortOrder[0], sortOrder[1] ];
	}
	urlArray = currentLocationArray.slice(0, sortIndex);
	urlArray.push(
	    sortOrder.map(function(columnSpec) {
		return columnSpec.prefix + columnSpec.column;
	    }).join(', '));
	urlArray.push(1);
	thisThis.setLocation(urlArray.join('/'));
    };

    /**
       Helper method which can be mocked to set the location to go to.

       @params {string} url - the URL to go to.
     */
    thisThis.setLocation = function (url) {
	window.location = url;
    };

    /*
     * Some container element (like a div) bundles the table with the
     * script.  Its class is upd-apar-defs-container.  In theory, the
     * code should be able to cope with a sequence of these
     * containers.  That part has not been implemented yet (its not
     * currently needed).
     */
    containers = $('.upd-apar-defs-container');
    tbody = containers.first().children('table').children('tbody');
    script_element = containers.first().children('script');

    /*
     * The code in here is used only for the class='upd_apar_defs'
     * table.  If the page does not have that table, then we just want
     * to exit.  Otherwise, we get various javascript errors.
     */
    if (tbody.length === 0 || script_element.length === 0) {
	return;
    }

    currentLocationArray = currentLocation.split('/');
    pageIndex = currentLocationArray.length - 1;
    sortIndex = pageIndex - 1;
    lastPage = parseInt(currentLocationArray[pageIndex]);
    
    /*
     * Decorate header with the up and down arrows to indicate how the
     * table is sorted
     */
    sortOrder = currentLocationArray[sortIndex].replace(/%20/g, ' ').split(/, */)
	.map(function (column, index) {
	    var prefix;
	    var dir;
	    var klass;
		
	    if (column[0] == "-") {
		prefix = "-";
		dir = "sort-down";
		column = column.slice(1);
	    } else {
		prefix = "";
		dir = "sort-up";
	    }
	    klass = 'upd_apar_def-' + column;
	    $('th.' + klass + ' .sort')
		.removeClass('sortable')
		.addClass(dir)
		.addClass('sort-pos-' + (index + 1));
	    return {
		prefix: prefix,
		column: column
	    };
	});
    
    $('.upd_apar_defs')
	.on('click', '.upd_apar_def_inner_td_span', thisThis.click)
	.on('click', '.upd_apar_defs_header_span', thisThis.alterSort);
    $window.on('scroll', thisThis.myScrollFunction);
    tbody.html($.render.upd_apar_def_row({items: JSON.parse(script_element[0].text), offset: 1}));
    return this;
};

$(document).ready(function () {
    new condor3.UpdAparDef(window.location.href);
});
