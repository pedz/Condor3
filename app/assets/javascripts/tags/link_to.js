
$.templates({
  link_template: "<a href='{{:link}}' class='{{:klass}}'>{{:text}}</a>"
});

$.views.tags({
    link_to: function (link, klass, text) {
	return $.render.link_template({link: link, klass: klass, text: text});
    }
});
