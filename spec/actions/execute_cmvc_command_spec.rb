# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
require 'spec_helper'

describe ExecuteCmvcCommand do
  it_should_behave_like "an execute_cmvc_command" do
    let(:execute_cmvc_command) { ExecuteCmvcCommand.new }
  end

  let(:get_cmvc_from_user_class) do
    double('get_cmvc_from_user_class').tap do |d|
      d.stub(:new) {
        Struct.new(:stdout, :stderr, :rc, :signal).new("test_user", nil, 0, nil)
      }
    end
  end
  it_should_behave_like "a get_cmvc_from_user" do
    let(:get_cmvc_from_user) { get_cmvc_from_user_class.new }
  end

  let(:cmd_result_class) do
    double('cmd_result_class').tap do |d|
      d.stub(:new) {
        Struct.new(:stdout, :stderr, :rc, :signal).new("the result", nil, 0, nil)
      }
    end
  end
  it_should_behave_like "a cmd_result" do
    let(:cmd_result ) { cmd_result_class.new }
  end

  let(:cmvc_host_class) do
    double('cmvc_host_class').tap do |d|
      d.stub(:new) do |cmd|
        cmd.should be_a(String)
        cmd.should match(/^Blah /)
        cmd.should match(/-become test_user/)
        Struct.new(:stdout, :stderr, :rc, :signal).new("out", nil, 0, nil)
      end
    end
  end
  it_should_behave_like "a cmvc_host" do
    let(:cmvc_host) { cmvc_host_class.new("Blah -become test_user") }
  end

  let(:typical_options) { {
      get_cmvc_from_user: get_cmvc_from_user_class,
      cmd_result: cmd_result_class,
      cmvc_host: cmvc_host_class
    }
  }

  it "should call cmvc_host with the command string and report back the result" do
    cmvc_host_class.should_receive(:new).once
    exec = ExecuteCmvcCommand.new(typical_options.merge(cmd: "Blah"))
    exec.rc.should eq(0)
    exec.stdout.should eq("the result")
  end
end
