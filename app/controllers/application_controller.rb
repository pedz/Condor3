class ApplicationController < ActionController::Base
  # auto reload lib in development mode.
  before_filter :reload_libs if Rails.env.development?

  protect_from_forgery

  private

  # auto reload lib in development mode.
  def reload_libs
    Dir["#{Rails.root}/lib/**/*.rb"].each { |path| require_dependency path }
  end
end
