# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Controller used for Defect Changes
class CmvcChangesController < ApplicationController
  respond_to :html, :json

  # Show the Changes for the specified defect or feature.
  def show
    respond_with(create_presenter(:cmvc_defect_change, GetCmvcDefectChanges.new(params)))
  end

  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to cmvc_changes_path(params[:cmvc_change].strip)
  end
end
