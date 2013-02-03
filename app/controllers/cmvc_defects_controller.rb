# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class CmvcDefectsController < ApplicationController
  def show
    defect_name = params[:defect]
    return redirect_to defects_path(defect_name) if request.post?

    # find or initialize the record and fetch the text.
    @defect = Defect.find_or_initialize_by_name(defect_name)
    @defect.fetch_text(user.cmvc)

    # If this is a new record and fetch_text did not throw an
    # exception, we know it is a valid defect number and can save it.
    @defect.save if @defect.new_record?

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
