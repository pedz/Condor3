# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class WelcomeController < ApplicationController
  respond_to :html, :json
  
  def index
    # describe(self)
    respond_with(create_presenter(:welcome))
  end
  
  private
  
  def describe_methods(c)
    logger.debug "Methods for #{c.name}"
    c.instance_methods(false).each do |m|
      logger.debug "#{c.name}##{m.to_s}"
    end
  end
  
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
