# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A base for the models passed from the controllers to the views.
# Common attributes are held here.
class ViewModel
  ##
  # :attr: title
  # The title the page should have
  attr_reader :title

  ##
  # :attr: params
  # Copy of the params that hit the controller
  attr_reader :params

  def initialize(options)
    @title = options[:title] || "No Title for Page"
    @params = options[:params] || {}
  end
end
