(function($, undefined) {

    var trace = function (args) {
	if (false) {
	    console.log.apply(console, arguments);
	}
    };

    $.widget("pedz.overlay", {
	options: {
	    'z-index': 1000,
	    autoOpen: true
	},

	_init: function () {
	    trace(this.widgetName, '_init', this);
	    if (this.options.autoOpen)
		this.open();
	},

	_create: function () {
	    trace(this.widgetName, '_create', this);
	    this.$el = $('<div></div>');
	},

	widget: function () {
	    return this.$el;
	},

	open: function () {
	    trace(this.widgetName, 'open', this);
	    this.$el.addClass('pedz-overlay')
		.appendTo(document.body)
		.css({
		    position:  'absolute',
		    top:       0,
		    left:      0,
		    width:     $(document.body).width(),
		    height:    $(document.body).height(),
		    'z-index': this.options['z-index']
		}).on('click', this, this.hit);
	},

	close: function (event) {
	    trace(this.widgetName, 'close', this);
	    if (this.closing) {
		return;
	    }
	    this.closing = true;
	    this.$el
		.removeClass('pedz-overlay')
		.remove();
	    this._trigger('close');
	    this.closing = undefined;
	},

	hit: function (event) {
	    var self = event.data;
	    trace(self.widgetName, 'hit', event, this);
	    self._trigger('hit', event);
	}
    });

    $.widget("pedz.contextMenu", {
	options: { 	autoClose:  true,	// close when user clicks outside
			bottom:     '0px',	// bottom of where ui should be placed
			container:  null,	// container ui needs to be within
			left:       '0px',	// left of where ui should be placed
			position:   'absolute',	// how ui should be positioned
			'z-index':  1000	// z-index of ui and its children
		 },

	_init: function () {
	    trace(this.widgetName, '_init', this);
	    this.open();
	},

	_create: function () {
	    trace(this.widgetName, '_create', this);
	    this.element.overlay({
		'z-index': this.options['z-index'] - 1,
		autoOpen: false })
	    .on('overlayhit', this, this._hit)
	    .on('overlayclose', this, this._close);
	},

	_hit: function (event) {
	    var self = event.data;
	    trace(self.widgetName, '_hit', event);
	    if (self.options.autoClose)
		self.close(event);
	},

	open: function () {
	    trace(this.widgetName, 'open', this);
	    var options = this.options;

	    this.element.css({
		bottom:    options.bottom,
		left:      options.left,
		position:  options.position,
		'z-index': options['z-index']
	    })
		.show();
	    this.element.overlay('open');
	},

	_close: function (event) {
	    var self = event.data;
	    trace(self.widgetName, '_close', this);
	    self.close(event);
	},

	close: function (event) {
	    trace(this.widgetName, 'close', this);
	    if (this.closing) {
		trace(this.widgetName, 'close returning', this);
		return;
	    }
	    this.closing = true;
	    this.element.hide();
	    this.element.overlay('close');
	    this._trigger('close');
	    this.closing = undefined;
	}
    });
})(jQuery);
