# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Controller used for File Changes
class FileChangesController < ApplicationController
  respond_to :html, :json

  # Action to show the file changes.
  def show
    respond_with(create_presenter(:file_change, GetFileChanges.new(params)))
  end

  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to file_changes_path(params[:file].strip)
  end
end
