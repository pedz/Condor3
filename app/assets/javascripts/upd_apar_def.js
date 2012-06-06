$(document).ready(function () {
    var upd_apar_defs_contextmenu = function (event) {
	console.log(event);
	var ul = $($(event.target).children()[0]);
	var temp = {
	    top: event.pageY,
	    left: event.pageX
	};
	console.log(temp);
	ul.css(temp);
	ul.show();
	return false;
    };

    $('.upd_apar_defs').on('contextmenu', 'td', upd_apar_defs_contextmenu);

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
