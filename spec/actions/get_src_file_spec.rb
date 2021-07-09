#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe GetSrcFile do
  let(:local_cache) {
    double('local_cache').tap do |d|
      allow(d).to receive(:read).and_return(nil)
      allow(d).to receive(:write).and_return(true)
    end
  }

  let(:local_execute_cmvc_command) { double('local_execute_cmvc_command')  }

  let(:dummy_get_user) { allow(double('get_user')).to receive(:call) }

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
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'File', extract: src_file, version: version, release: release)
      OpenStruct.new(stdout: sample_file, rc: 0)
    end

    rep = GetSrcFile.new(typical_options)
    expect(rep.path).to eq(src_file)
    expect(rep.version).to eq(version)
    expect(rep.release).to eq(release)
    expect(rep.lines).to eq(sample_file)
    expect(rep.error).to eq(nil)
  end

  it "should request the specified file and report back the errors if any" do
    expect(local_execute_cmvc_command).to receive(:new).once do |options|
      expect(options).to include(cmd: 'File', extract: src_file, version: version, release: release)
      OpenStruct.new(stderr: "Bad Message", rc: 1)
    end

    rep = GetSrcFile.new(typical_options)
    expect(rep.error).to eq("Bad Message")
  end
end
