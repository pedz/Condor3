# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# This controller's show method is called when the sha1 request is
# made from the front page.
class Sha1sController < ApplicationController
  respond_to :html, :json
  
  # Action to show the shipped AIX files with the requested SHA1
  # hash.
  def show
    respond_with(create_presenter(:sha1, GetSha1s.new(params)))
  end

  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to sha1s_path(params[:sha1])
  end
end
