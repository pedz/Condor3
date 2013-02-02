#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe Sha1 do
  let(:local_cache) {
    double('local_cache').tap do |d|
      d.stub(:read) { nil }
      d.stub(:write) { true }
    end
  }

  let(:local_model) { double('local_model')  }

  let(:sample_sha1) { '1234567890123456789012345678901234567890' }

  let(:typical_options) { {
      cache: local_cache,
      model: local_model,
      sha1: sample_sha1
    }
  }

  it "should search model for requested sha1" do
    local_model.stub(:find) do |all, options|
      all.should be(:all)
      options[:conditions][:aix_file_sha1].should eq(sample_sha1)
      FactoryGirl.build_list(:shipped_file, 10)
    end
    sha1 = Sha1.new(typical_options)
    sha1.sha1.should eq(sample_sha1)
    sha1.shipped_files.should be_a(Array)
    sha1.shipped_files.should have(10).items
  end
end
