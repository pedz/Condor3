#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'active_support/cache/dalli_store'

Condor3::Application.config.my_dalli = ActiveSupport::Cache::DalliStore.new()
