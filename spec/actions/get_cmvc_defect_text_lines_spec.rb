# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetCmvcDefectTextLines do
  let(:local_cache) {
    double('local_cache').tap do |d|
      allow(d).to receive(:read) { nil }
      allow(d).to receive(:write) { true }
    end
  }

  let(:local_execute_cmvc_command) { double('local_execute_cmvc_command')  }

  let(:dummy_get_user) { allow(double('get_user')).to receive(:call) }

  let(:defect_name) { '123456' }
  let(:typical_options) { {
      get_user: dummy_get_user,
      cache: local_cache,
      execute_cmvc_command: local_execute_cmvc_command,
      cmvc_defect: defect_name
    }
  }

  it "should first request a defect specified by :defect_name" do
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'Defect', view: defect_name)
      OpenStruct.new(stdout: "Sample", rc: 0)
    end

    rep = GetCmvcDefectTextLines.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.lines).to eq("Sample")
  end

  it "should request a feature if the request for the defect returns with an error" do
    expect(local_execute_cmvc_command).to receive(:new).twice do |options|
      if options[:cmd] == 'Defect'
        expect(options).to include(cmd: 'Defect', view: defect_name)
        ret = OpenStruct.new(stdout: "Bad", rc: 1)
      else
        expect(options).to include(cmd: 'Feature', view: defect_name)
        ret = OpenStruct.new(stdout: "Good", rc: 0)
      end
    end
    rep = GetCmvcDefectTextLines.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.lines).to eq("Good")
  end

  it "should return first error if both fail" do
    expect(local_execute_cmvc_command).to receive(:new).twice do |options|
      if options[:cmd] == 'Defect'
        expect(options).to include(cmd: 'Defect', view: defect_name)
        ret = OpenStruct.new(stderr: "Bad1", rc: 1)
      else
        expect(options).to include(cmd: 'Feature', view: defect_name)
        ret = OpenStruct.new(stderr: "Bad2", rc: 1)
      end
    end
    rep = GetCmvcDefectTextLines.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.error).to eq("Bad1")
  end
end
