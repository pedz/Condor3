$(document).ready(function () {
    var upd_apar_defs_click = function (event) {
	var ui = $($(this).find('.upd_apar_def_commands'));
	console.log(ui);
	ui.menu();
	ui.show();
	// var tbl = ui.parents('.upd_apar_defs');
	// ui.pedzConextMenu({
	//     top: event.pageY,
	//     left: event.pageX,
	//     container: tbl
	// });
	return false;
    };

    var upd_apar_defs_setup_dual_button = function () {
	var td = $(this);
	var buttons = td.find('button');
	var link = $(buttons[0]);
	var menu = $(buttons[1]);

	link.button();
	menu.button({
	    text: false,
	    icons: {
		primary: "ui-icon-triangle-1-s"
	    }
	});
	td.buttonset();
    };

    // $('.upd_apar_defs').on('click', 'tbody tr', upd_apar_defs_click);

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
	$('.upd_apar_def_dual_button').each(upd_apar_defs_setup_dual_button);
    }).fail(function (a, b, c) {
	alert('Someone is really unhappy');
    });
});
