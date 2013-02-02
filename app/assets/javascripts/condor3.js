/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */
/*
 * This is the first application specific file in application.js.  It
 * comes after jQuery and other global things are loaded but before
 * any other customer js code.
 * 
 * Note that it is possible for condor3 to already be defined due to
 * code inserted into the original page.
 *
 * There is no need to be fancy so just define an empty object for
 * others to put stuff in to.
 */

window['condor3'] = window['condor3'] || {};
