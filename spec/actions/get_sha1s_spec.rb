#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe GetSha1s do
  let(:local_cache) {
    double('local_cache').tap do |d|
      allow(d).to receive(:read) { nil }
      allow(d).to receive(:write) { true }
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
    allow(local_model).to receive(:find) do |all, options|
      expect(all).to be(:all)
      expect(options[:conditions][:aix_file_sha1]).to eq(sample_sha1)
      FactoryGirl.build_list(:shipped_file, 10)
    end
    get_sha1s = GetSha1s.new(typical_options)
    expect(get_sha1s.sha1).to eq(sample_sha1)
    expect(get_sha1s.shipped_files).to be_a(Array)
    expect(get_sha1s.shipped_files).to have(10).items
  end
end
