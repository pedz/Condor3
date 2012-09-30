# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# This controller's show method is called when the sha1 request is
# made from the front page.
class Sha1sController < ApplicationController
  def show
    @sha1 = params[:sha1]
    # Sorta silly with this controller but just to be consistent.
    if request.post?
      redirect_to sha1s_path(@sha1)
      return
    end
    @shipped_files = ShippedFile.find(:all, :conditions => { :aix_file_sha1 => @sha1})
  end
end
