#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe GetSrcFile do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_execute_cmvc_command) { double('local_execute_cmvc_command')  }

  let(:dummy_get_user) { double('get_user').stub(:call) }

  let(:src_file) { 'a/b/c/d.c' }

  let(:version) { '1.2.3.4' }

  let(:release) { 'foo54D'}

  let(:typical_options) { {
      get_user: dummy_get_user,
      cache: local_cache,
      execute_cmvc_command: local_execute_cmvc_command,
      path: src_file,
      version: version,
      release: release
    }
  }

  let(:sample_file) {
    "Some test
     on multiple
     lines."
  }

  it "should request the specified file and report back the contents if no error" do
    local_execute_cmvc_command.should_receive(:new).once do |options|
      options.should include(cmd: 'File', extract: src_file, version: version, release: release)
      OpenStruct.new(stdout: sample_file, rc: 0)
    end

    rep = GetSrcFile.new(typical_options)
    rep.path.should eq(src_file)
    rep.version.should eq(version)
    rep.release.should eq(release)
    rep.lines.should eq(sample_file)
    rep.error.should eq(nil)
  end

  it "should request the specified file and report back the errors if any" do
    local_execute_cmvc_command.should_receive(:new).once do |options|
      options.should include(cmd: 'File', extract: src_file, version: version, release: release)
      OpenStruct.new(stderr: "Bad Message", rc: 1)
    end

    rep = GetSrcFile.new(typical_options)
    rep.error.should eq("Bad Message")
  end
end
