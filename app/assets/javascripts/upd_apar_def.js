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

    $('.upd_apar_defs').on('click', '.upd_apar_def_span', upd_apar_defs_click);

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
	$('.upd_apar_defs tbody').html($.render.template1(json_elements.items));
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
