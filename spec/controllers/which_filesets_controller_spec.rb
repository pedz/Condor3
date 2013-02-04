#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe WhichFilesetsController do
  let(:model) { GetWhichFilesets }

  let(:presenter) { :which_fileset }
  
  let(:path) { 'msnentdd' }

  let(:post_options) { { path: path } }

  let(:full_options) { post_options }

  it_behaves_like "a controller"
end
