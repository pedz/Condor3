class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :help_text

  def help_text
    @help_text = <<-EOF
      This page has no help text.

      Sorry.
    EOF
  end
end
