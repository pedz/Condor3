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
	

	// ui.show();
	// ui.css({
	//     bottom: -ui.outerHeight(),
	//     left: link.width() - ui.width()
	// });

	// var ui = $($(this).find('.upd_apar_def_commands'));
	// console.log(ui);
	// ui.menu();
	// ui.show();
	// var tbl = ui.parents('.upd_apar_defs');
	// ui.pedzConextMenu({
	//     top: event.pageY,
	//     left: event.pageX,
	//     container: tbl
	// });
	return false;
    };

    var currentLocation = window.location.href;
    var bumpPage = function () {
	var slash = currentLocation.lastIndexOf("/") + 1;
	currentLocation =
	    currentLocation.substring(0, slash).concat(parseInt(currentLocation.substring(slash)) + 1);
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
	    bumpPage();
	    $.when( $.get(currentLocation + ".json", null, null, 'json') )
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

    $('.upd_apar_defs').on('click', '.upd_apar_def_span', upd_apar_defs_click);
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
	/*
	 * Fix all the down arrows to be positioned just right
	 */
	// $('.upd_apar_def_span').each(function () {
	//     var span = $(this);
	//     var link = span.prev();
	//     span.css('left', link.width() - 3);
	// });
    }).fail(function (a, b, c) {
	alert('Someone is really unhappy');
    });
});
