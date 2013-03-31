# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A controller that retrieves and displays the filesets that a
# particular AIX file shipps in.  The file name be specified by its
# basename, full path, or partial path.
class WhichFilesetsController < ApplicationController
  respond_to :html, :json

  # The action that retrieves and displays which filesets the
  # specified AIX file ships in.
  def show
    respond_with(create_presenter(:which_fileset, GetWhichFilesets.new(params)))
  end
  
  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to which_filesets_path(params[:path])
  end
end
