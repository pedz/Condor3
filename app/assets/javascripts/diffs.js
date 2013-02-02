/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

var diffControl = function () {
    var curr_diff = 0;

    function show_thing(element) {
	var container = element.parent();
	var containerTop = container.position().top;
	// The elementTop moves by the amount of the scollTop
	var elementTop = element.position().top + container.scrollTop();
	// Where we want the element to end up.
	var objective = containerTop + container.height() / 2;
	container.scrollTop(elementTop - objective);
    }

    function show_pair(idx) {
	var top = $("#diff-top-" + idx);
	var bot = $("#diff-bot-" + idx);
	if ((top.length > 0) && (bot.length > 0)) {
	    show_thing(top);
	    show_thing(bot);
	    $("#hunk-index").html(idx);
	    curr_diff = idx;
	}
    }

    return {
	next: function () {
	    show_pair(curr_diff + 1);
	},

	prev: function () {
	    show_pair(curr_diff - 1);
	},

	init: function() {
	    show_pair(1);
	}
    };
}();

$(document).ready(function () {
    $('.diffs button').button();
    $('#next-diff').click(diffControl.next);
    $('#prev-diff').click(diffControl.prev);
    diffControl.init();
});
