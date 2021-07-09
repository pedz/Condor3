# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetCmvcDefectChanges do
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
      cmvc_change: defect_name
    }
  }

  it "should request changes for the defect specified by :defect_name" do
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'Report')
      OpenStruct.new(stdout: "Field1|Field2|Field3|Field4|Field5|Field6|Field7|Field8|Field9|Field10", rc: 0)
    end

    rep = GetCmvcDefectChanges.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.changes[0].release).to eq("Field1")
  end

  it "should work with no changes returned" do
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'Report')
      OpenStruct.new(stdout: nil, rc: 0)
    end

    rep = GetCmvcDefectChanges.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.changes.length).to eq(0)
  end

  it "should return error text if the command fails" do
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'Report')
      ret = OpenStruct.new(stderr: "Bad", rc: 1)
    end
    rep = GetCmvcDefectChanges.new(typical_options)
    expect(rep.defect_name).to eq(defect_name)
    expect(rep.error).to eq("Bad")
  end
end
