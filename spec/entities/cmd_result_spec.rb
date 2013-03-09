# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe CmdResult do
  it "should store what is passed" do
    cmd_result = CmdResult.new(stdout: "Out",
                               stderr: "Err",
                               rc: 1,
                               signal: "HUP")
    cmd_result.stdout.should eq("Out")
    cmd_result.stderr.should eq("Err")
    cmd_result.rc.should eq(1)
    cmd_result.signal.should eq("HUP")
  end

  it_should_behave_like "a cmd_result" do
    let(:cmd_result ) { CmdResult.new }
  end

  it "should set non-specified options to nil" do
    cmd_result = CmdResult.new
    cmd_result.stdout.should be_nil
    cmd_result.stderr.should be_nil
    cmd_result.rc.should be_nil
    cmd_result.signal.should be_nil
  end

  it "should set rc to 0 if only stdout is specified" do
    cmd_result = CmdResult.new(stdout: "All is well")
    cmd_result.stdout.should eq("All is well")
    cmd_result.rc.should eq(0)
  end

  it "should set rc to 1 if only stderr is specified" do
    cmd_result = CmdResult.new(stderr: "Bad Doggy")
    cmd_result.stderr.should eq("Bad Doggy")
    cmd_result.rc.should eq(1)
  end

  it "should set rc to -1 if rc is not set and signal is set" do
    cmd_result = CmdResult.new(signal: 'SIGHUP')
    cmd_result.rc.should eq(-1)
  end

  it "should set stderr to a message if signal is set and stderr is not set" do
    cmd_result = CmdResult.new(signal: 'SIGHUP')
    cmd_result.stderr.should_not be_blank
  end
end
