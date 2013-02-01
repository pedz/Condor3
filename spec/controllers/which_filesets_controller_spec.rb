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
      which_fileset = double('which_fileset')
      options = { path: 'msnentdd' }
      WhichFileset.stub(:new) do |args|
        args.symbolize_keys.should eq(options.merge(controller: 'which_filesets', action: 'show'))
        which_fileset
      end
      controller.stub(:create_presenter)
      get :show, options
    end
  end
end
