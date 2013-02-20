#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe CmvcDefectsController do
  let(:model) { GetCmvcDefectTextLines }

  let(:presenter) { :cmvc_defect }
  
  let(:defect) { '123456' }

  let(:post_options) { { cmvc_defect: defect } }

  let(:full_options) { post_options }

  it_behaves_like "a controller"
end
