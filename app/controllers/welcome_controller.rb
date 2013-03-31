# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# The welcome controller which displays a form allowing various
# queries to be made.
class WelcomeController < ApplicationController
  respond_to :html, :json
  
  # The action called
  def index
    # describe(self)
    respond_with(create_presenter(:welcome))
  end
  
  private
  
  # These are debugging and experimenting functions -- not really part
  # of the application.
  # This method describes the methods given a class
  def describe_methods(c)
    logger.debug "Methods for #{c.name}"
    c.instance_methods(false).each do |m|
      logger.debug "#{c.name}##{m.to_s}"
    end
  end
  
  # This method describes the methods for a particular object passed
  # in.
  def describe(o)
    modules = []
    c = o.class
    while c
      unless modules.include? c
        modules << c
        describe_methods(c)
        c.included_modules.each do |m|
          unless modules.include? m
            modules << m
            describe_methods(m)
          end
        end
      end
      c = c.superclass
    end
  end
end
