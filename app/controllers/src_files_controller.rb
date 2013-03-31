# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# A controller to fetch and display a specified CMVC file.
class SrcFilesController < ApplicationController
  respond_to :html, :json
  
  # The action to display the specified CMVC file.
  def show
    respond_with(create_presenter(:src_file, GetSrcFile.new(params)))
  end
end
