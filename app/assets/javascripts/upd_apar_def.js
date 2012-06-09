$(document).ready(function () {
    var upd_apar_defs_click = function (event) {
	// 'this' will be the tr which is the same as event.currentTarget
	var ui = $($(this).find('.upd_apar_def_commands'));
	var tbl;
	var ui_width;
	var tbl_right_edge;
	var ui_right_edge;

	// The width can change if the position is far right and
	// causes the box to reform.  So, we absolutely position it at
	// 0,0 and takes its width at that position.
	ui.show();
	ui.css({
	    top: '0px',
	    left: '0px'
	});
	ui_width = ui.outerWidth(true);

	// Now position the ui at the mounse point.
	ui.css({
	    top: event.pageY,
	    left: event.pageX
	});
	
	// Reposition it if the right edge is outside of the table
	tbl = ui.parents('.upd_apar_defs');
	tbl_right_edge = tbl.offset().left + tbl.innerWidth();
	ui_right_edge = ui.offset().left + ui_width;
	if (ui_right_edge > tbl_right_edge) {
	    var new_left = (tbl_right_edge - ui_width);
	    ui.css('left',  new_left + 'px');
	}
	return false;
    };

    $('.upd_apar_defs').on('click', 'tbody tr', upd_apar_defs_click);

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
    }).fail(function (a, b, c) {
	alert('Someone is really unhappy');
    });
});
