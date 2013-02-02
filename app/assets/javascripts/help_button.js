/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */
/*
 * Each page has a help button.  This is the javascript that drives
 * it.  Currently layout is:
 *
 *  <h3 class='help'>
 *    <span class='help-button'>Help ...</span>
 *    <div class='help-text' style='display: none;'>
 *      <%= @help_text %>
 *    </div>
 *  </h3>
 *
 * Note: I thought this would be more complex than it is
 * currently. But I reverted back to using jquery-ui widets instead of
 * rolling my own and so this got a ton simpler.
 */

$(document).ready(function () {
    $('.home-button').button();
});

$(document).ready(function () {
    $('.help-button').button().click(function () {
	$('.help-text').dialog({
	    modal: true,
	    width: ($(window).innerWidth() / 2),
	    height: ($(window).innerHeight() / 2),
	    resizable: true,
	    draggable: true
	});
    });
});
