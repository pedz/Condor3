# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model to contain the logic needed for a which_fileset request.
class WhichFileset
  ##
  # :attr: path
  # the path that was requested
  attr_reader :path

  ##
  # :attr: paths
  # the results organized as a hash keyed of the full path.
  attr_reader :paths

  def initialize(options = {})
    @options = options.dup
    @path = options[:path]

    @paths = do_find(@path)
    # If 1st try is empty, try removing any 32 or 64 qualifiers.
    if @paths.empty?
      if (md = /(.*)(_?64$|_?32$)/.match(@path))
        @path = md[1]
        @paths = do_find(@path)
      elsif (md = /^(.*)(32|64)(\..*)$/.match(@path))
        @path = md[1] + md[3]
        @paths = do_find(@path)
      end
    end
  end

  private

  def model
    @model ||= @options[:model] || AixFile
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  def do_find(path)
    dalli_params = {
      path: path,
      request: 'which_filesets'
    }
    unless (items = cache.read(dalli_params))
      items = {}
      model.find(:all,
                 :conditions => ("basename(path) = basename('#{path}') AND " +
                                 "path LIKE '%#{path}'"),
                 :order => "path",
                 :include => [ { :filesets => :lpp }]).each do |f|
        items[f.path] = ((items[f.path] || []) + f.filesets.map { |fileset| fileset.lpp.name }).sort.uniq
      end
      rc = cache.write(dalli_params, items) # Need to do something with rc
    end
    items
  end
end
