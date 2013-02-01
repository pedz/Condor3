# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#
class WhichFilesetsController < ApplicationController
  respond_to :html, :json

  def show
    which_fileset = WhichFileset.new(params)
    respond_with(create_presenter(which_fileset))
  end
  
  def create
    redirect_to which_filesets_path(params[:path])
  end
end
