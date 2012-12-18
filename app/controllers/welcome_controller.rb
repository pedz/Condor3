class WelcomeController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(create_presenter(:welcome))
  end
end
