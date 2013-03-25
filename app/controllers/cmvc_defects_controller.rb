# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class CmvcDefectsController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(create_presenter(:cmvc_defect_text_line, GetCmvcDefectTextLines.new(params)))
  end

  def create
    redirect_to cmvc_defects_path(params[:cmvc_defect].strip)
  end
end
