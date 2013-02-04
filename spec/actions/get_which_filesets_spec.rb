# -*- coding: utf-8 -*-
#
# Copyright 2013 Ease Software, Inc.
# All Rights Reserved
#
require 'spec_helper'

describe GetWhichFilesets do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_model) { double('local_model')  }

  let(:typical_options) { {
      cache: local_cache,
      model: local_model,
      path: 'mnsentdd'
    }
  }

  it "should search model for path" do
    local_model.stub(:find) do |all, options|
      base = typical_options[:path]
      all.should be(:all)
      options[:order].should eq('path')
      options[:conditions].should match("basename\\(path\\) = basename\\('#{typical_options[:path]}'\\)")
      r = []
      filesets = FactoryGirl.build_list(:fileset, 12)
      [
       "/first/path/to",
       "/first/path/to",
       "/second/path/to",
       "/third/path/to",
       "/second/path/to",
       "/third/path/to",
       "/fouth/path/to",
       "/fouth/path/to"
     ].each_with_index do |path, i|
        r << FactoryGirl.build(:aix_file,
                               path: "#{path}/#{base}",
                               filesets: filesets[i .. (i + 3)])
      end
      r
    end
    get_which_filesets = GetWhichFilesets.new(typical_options)
    get_which_filesets.path.should eq(typical_options[:path])
    get_which_filesets.paths.should be_a(Hash)
    get_which_filesets.paths.keys.should have(4).items
  end
end
