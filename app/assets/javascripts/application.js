/*
 * We load the libraries first which includes jsrender and jsviews
 */
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jsviews/jsrender
//= require jsviews/jquery.observable
//= require jsviews/jquery.views
/*
 * We now create the condor3 object
 */
//= require condor3
/*
 * Next we load the routes created by js-routes.
 */
//= require js-routes
/*
 * We can now load our jsrender helpers, tags, and templates.
 */
//= require_directory ./helpers
//= require_directory ./tags
//= require_directory ./templates
/*
 * Finally the rest of our javascript code
 */
//= require jQuery.ui.pedzContextMenu
//= require upd_apar_def
//= require help_button
//= require welcome
//= require diffs
