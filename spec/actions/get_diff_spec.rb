# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetDiff do
  let(:local_cache) {
    double('local_cache').tap do |d|
      allow(d).to receive(:read) { nil }
      allow(d).to receive(:write) { true }
    end
  }

  let(:execute_cmvc_command) do
    double("execute_cmvc_command").tap do |d|
      allow(d).to receive(:new) do |options|
        expect(options).to include(cmd: "Report")
        expect(options[:where]).to include(src_file_options[:path])
        # Return an error to get the processing to stop
        OpenStruct.new(rc: 1, stderr: "mess")
      end
    end
  end
  
  let(:lines1) do
    "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\n"
  end

  let(:lines2) do
    "Line 1\nLine 3\nLine 4\nLine 5 new\n"
  end

  let(:get_src_file) do
    double("get_src_file").tap do |d|
      allow(d).to receive(:new) do |options|
        expect(options).to include(path: src_file_options[:path])
        expect(options).to include(release: src_file_options[:release])
        expect(options).to include(:version)
        case options[:version]
        when "1.2.2"
          OpenStruct.new(error: "bad file")
          
        when "1.2.3"
          OpenStruct.new(lines: lines1)
          
        when "1.2.4"
          OpenStruct.new(lines: lines2)
        end
      end
    end
  end
  
  let(:src_file_diff) do
    double("src_file_diff").tap do |d|
      allow(d).to receive(:new) do |l1, l2|
        expect(l1).to eq(lines1.split("\n"))
        expect(l2).to eq(lines2.split("\n"))
        OpenStruct.new(old_seq: "old_seq", new_seq: "new_seq", diff_count: 3)
      end
    end
  end

  let(:src_file_options) do
    {
      get_src_file: get_src_file,
      cache: local_cache,
      execute_cmvc_command: execute_cmvc_command,
      src_file_diff: src_file_diff,
      release: 'dog82C',
      path: 'src/file/path.c',
      version: '1.2.4',
      prev_version: '1.2.3'
    }
  end

  it "should get the previous version when it is not specified and report back errors if any" do
    temp = src_file_options.dup
    temp.delete(:prev_version)
    d = GetDiff.new(temp)
    expect(d.error).to match("mess")
  end

  it "should get the source files and report back errors if any" do
    d = GetDiff.new(src_file_options.merge(prev_version: "1.2.2"))
    expect(d.error).to match("bad file")
    d = GetDiff.new(src_file_options.merge(version: "1.2.2"))
    expect(d.error).to match("bad file")
  end

  it "should create a diff of the files" do
    d = GetDiff.new(src_file_options)
    expect(d.old_seq).to eq("old_seq")
    expect(d.new_seq).to eq("new_seq")
    expect(d.diff_count).to eq(3)
  end
end
