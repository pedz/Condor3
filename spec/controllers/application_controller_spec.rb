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
        allow(d).to receive(:id) { test_user_id }
        allow(d).to receive(:touch)
        allow(d).to receive(:ldap_id) { test_user_name }
        allow(d).to receive(:ldap_id=) { |arg| arg }
        allow(d).to receive(:save!) { true }
      end
    end

    before(:each) do
      allow(controller).to receive(:authenticate).and_call_original

      # Set up User to catch the call to find
      allow(User).to receive(:find) do |first, args|
        expect(first).to eq(:first)
        expect(args).to include(:conditions)
        expect(args[:conditions]).to include(id: test_user_id)
        test_user
      end

      # And the call to find_by_ldap_id
      allow(User).to receive(:find_by_ldap_id) do |name|
        expect(name).to eq(test_user_name)
        test_user
      end

      # Make sure that get_user param works.  This could be a separate
      # test but may as well ensure that it works in all the various
      # paths
      allow(controller).to receive(:index) do
        expect(controller.params).to include(:get_user)
        expect(controller.params[:get_user]).to be_a(Proc)
        expect(controller.params[:get_user].call).to eq(test_user)
        controller.render text: "Hello World"
      end
    end

    it "should require authentication" do
      get :index
      expect(response).to_not be_success
    end

    it "should accept REMOTE_USER from environment" do
      request.env['REMOTE_USER'] = test_user_name
      get :index
      expect(response).to be_success
    end

    it "should accept HTTP_X_FORWARDED_USER from environment" do
      request.env['HTTP_X_FORWARDED_USER'] = test_user_name
      get :index
      expect(response).to be_success
    end

    describe "when using http basic authentication" do
      let(:test_user_password) { '12345678' }

      before(:each) do
        request.env['HTTP_AUTHORIZATION'] =
          ActionController::HttpAuthentication::Basic.encode_credentials(test_user_name, test_user_password)
      end

      it "should pass if ldap authentication passes" do
        expect(LdapUser).to receive(:authenticate_from_email) do |user, password|
          user == test_user_name && password == test_user_password
        end

        get :index
        expect(response).to be_success
      end

      it "should fail if ldap authentication fails" do
        expect(LdapUser).to receive(:authenticate_from_email).and_return(false)
        get :index
        expect(response).to_not be_success
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
        expect(response).to be_success
      end

      it "should reject a stale session" do
        session[:tod] = 5.days.ago
        get :index
        expect(response).to_not be_success
      end

      it "should reject a session without the authenticated key" do
        session.delete(:authenticated)
        get :index
        expect(response).to_not be_success
      end

      it "should reject a session without the user_id key" do
        session.delete(:user_id)
        get :index
        expect(response).to_not be_success
      end
    end

    it "should create a new user if necessary" do
      expect(User).to receive(:find_by_ldap_id) { nil }
      expect(User).to receive(:new) { test_user }
      request.env['HTTP_X_FORWARDED_USER'] = test_user_name
      get :index
      expect(response).to be_success
    end
  end
end
