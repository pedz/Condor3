#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
shared_examples_for "a controller" do
  let(:controller_name) { controller.class.name.sub('Controller', '').underscore }
  
  describe "POST actions" do
    it "should require authentication" do
      unless post_options.nil?
        allow(controller).to receive(:authenticate).and_call_original
        post :create, post_options
        expect(response).to_not be_success
      end
    end

    it "should redirect to the full path" do
      unless post_options.nil?
        post :create, post_options
        expect(response).to redirect_to(full_options.merge(controller: controller_name, action: 'show'))
      end
    end
  end

  describe "GET actions when given a complete set of options" do
    it "should require authentication" do
      allow(controller).to receive(:authenticate).and_call_original
      allow(controller).to receive(:authenticate).and_call_original
      get :show, full_options
      expect(response).to_not be_success
    end

    it "should create a new model with the params" do
      allow(model).to receive(:new) do |args|
        expect(args.symbolize_keys).to include(full_options.merge(controller: controller_name, action: 'show'))
        double(controller_name.singularize)
      end
      allow(controller).to receive(:create_presenter)
      get :show, full_options
    end
    
    it "should add a lambda ':get_user' to params" do
      allow(model).to receive(:new) do |args|
        expect(args).to include(:get_user)
        expect(args[:get_user]).to be_a(Proc)
        double(controller_name.singularize)
      end
      allow(controller).to receive(:create_presenter)
      get :show, full_options
    end
    
    it "should pass the new model to create_presenter" do
      dbl = double(controller_name.singularize)
      allow(model).to receive(:new).and_return(dbl)
      expect(controller).to receive(:create_presenter).with(presenter, dbl)
      get :show, full_options
    end
  end
end
