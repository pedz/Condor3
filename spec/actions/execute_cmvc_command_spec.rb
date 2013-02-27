# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
require 'spec_helper'

describe ExecuteCmvcCommand do
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

  let(:cmd_result) { double('cmd_result') }
  let(:cmvc_host) { double('cmvc_host') }

  let(:typical_options) { {
      get_cmvc_from_user: get_cmvc_from_user_class,
      cmd_result: cmd_result,
      cmvc_host: cmvc_host
    }
  }

  it "should call cmvc_host with the command string and report back the result" do
    cmd_result.stub(:new) { Struct.new(:stdout, :stderr, :rc, :signal).new("the result", nil, 0, nil) }
    cmvc_host.should_receive(:new).once do |cmd|
      cmd.should be_a(String)
      cmd.should match(/^Blah /)
      cmd.should match(/-become test_user/)
      Struct.new(:stdout, :stderr, :rc, :signal).new("out", nil, 0, nil)
    end
    exec = ExecuteCmvcCommand.new(typical_options.merge(cmd: "Blah"))
    exec.rc.should eq(0)
    exec.stdout.should eq("the result")
  end
end
