# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

class WhichFilesetsController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(create_presenter(:which_fileset, GetWhichFilesets.new(params)))
  end
  
  def create
    redirect_to which_filesets_path(params[:path])
  end
end
