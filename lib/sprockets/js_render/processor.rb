#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 


module Sprockets
  module JSRender
    # A Tilt::Template processor mostly stolen from
    # https://github.com/erubboli/sprockets-jsrender
    #
    # This engine processes
    # jsrender[https://github.com/BorisMoore/jsrender] templates files
    # with the jsr suffix such as foo.js.jsr under the
    # app/assets/javascript.  Usually all the templates are placed in
    # app/assets/javascript/templates directory.  The name of the file
    # becomes the name of the template -- one template per file.
    #
    # jsrender tags are usually straight javascript and are place
    # under app/assets/javascript/tags and helper methods are also
    # pure javascript and are placed under
    # app/assets/javascript/helpers.  In both cases, multiple tags can
    # be stored in a single file.
    class Processor < Tilt::Template
      include ActionView::Helpers::JavaScriptHelper

      self.default_mime_type = 'application/javascript'

      def prepare
      end

      def evaluate(scope, locals, &block)
        %Q{$.templates({#{scope.logical_path.sub(/.*\//, "").inspect}: "#{escape_javascript data.gsub(/ *\n+ */, "")}"});}
      end
    end
  end

  Rails.application.assets.register_engine '.jsr', ::Sprockets::JSRender::Processor
end
