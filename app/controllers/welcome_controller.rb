class WelcomeController < ApplicationController
  def index
  end

  def help_text
    @help_text = <<-EOF
      Some useful help text.
    EOF
  end
end
