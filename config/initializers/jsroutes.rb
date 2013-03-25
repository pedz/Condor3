#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

begin
  # In real production, we can't load this.  But in 'production' when
  # we precompile the assets, we can load it (and need to configure
  # various things).
  require 'js_routes'

  JsRoutes.setup do |config|
    config.namespace = 'condor3.routes'
    if Rails.env == 'development'
      config.prefix = '/condor3/'
    end
  end
rescue LoadError => e
  true
end
