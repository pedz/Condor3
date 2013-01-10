
/*
 * Copy the routes created by js-routes to be helpers.  Somehow,
 * putting them directly into helpers at build time causes problems --
 * at least during testing.
 */
(function () {
    /*
     * If this is done during load time, something screws up so do it
     * on the ready event.
     */
    var routes = condor3.routes;
    Object.getOwnPropertyNames(routes).forEach(function (propName) {
	var prop = routes[propName];

	if (typeof prop === 'function') {
	    $.views.helpers({ propName: prop });
	}
    });
    return true;
})();
