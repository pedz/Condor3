# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model passed to the view from the SwinfosController
class Swinfo < ViewModel
  ##
  # :attr: errors
  # Errors hit when processing the request
  attr_reader :errors

  ##
  # :attr: item
  # The item that was searched for
  attr_reader :item

  ##
  # :attr: upd_apar_defs
  # The upd_apar_defs returned from the search
  attr_reader :upd_apar_defs

  def initialize(options = {})
  end
end
