#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe FileChangesController do
  let(:model) { GetFileChanges }

  let(:presenter) { :file_change }
  
  let(:file) { 'banana.c' }

  let(:post_options) { { file: file } }

  let(:full_options) { post_options }

  it_behaves_like "a controller"
end
