# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetFileChanges do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_execute_cmvc_command) { double('local_execute_cmvc_command')  }

  let(:dummy_get_user) { double('get_user').stub(:call) }

  let(:file_name) { 'banana.c' }

  let(:typical_options) { {
      get_user: dummy_get_user,
      cache: local_cache,
      execute_cmvc_command: local_execute_cmvc_command,
      file: file_name
    }
  }

  it "should request changes for the defect specified by :file_name" do
    local_execute_cmvc_command.should_receive(:new).once do |options|
      options.should include(cmd: 'Report')
      OpenStruct.new(stdout: "Field1|Field2|Field3|Field4|Field5|Field6|Field7|Field8|Field9|Field10", rc: 0)
    end

    rep = GetFileChanges.new(typical_options)
    rep.file_name.should eq(file_name)
    rep.changes[0].release.should eq("Field1")
  end

  it "should return error text if the command fails" do
    local_execute_cmvc_command.should_receive(:new).once do |options|
      options.should include(cmd: 'Report')
      ret = OpenStruct.new(stderr: "Bad", rc: 1)
    end
    rep = GetFileChanges.new(typical_options)
    rep.file_name.should eq(file_name)
    rep.error.should eq("Bad")
  end
end
