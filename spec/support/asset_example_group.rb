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
