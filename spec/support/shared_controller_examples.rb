#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
shared_examples_for "a controller" do
  let(:controller_name) { controller.class.name.sub('Controller', '').underscore }
  
  describe "POST actions" do
    it "should require authentication" do
      controller.unstub(:authenticate)
      post :create, post_options
      response.should_not be_success
    end

    it "should redirect to the full path" do
      post :create, post_options
      response.should redirect_to(full_options.merge(controller: controller_name, action: 'show'))
    end
  end

  describe "GET actions when given a complete set of options" do
    it "should require authentication" do
      controller.unstub(:authenticate)
      get :show, full_options
      response.should_not be_success
    end

    it "should create a new model with the params" do
      dbl = double(controller_name.singularize)
      model.stub(:new) do |args|
        args.symbolize_keys.should include(full_options.merge(controller: controller_name, action: 'show'))
        dbl
      end
      controller.stub(:create_presenter)
      get :show, full_options
    end
    
    it "should add a lambda ':get_user' to params" do
      dbl = double(controller_name.singularize)
      model.stub(:new) do |args|
        args.should include(:get_user)
        args[:get_user].should be_a(Proc)
        dbl
      end
      controller.stub(:create_presenter)
      get :show, full_options
    end
    
    it "should pass the new model to create_presenter" do
      dbl = double(controller_name.singularize)
      model.stub(:new).and_return(dbl)
      controller.stub(:create_presenter).with(presenter, dbl)
      get :show, full_options
    end
  end
end
