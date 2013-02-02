#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
module Sprockets
  module JSRender
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
