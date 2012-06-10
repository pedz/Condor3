(function($, undefined) {
    var currentConextMenu = undefined;
    var hideContextMenu = function () {
	if (currentConextMenu)
	    currentConextMenu.hide();
	currentConextMenu = undefined;
	$('body').off('click.pedzConextMenu');
    };

    $.fn.pedzConextMenu = function (options) {
	var settings = {};
	$.extend(settings, this.pedzConextMenu.defaults, options);
	
	// 'this' will be the tr which is the same as event.currentTarget
	var ui = this;
	var container = settings.container;
	var ui_width;
	var ui_height;

	hideContextMenu();
	ui.show();
	if (container) {
	    /*
	     * The dimensions can change if the position is far right
	     * or far down and causes the box to reform.  So, we
	     * absolutely position it at 0,0 and takes its width and
	     * height at that position.
	     */
	    ui.css({
		top: '0px',
		left: '0px'
	    });
	    ui_width = ui.outerWidth(true);
	    ui_height = ui.outerHeight(true);
	}

	// Now position the ui at what the user wants.  Note that top
	// and left might have dimensions.
	ui.css({
	    top: settings.top,
	    left: settings.left
	});
	
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
		    'left':  new_left + 'px',
		    'top': new_top + 'px'
		});
	    }
	}
	
	/*
	 * Hook in so that a click somewhere else will make the
         * context menu disappear.
	 */
	$('body').on('click.pedzConextMenu', hideContextMenu);
	currentConextMenu = ui;

	return this;
    };

    $.fn.pedzConextMenu.defaults = {
    };

})(jQuery);
