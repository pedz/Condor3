#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe CmvcChangesController do
  let(:model) { GetCmvcDefectChanges }

  let(:presenter) { :cmvc_change }
  
  let(:change) { '123456' }

  let(:post_options) { { cmvc_change: change } }

  let(:full_options) { post_options }

  it_behaves_like "a controller"
end
