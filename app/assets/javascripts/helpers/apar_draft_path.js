/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

$.views.helpers({
    apar_draft_path: function (search_type, search_arg) {
	return "https://amt.aus.stglabs.ibm.com/cgi-bin/secure_aparmgt?search_type=" +
	    search_type +
	    "&search_arg=" +
	    search_arg +
	    "&ACTION=draft_search";
    }
});
