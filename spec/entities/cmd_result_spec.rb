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
    expect(cmd_result.stdout).to eq("Out")
    expect(cmd_result.stderr).to eq("Err")
    expect(cmd_result.rc).to eq(1)
    expect(cmd_result.signal).to eq("HUP")
  end

  it_should_behave_like "a cmd_result" do
    let(:cmd_result ) { CmdResult.new }
  end

  it "should set non-specified options to nil" do
    cmd_result = CmdResult.new
    expect(cmd_result.stdout).to be_nil
    expect(cmd_result.stderr).to be_nil
    expect(cmd_result.rc).to be_nil
    expect(cmd_result.signal).to be_nil
  end

  it "should set rc to 0 if only stdout is specified" do
    cmd_result = CmdResult.new(stdout: "All is well")
    expect(cmd_result.stdout).to eq("All is well")
    expect(cmd_result.rc).to eq(0)
  end

  it "should set rc to 1 if only stderr is specified" do
    cmd_result = CmdResult.new(stderr: "Bad Doggy")
    expect(cmd_result.stderr).to eq("Bad Doggy")
    expect(cmd_result.rc).to eq(1)
  end

  it "should set rc to -1 if rc is not set and signal is set" do
    cmd_result = CmdResult.new(signal: 'SIGHUP')
    expect(cmd_result.rc).to eq(-1)
  end

  it "should set stderr to a message if signal is set and stderr is not set" do
    cmd_result = CmdResult.new(signal: 'SIGHUP')
    expect(cmd_result.stderr).to_not be_blank
  end
end
