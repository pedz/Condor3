# -*- coding: utf-8 -*-
#

# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# Controller to retrieve and display the "swinfo" entries for a
# particular item.
class SwinfosController < ApplicationController
  respond_to :html, :json

  # The default sort order of the matched entries.
  DEFAULT_SORT_ORDER = 'defect, apar, ptf'

  # Currently I've decided to pass the sort order and the page number
  # as part of the path.  The show routine is called from a url of
  # /swinfos/:item/:sort/:page(.:format) where :item can be a defect,
  # apar, ptf, lpp, or lpp with vrmf.  :sort is a list of columns
  # separated by commands.  :page can be either a number or the string
  # 'all'.
  def show
    unless params[:sort] && params[:page]
      redirect_to_full_path
      return
    end

    respond_with(create_presenter(:swinfo, GetSwinfos.new(params)))
  end

  # Method used when called from a submit of the welcome page.  It
  # redirects to the show method.
  def create
    redirect_to_full_path
  end

  private

  # If either the page or sort paramters are missing, they are filled
  # in by this routine.
  def redirect_to_full_path
    redirect_to swinfo_full_path(params[:item].strip,
                                 (params[:sort] || DEFAULT_SORT_ORDER).strip,
                                 (params[:page] || '1').strip)
  end
end
