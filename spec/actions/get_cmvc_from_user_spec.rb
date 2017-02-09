# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetCmvcFromUser do
  it_should_behave_like "a get_cmvc_from_user" do
    let(:get_cmvc_from_user) { GetCmvcFromUser.new }
  end

  it "should error off when no get_user option supplied" do
    get_cmvc_from_user = GetCmvcFromUser.new
    expect(get_cmvc_from_user.rc).to eq(1)
    expect(get_cmvc_from_user.stderr).to match(/Exception encountered when fetching user/)
  end

  it "should error off when get_user option returns nil" do
    get_cmvc_from_user = GetCmvcFromUser.new get_user: -> { nil }
    expect(get_cmvc_from_user.rc).to eq(1)
    expect(get_cmvc_from_user.stderr).to eq("User not found")
  end

  it "should error off when get_user raises an exception" do
    get_cmvc_from_user = GetCmvcFromUser.new get_user: -> { raise "a hullabaloo" }
    expect(get_cmvc_from_user.rc).to eq(1)
    expect(get_cmvc_from_user.stderr).to match(/Exception encountered when fetching user/)
  end

  context "with a get_user option producing a complete user" do
    get_user_proc = -> { Struct.new(:cmvc_login).new("test_user") }
    the_passed_in "get_user option" do
      let(:get_user) { get_user_proc }
    end

    it "should set rc = 0 and stdout to the cmvc user when user model has valid cmvc" do
      get_cmvc_from_user = GetCmvcFromUser.new get_user: get_user_proc
      expect(get_cmvc_from_user.rc).to eq(0)
      expect(get_cmvc_from_user.stdout).to eq("test_user")
    end
  end

  it "should fail if ldap for user returns null" do
    get_cmvc_from_user = GetCmvcFromUser.new get_user: -> do
      Struct.new(:cmvc_login, :ldap).new(nil, nil)
    end
    expect(get_cmvc_from_user.rc).to eq(1)
    expect(get_cmvc_from_user.stderr).to eq("User does not have LDAP entry")
  end

  context "ldap of the user model" do
    it "should fail if ldap for user does not respond to attribute_present?" do
      get_user_proc = -> do
        ldap = Struct.new(:joe).new(nil)
        Struct.new(:cmvc_login, :ldap).new(nil, ldap)
      end
      get_cmvc_from_user = GetCmvcFromUser.new( get_user: get_user_proc)
      expect(get_cmvc_from_user.rc).to eq(1)
      expect(get_cmvc_from_user.stderr).to eq("User's uid field in LDAP is blank or missing")
    end

    it "should fail if ldap for user does not have a uid attribute" do
      get_user_proc = -> do
        allow(ldap = double("ldap")).to receive(:attribute_present?) { false }
        Struct.new(:cmvc_login, :ldap).new(nil, ldap)
      end
      get_cmvc_from_user = GetCmvcFromUser.new(get_user: get_user_proc)
      expect(get_cmvc_from_user.rc).to eq(1)
      expect(get_cmvc_from_user.stderr).to eq("User's uid field in LDAP is blank or missing")
    end

    it "should fail if ldap for user does not have a uid" do
      get_user_proc = -> do
        ldap = double("ldap").tap do |l|
          allow(l).to receive(:attribute_present?) { true }
          allow(l).to receive(:uid) { nil }
        end
        Struct.new(:cmvc_login, :ldap).new(nil, ldap)
      end
      get_cmvc_from_user = GetCmvcFromUser.new(get_user: get_user_proc)
      expect(get_cmvc_from_user.rc).to eq(1)
      expect(get_cmvc_from_user.stderr).to eq("User's uid field in LDAP is blank or missing")
    end

    it "should fail if ldap for user has a uid but is blank" do
      get_user_proc = -> do
        ldap = double("ldap").tap do |l|
          allow(l).to receive(:attribute_present?) { true }
          allow(l).to receive(:uid) { " " }
        end
        Struct.new(:cmvc_login, :ldap).new(nil, ldap)
      end
      get_cmvc_from_user = GetCmvcFromUser.new(get_user: get_user_proc)
      expect(get_cmvc_from_user.rc).to eq(1)
      expect(get_cmvc_from_user.stderr).to eq("User's uid field in LDAP is blank or missing")
    end
  end

  it "should fail if CmvcHost::BootstrapCmvcUser is blank" do
    stub_const("CmvcHost::BootstrapCmvcUser", " ")
    get_user_proc = -> do
        ldap = double("ldap").tap do |l|
          allow(l).to receive(:attribute_present?) { true }
          allow(l).to receive(:uid) { "123" }
        end
      Struct.new(:cmvc_login, :ldap).new(nil, ldap)
    end
    get_cmvc_from_user = GetCmvcFromUser.new(get_user: get_user_proc)
    expect(get_cmvc_from_user.rc).to eq(1)
    expect(get_cmvc_from_user.stderr).to eq("No bootstrap CMVC user set up")
  end

  context "with valid arguments" do
    before(:each) do
      @rc = 0
      @execute_cmvc_command_class = double("execute_cmvc_command_class").tap do |e|
        allow(e).to receive(:new) do |options|
          @options = options
          Struct.new(:stdout, :stderr, :rc, :signal).new("test_user", "stderr", @rc, "signal")
        end
      end
      
      @ldap = double("ldap").tap do |l|
        allow(l).to receive(:attribute_present?) { true }
        allow(l).to receive(:uid) { "123" }
      end
      @user_temp = Struct.new(:cmvc_login, :ldap).new(nil, @ldap)
      @get_user_proc = -> do
        @user_temp
      end
    end

    context "with good return from execute_cmvc_command" do
      before(:each) do
        @get_cmvc_from_user = GetCmvcFromUser.new(get_user: @get_user_proc,
                                                  execute_cmvc_command: @execute_cmvc_command_class)
      end

      the_passed_in "get_user option" do
        let(:get_user) { @options[:get_user] }
      end
    
      it "should return values from the execute_cmvc_command" do
        expect(@get_cmvc_from_user.rc).to eq(0)
        expect(@get_cmvc_from_user.stdout).to eq("test_user")
        expect(@get_cmvc_from_user.stderr).to eq("stderr")
        expect(@get_cmvc_from_user.signal).to eq("signal")
      end
    
      it "should assign stdout to cmvc_login" do
        expect(@user_temp.cmvc_login).to eq("test_user")
      end
    end

    context "with bad return from execute_cmvc_command" do
      before(:each) do
        @rc = 1
        @get_cmvc_from_user = GetCmvcFromUser.new(get_user: @get_user_proc,
                                                  execute_cmvc_command: @execute_cmvc_command_class)
      end

      the_passed_in "get_user option" do
        let(:get_user) { @options[:get_user] }
      end

      it "should return values from the execute_cmvc_command" do
        expect(@get_cmvc_from_user.rc).to eq(1)
        expect(@get_cmvc_from_user.stdout).to eq("test_user")
        expect(@get_cmvc_from_user.stderr).to eq("stderr")
        expect(@get_cmvc_from_user.signal).to eq("signal")
      end
    
      it "should not assign stdout to cmvc_login" do
        expect(@user_temp.cmvc_login).to be_nil
      end
    end
  end
end
