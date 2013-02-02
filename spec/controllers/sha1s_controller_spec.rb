#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe Sha1sController do
  let(:sha1) { '1234567890123456789012345678901234567890' }

  let(:post_options) { { sha1: sha1 } }

  let(:full_options) { post_options }

  it_behaves_like "a controller"
end
