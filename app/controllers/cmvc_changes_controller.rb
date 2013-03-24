# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Controller used for Defect Changes
class CmvcChangesController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(create_presenter(:cmvc_change, GetCmvcDefectChanges.new(params)))
  end

  def create
    redirect_to cmvc_changes_path(params[:cmvc_change].strip)
  end
end
