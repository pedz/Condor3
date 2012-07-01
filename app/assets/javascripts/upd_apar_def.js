
$.views.tags({
    link_to: function (link, klass, text) {
	return $.render.template2({link: link, klass: klass, text: text});
    }
});

$(document).ready(function () {
    /* Called from an event */
    var upd_apar_defs_click = function (event) {
	var arrow_span = $(this);
	var td = arrow_span.parents('td');
	var ui = td.find('.upd_apar_def_commands');
	var link = td.find('.upd_apar_def_link');

	arrow_span.hide();
	ui.pedzConextMenu({
	    close_hook: function () { arrow_span.show(); },
	    bottom: -ui.outerHeight(),
	    left: link.width() - ui.width()
	}).on('click', 'li', function () {
	    console.log(this);
	});
	return false;
    };

    var currentLocation = window.location.href;
    var currentLocationArray = currentLocation.split('/');
    var pageIndex = currentLocationArray.length - 1;
    var sortIndex = pageIndex - 1;
    var lastPage = parseInt(currentLocationArray[pageIndex]);

    /*
     * Decorate header with the up and down arrows to indicate how the
     * table is sorted
     */
    var sortOrder = currentLocationArray[sortIndex].replace(/%20/g, ' ').split(/, */)
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

    /*
     * Return the URL for next page that we need to fetch
     */
    var xjxjxjxj = function () {
	var tmp;
	lastPage += 1;
	tmp =  currentLocationArray.slice(0, pageIndex);
	tmp.push(lastPage);
	return tmp.join('/') + '.json';
    };

    var myScrollFunction = function (event) {
	var wh = $(window).height();
	var ds = $(document).scrollTop();
	var tr = $('table.upd_apar_defs tbody tr');
	tr = $(tr[tr.length - 1]);
	var h = tr.height();
	var o = tr.offset();
	var top = o.top;

	if ((ds + wh) > (top - (100 * h))) {
	    console.log('trigger');
	    $(window).off('scroll', myScrollFunction);
	    $.when( $.get(xjxjxjxj(), null, null, 'json') )
		.done(function (data, status, jqXHR) {
		    console.log(data.length);
		    /* reached the end of the data */
		    if (data.length == 0)
			return;
		    
		    var offset = $('.upd_apar_defs tbody tr').length;
		    $('.upd_apar_defs tbody').append($.render.template1({items: data, offset: offset}));
		    /* Hook back up for next page */
		    $(window).on('scroll', myScrollFunction);
		})
		.fail(function (a, b, c) { alert('Someone is really unhpapy 2'); });
	}
    };

    var alterSort = function(event) {
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
	window.location = urlArray.join('/');
    };

    $('.upd_apar_defs')
	.on('click', '.upd_apar_def_inner_td_span', upd_apar_defs_click)
	.on('click', '.upd_apar_defs_header_span', alterSort);
    $(window).on('scroll', myScrollFunction);

    $.when( $.get('/assets/t1.html', null, null, 'html') ).done(function (data, status, jqXHR) {
	// data is a string.  $(data) turns into an array of HTML
	// elements.  Often it is just one but if we get them ganged
	// into one file, they will be more than one.
	$(data).each(function () {
	    // We assume the outside element is just a container.  I
	    // use a <script> tag but it can be anything I suppose.
	    // The id of the container becomes the template's name
	    // while the contents becomes the template.
	    $.templates(this.id, $(this).html());
	    return this;
	});
	$('.upd_apar_defs tbody').html($.render.template1({items: json_elements.items, offset: 0}));
    }).fail(function (a, b, c) {
	alert('Someone is really unhappy');
    });
});
