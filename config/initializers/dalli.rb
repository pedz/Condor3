require 'active_support/cache/dalli_store'

Condor3::Application.config.my_dalli = ActiveSupport::Cache::DalliStore.new()
