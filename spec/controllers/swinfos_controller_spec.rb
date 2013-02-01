require 'spec_helper'

describe SwinfosController do
  before(:each) do
    controller.stub(:authenticate) { true }
  end
  
  describe "POST" do
    it "should redirect to the full path" do
      post :create, item: '12345'
      response.should redirect_to(:action => 'show',
                                  :item => '12345',
                                  :sort => ::SwinfosController::DEFAULT_SORT_ORDER,
                                  :page => '1')
    end
  end

  describe "GET" do
    it "should redirect if page is not given" do
      get :show, item: '12345', page: '5'
      response.should redirect_to(:action => 'show',
                                  :item => '12345',
                                  :sort => ::SwinfosController::DEFAULT_SORT_ORDER,
                                  :page => '5')
    end

    it "should redirect if page is not given" do
      get :show, item: '12345', sort: 'cows, love, people'
      response.should redirect_to(:action => 'show',
                                  :item => '12345',
                                  :sort => 'cows, love, people',
                                  :page => '1')
    end

    it "should create a new Swinfo with the params" do
      swinfo = double('swinfo')
      options = { item: '98765', sort: 'first, second, third', page: '400' }
      Swinfo.stub(:new) do |args|
        args.symbolize_keys.should eq(options.merge(controller: 'swinfos', action: 'show'))
        swinfo
      end
      controller.stub(:create_presenter)
      get :show, options
    end

    it "should should pass the new swinfo to create_presenter" do
      options = { item: '98765', sort: 'first, second, third', page: '400' }
      swinfo = Swinfo.new(options)
      Swinfo.stub(:new).and_return(swinfo)
      get :show, options
      controller.stub(:create_presenter).with(swinfo)
      assigns[:presenter].should be_a(SwinfoPresenter)
    end
  end
end
