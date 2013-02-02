# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# This controller's show method is called when the sha1 request is
# made from the front page.
class Sha1sController < ApplicationController
  respond_to :html, :json
  
  def show
    sha1 = Sha1.new(params)
    respond_with(create_presenter(sha1))
  end

  def create
    redirect_to sha1s_path(params[:sha1])
  end
end
