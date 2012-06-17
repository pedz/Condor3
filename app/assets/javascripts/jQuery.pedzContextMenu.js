(function($, undefined) {
    var name = 'pedzConextMenu';

    var currentConextMenu = undefined;

    var hideContextMenu = function () {
	if (currentConextMenu) {
	    var settings = $.data(currentConextMenu, name);
	    currentConextMenu.hide();
	    if (settings && settings.overlay)
		$.fn.pedzConextMenu.overlay.prototype.close(settings.overlay);
	    if (settings && settings.close_hook)
		settings.close_hook.call(currentConextMenu);
	}
	currentConextMenu = undefined;
    };

    $.fn.pedzConextMenu = function (options) {
	var settings = $.data(this, name) || {};
	$.extend(settings, this.pedzConextMenu.defaults, options);
	$.data(this, name, settings);

	var ui = this;
	var container = settings.container;
	var ui_width;
	var ui_height;

	hideContextMenu();
	ui.show();
	/*
	 * I've not tested using a container recently.  The code
         * assumes the top and left of the ui are within the container
         * and are not checked.  I'm sure there are various other
         * issues.
	 */
	if (container) {
	    /*
	     * The dimensions can change if the position is far right
	     * or far down and causes the box to reform.  So, we
	     * absolutely position it at 0,0 and takes its width and
	     * height at that position.
	     */
	    ui.css({
		bottom: '0px',
		left:   '0px'
	    });
	    ui_width = ui.outerWidth(true);
	    ui_height = ui.outerHeight(true);
	}

	// Now position the ui at what the user wants.  Note that bottom
	// and left might have dimensions.
	ui.css({
	    bottom:    settings.bottom,
	    left:      settings.left,
	    position:  settings.position,
	    'z-index': settings['z-index']
	});
	
	/* See comment above about container */
	if (container) {
	    var container_right_edge = container.offset().left + container.innerWidth();
	    var container_bottom_edge = container.offset().top + container.innerHeight();
	    var ui_offset = ui.offset();
	    var new_left = ui_offset.left;
	    var new_top = ui_offset.top;
	    var ui_right_edge = new_left + ui_width;
	    var ui_bottom_edge = new_top + ui_height;
	    var changed = false;

	    // Reposition it if the right edge is outside of the table
	    if (ui_right_edge > container_right_edge) {
		new_left = (container_right_edge - ui_width);
		changed = true;
	    }
	    
	    if (ui_bottom_edge > container_bottom_edge) {
		new_top = (container_bottom_edge - ui_height);
		changed = true;
	    }

	    if (changed) {
		ui.css({
		    'left': new_left + 'px',
		    'top': new_top + 'px'
		});
	    }
	}
	
	settings.overlay = new $.fn.pedzConextMenu.overlay(settings);

	/*
	 * Hook in so that a click somewhere else will make the
         * context menu disappear.
	 */
	/* $('body').on('click.pedzConextMenu', hideContextMenu); */
	currentConextMenu = ui;

	return this;
    };

    $.fn.pedzConextMenu.defaults = {
	autoClose:  true,	// close when user clicks outside
	bottom:     '0px',	// bottom of where ui should be placed
	close_hook: null,	// called when the ui is closed
	container:  null,	// container ui needs to be within
	left:       '0px',	// left of where ui should be placed
	position:   'absolute',	// how ui should be positioned
	'z-index':  1000	// z-index of ui and its children
    };

    $.fn.pedzConextMenu.overlay = function (settings) {
	$('<div></div>')
	    .addClass('pedz-overlay')
	    .appendTo(document.body)
	    .css({
		position:  'absolute',
		top:       0,
		left:      0,
		width:     $(document.body).width(),
		height:    $(document.body).height(),
		'z-index': settings['z-index'] - 1
	    }).on('click', $.fn.pedzConextMenu.overlay.prototype.close);
    };

    $.fn.pedzConextMenu.overlay.prototype = {
	close: function () {
	    $(this).detach();
	}
    };
})(jQuery);
