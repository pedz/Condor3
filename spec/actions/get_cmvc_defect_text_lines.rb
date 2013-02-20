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

  let(:local_model) { double('local_model')  }

  let(:typical_options) { {
      cache: local_cache,
      model: local_model,
      cmvc_defect: '123456'
    }
  }

  
end
