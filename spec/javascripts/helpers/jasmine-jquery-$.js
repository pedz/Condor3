(function ($, undefined) {
    var original_$ = $;		// the original $
    var $window;
    var $document;
    var spy_$;			// the spy of $
    var spy_list = [];

    function my_$() {
	var args = arguments;
	var new_$;

	if (args[0] === window) {
	    new_$ = $window;
	} else if (args[0] === document) {
	    new_$ = $document;
	}

	if (!new_$) {
	    new_$ = original_$.apply(this, args);
	    spy_list.forEach(function (proxy) {
		if (proxy.pattern == args[0]) {
		    proxy.spy = spyOn(new_$, proxy.func);
		    if (proxy.addon !== undefined) {
			proxy.spy[proxy.addon].call(proxy.spy, proxy.arg);
		    }
		};
	    });
	}

	if (args[0] === window) {
	    $window = new_$;
	    global_j_w = $window;
	} else if (args[0] === document) {
	    $document = new_$;
	}

	return new_$;
    };

    function spy_proxy(pattern, func) {
	this.pattern = pattern;
	this.func = func;
	this.spy = undefined;
	this.addon = undefined;
	this.arg = undefined;
	return this;
    };

    spy_proxy.prototype = {
	andCallThrough: function (empty) {
	    this.addon = 'andCallThrough';
	    this.arg = empty;
	    return this;
	},

	andReturn: function(value) {
	    this.addon = 'andReturn';
	    this.arg = value;
	    return this;
	},

	andThrow: function(exceptionMsg) {
	    this.addon = 'andThrow';
	    this.arg = exceptionMsg;
	    return this;
	},

	andCallFake: function (func) {
	    this.addon = 'andCallFake';
	    this.arg = func;
	    return this;
	}
    };

    function spy$(pattern, func) {
	var proxy = new spy_proxy(pattern, func);

	mock_$();
	spy_list.push(proxy);
	return proxy;
    };

    function mock_$() {
	if (spy_$) {
	    return;
	}

	spy_$ = spyOn(window, '$');
	Object.getOwnPropertyNames(original_$).forEach(function (prop) {
	    spy_$[prop] = original_$[prop];
	});
	spy_$.andCallFake(my_$);
    };

    function unmock_$() {
	if (spy_$) {
	    $ = original_$;
	    spy_$ = undefined;
	    $window = undefined;
	    $document = undefined;
	    spy_list = [];
	}
    };

    window.mock_$ = mock_$;
    window.unmock_$ = unmock_$;
    window.spy$ = spy$;
})(jQuery);

afterEach(unmock_$);
