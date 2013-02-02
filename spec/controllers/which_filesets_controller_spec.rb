#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe WhichFilesetsController do
  before(:each) do
    controller.stub(:authenticate) { true }
  end
  
  describe "POST" do
    it "should redirect to the full path" do
      post :create, path: 'msnentdd'
      response.should redirect_to(action: 'show',
                                  controller: 'which_filesets',
                                  path: 'msnentdd')
    end
  end

  describe "GET" do
    it "should create a new WhichFileset with the params" do
      options = { path: 'msnentdd' }
      which_fileset = double('which_fileset')
      WhichFileset.stub(:new) do |args|
        args.symbolize_keys.should eq(options.merge(controller: 'which_filesets', action: 'show'))
        which_fileset
      end
      controller.stub(:create_presenter)
      get :show, options
    end

    it "should pass the new WhichFileset to create_presenter" do
      options = { path: 'msnentdd'}
      which_fileset = double('which_fileset')
      WhichFileset.stub(:new).and_return(which_fileset)
      controller.stub(:create_presenter).with(which_fileset)
      get :show, options
    end
  end
end
