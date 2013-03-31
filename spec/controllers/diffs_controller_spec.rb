#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe DiffsController do
  let(:model) { GetDiff }

  let(:presenter) { :diff }
  
  let(:post_options) { nil }
  
  let(:full_options) { DiffRouteHash }

  it_behaves_like "a controller"
end
