#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe WelcomeController do
  let(:controller_name) { controller.class.name.sub('Controller', '').underscore }
  let(:presenter) { :welcome }

  describe "GET index" do
    it "should require authentication" do
      controller.unstub(:authenticate)
      get :index
      response.should_not be_success
    end

    it "should pass the new model to create_presenter" do
      controller.should_receive(:create_presenter).with(presenter)
      get :index
    end
  end
end
