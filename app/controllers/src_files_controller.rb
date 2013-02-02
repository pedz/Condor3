# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class SrcFilesController < ApplicationController
  def show
    options = {
      :release => params[:release],
      :version => params[:version],
      :path => params[:path],
      :cmvc => user.cmvc
    }
    @src_file = SrcFile.new(options)
  end
end
