
$.views.helpers({
    swinfo_path: function (a) {
	if (a) {
	    return condor3.routes.swinfo_full_path(a , 'defect, apar, ptf', 1);
	} else {
	    return "#";
	}
    },

    test_path: function (a) {
	return "test";
    }
});
