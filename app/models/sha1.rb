# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model passed to the view from the Sha1Controller.  It does the
# actual database search
class Sha1
  ##
  # :attr: sha1
  # The sha1 that was searched for
  attr_reader :sha1

  ##
  # :attr: shipped_files
  # The list of shipped files that match the passed in sha1
  attr_reader :shipped_files
  
  def initialize(params)
    @sha1 = params[:sha1]
    dalli_params = { sha1: sha1, request: 'sha1s'}
    unless (@shipped_files = cache.read(dalli_params))
      @shipped_files = model.find(:all,
                                  :conditions => { :aix_file_sha1 => @sha1})
      # Need to do something with rc
      rc = cache.write(dalli_params, @shipped_files)
    end
  end

  private

  def model
    @model ||= @options[:model] || ShippedFile
  end

  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end
end
