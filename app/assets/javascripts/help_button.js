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
 * 
 */

$(document).ready(function () {
    var helps = $('.help');

    /* No helps on this page */
    if (help_button.length === 0)
	return;
    
    /*
     * Hook up the click on all the help-button's within the help's
     */
    $('.help-button', help_button).on('click');
});
