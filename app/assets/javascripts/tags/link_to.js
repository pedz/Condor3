/* -*- coding: utf-8 -*-
 *
 * Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 * All Rights Reserved
 *
 */

$.templates({
  link_template: "<a href='{{:link}}' class='{{:klass}}'>{{:text}}</a>"
});

$.views.tags({
    link_to: function (link, klass, text) {
	return $.render.link_template({link: link, klass: klass, text: text});
    }
});
