# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetCmvcDefectTextLines do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_execute_cmvc_command) { double('local_execute_cmvc_command')  }

  let(:dummy_get_user) { double('get_user').stub(:call) }

  let(:defect_name) { '123456' }
  let(:typical_options) { {
      get_user: dummy_get_user,
      cache: local_cache,
      execute_cmvc_command: local_execute_cmvc_command,
      cmvc_defect: defect_name
    }
  }

  it "should first request a defect specified by :defect_name" do
    local_execute_cmvc_command.should_receive(:new).once do |options|
      options.should include(cmd: 'Defect', view: defect_name)
      OpenStruct.new(stdout: "Sample", rc: 0)
    end

    rep = GetCmvcDefectTextLines.new(typical_options)
    rep.defect_name.should eq(defect_name)
    rep.lines.should eq("Sample")
  end

  it "should request a feature if the request for the defect returns with an error" do
    local_execute_cmvc_command.should_receive(:new).twice do |options|
      if options[:cmd] == 'Defect'
        options.should include(cmd: 'Defect', view: defect_name)
        ret = OpenStruct.new(stdout: "Bad", rc: 1)
      else
        options.should include(cmd: 'Feature', view: defect_name)
        ret = OpenStruct.new(stdout: "Good", rc: 0)
      end
    end
    rep = GetCmvcDefectTextLines.new(typical_options)
    rep.defect_name.should eq(defect_name)
    rep.lines.should eq("Good")
  end

  it "should return first error if both fail" do
    local_execute_cmvc_command.should_receive(:new).twice do |options|
      if options[:cmd] == 'Defect'
        options.should include(cmd: 'Defect', view: defect_name)
        ret = OpenStruct.new(stderr: "Bad1", rc: 1)
      else
        options.should include(cmd: 'Feature', view: defect_name)
        ret = OpenStruct.new(stderr: "Bad2", rc: 1)
      end
    end
    rep = GetCmvcDefectTextLines.new(typical_options)
    rep.defect_name.should eq(defect_name)
    rep.error.should eq("Bad1")
  end
end
