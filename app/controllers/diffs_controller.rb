# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# A controller that shows the differences between a CMVC file and its
# previous version.
class DiffsController < ApplicationController
  respond_to :html, :json

  # Action to show the diffs betwen a CMVC file and its previous
  # version.
  def show
    respond_with(create_presenter(:diff, GetDiff.new(params)))
  end
end
