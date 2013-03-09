#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

module RSpec::Rails
  module AssetExampleGroup
    extend ActiveSupport::Concern
    include RSpec::Rails::RailsExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
    
    included do
      metadata[:type] = :asset
    end
  end
end
