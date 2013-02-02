#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
JsRoutes.setup do |config|
  config.namespace = 'condor3.routes'
  if Rails.env == 'development'
    config.prefix = '/condor3/'
  end
end
