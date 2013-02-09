#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe ApplicationController do
  controller do
    def index
    end
  end

  describe "authentication" do
    let(:test_user_id) { 999 }
    let(:test_user_name) { 'test_user' }
    let(:test_user) do
      double("user").tap do |d|
        d.stub(:id) { test_user_id }
        d.stub(:touch)
        d.stub(:ldap_id) { test_user_name }
        d.stub(:ldap_id=) { |arg| arg }
        d.stub(:save!) { true }
      end
    end

    before(:each) do
      controller.unstub(:authenticate)

      # Set up User to catch the call to find
      User.stub(:find) do |first, args|
        first.should eq(:first)
        args.should include(:conditions)
        args[:conditions].should include(id: test_user_id)
        test_user
      end

      User.stub(:find_by_ldap_id) do |args|
        test_user
      end

      controller.stub(:index) do
        controller.params.should include(:get_user)
        user = controller.params[:get_user].call
        user.should eq(test_user)
        controller.render text: "Hello World"
      end
    end

    it "should require authentication" do
      get :index
      response.should_not be_success
    end

    it "should accept REMOTE_USER from environment" do
      request.env['REMOTE_USER'] = test_user_name
      get :index
      response.should be_success
    end

    it "should accept HTTP_X_FORWARDED_USER from environment" do
      request.env['HTTP_X_FORWARDED_USER'] = test_user_name
      get :index
      response.should be_success
    end

    describe "when using http basic authentication" do
      let(:test_user_password) { '12345678' }

      before(:each) do
        request.env['HTTP_AUTHORIZATION'] =
          ActionController::HttpAuthentication::Basic.encode_credentials(test_user_name, test_user_password)
      end

      it "should pass if ldap authentication passes" do
        LdapUser.stub(:authenticate_from_email).and_return(true)

        get :index
        response.should be_success
      end

      it "should fail if ldap authentication fails" do
        LdapUser.stub(:authenticate_from_email).and_return(false)
        get :index
        response.should_not be_success
      end
    end

    describe "when a session is present" do
      before(:each) do
        session[:user_name] = test_user_name
        session[:authenticated] = true
        session[:user_id] = test_user_id
        session[:tod] = 5.minutes.ago
      end

      it "should accept a valid session" do
        get :index
        response.should be_success
      end

      it "should reject a stale session" do
        session[:tod] = 5.days.ago
        get :index
        response.should_not be_success
      end
    end

    it "should create a new user if necessary" do
      User.stub(:find_by_ldap_id) { nil }
      User.stub(:new) { test_user }
      request.env['HTTP_X_FORWARDED_USER'] = test_user_name
      get :index
      response.should be_success
    end
  end
end
