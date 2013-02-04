#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
shared_examples_for "a controller" do
  let(:controller_name) { controller.class.name.sub('Controller', '').underscore }
  
  describe "POST actions" do
    it "should redirect to the full path" do
      post :create, post_options
      response.should redirect_to(full_options.merge(controller: controller_name, action: 'show'))
    end
  end

  describe "GET actions when given a complete set of options" do
    it "should create a new model with the params" do
      dbl = double(controller_name.singularize)
      model.stub(:new) do |args|
        args.symbolize_keys.should eq(full_options.merge(controller: controller_name, action: 'show'))
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
