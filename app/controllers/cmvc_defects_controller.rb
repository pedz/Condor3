# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# A controller that shows the text of a CMVC defect.
class CmvcDefectsController < ApplicationController
  respond_to :html, :json

  # Action to show the requested CMVC defect
  def show
    respond_with(create_presenter(:cmvc_defect_text_line, GetCmvcDefectTextLines.new(params)))
  end

  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to cmvc_defects_path(params[:cmvc_defect].strip)
  end
end
