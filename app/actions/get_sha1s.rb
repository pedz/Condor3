# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A service which retrieves a list of ShippedFile models from the
# database which have a specified SHA1 hash.
class GetSha1s
  ##
  # :attr: sha1
  # The sha1 that was searched for
  attr_reader :sha1

  ##
  # :attr: shipped_files
  # The list of shipped files that match the passed in sha1
  attr_reader :shipped_files
  
  # * *Args*    :
  #   - +options+ -> A hash with:
  #     * +:sha1+ -> The SHA1 to look up.
  #     * +:model+ -> (optional) To facilitate testing, the model that
  #       is queried may be passed in.  Defaults to ShippedFile.
  #     * +:cache+ -> (optional) To facilitate testing, the cache can
  #       be passed in.  Defaults to
  #       Condor3::Application.config.my_dalli
  def initialize(options)
    @options = options.dup
    @sha1 = options[:sha1].strip
    dalli_params = { sha1: sha1, request: 'sha1s'}
    unless (@shipped_files = cache.read(dalli_params))
      @shipped_files = model.find(:all,
                                  conditions: { aix_file_sha1: @sha1})
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
