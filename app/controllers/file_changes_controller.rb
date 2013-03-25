# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Controller used for File Changes
class FileChangesController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(create_presenter(:file_change, GetFileChanges.new(params)))
  end

  def create
    redirect_to file_changes_path(params[:file].strip)
  end

  # Show the changes for the given file
  # def show
  #   if request.post?
  #     return redirect_to file_changes_path(params[:file])
  #   else
  #     @file = 18
  #   end
  #   @file_changes = FileChange.find(params[:file])
    
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml { render :xml => @file_changes }
  #   end
  # end
end
