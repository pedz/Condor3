#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe SrcFilesController do
  let(:model) { GetSrcFile }

  let(:presenter) { :src_file }
  
  let(:release) { 'bos71F' }
  
  let(:version) { '1.2' }

  let(:path) { 'the/path/to/this/file' }
  
  let(:post_options) { nil }
  
  let(:full_options) do
    {
      release: release,
      version: version,
      path: path
    }
  end

  it_behaves_like "a controller"
end
