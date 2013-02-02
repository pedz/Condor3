/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

/*
 * Copy the routes created by js-routes to be helpers.  Somehow,
 * putting them directly into helpers at build time causes problems --
 * at least during testing.
 */
(function () {
    var routes = condor3.routes;
    Object.getOwnPropertyNames(routes).forEach(function (propName) {
	var prop = routes[propName];

	if (typeof prop === 'function') {
	    var t = {};
	    /*
	     * I decided to wrapper all of these because if a null is
	     * passed to the js-route routines, they throw an error.
	     * While that is bad, I don't want errors thrown.
	     */
	    t[propName] = function route_wrapper() {
		if (arguments.length < 1 || arguments[0] == false)
		    return "#"
		else
		    return prop.apply(this, arguments);
	    };
	    $.views.helpers(t);
	}
    });
    return true;
})();
