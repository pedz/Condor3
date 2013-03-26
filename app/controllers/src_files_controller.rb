# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class SrcFilesController < ApplicationController
  respond_to :html, :json
  
  def show
    respond_with(create_presenter(:src_file, GetSrcFile.new(params)))
  end
end
