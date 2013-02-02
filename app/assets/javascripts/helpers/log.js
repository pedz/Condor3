/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

$.views.helpers({
    /*
     * A helper function called ~log('whatever') that returns an empty
     * string and prints the argument to Firebug's console
     */
    log: function(a) {
	console.log(a);
	return "";
    }
});
