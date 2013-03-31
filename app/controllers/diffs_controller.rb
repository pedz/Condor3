# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class DiffsController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(create_presenter(:diff, GetDiff.new(params)))
  end
end
