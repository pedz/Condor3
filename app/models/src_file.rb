# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a source file in CMVC.
class SrcFile
  # The CMVC release the file is from
  attr_reader :release

  # The SCCS version of the file.
  attr_reader :version

  # The path to the file
  attr_reader :path

  # The Cmvc instance used to retrieve the file.
  attr_reader :cmvc

  # The lines of the file
  attr_reader :lines

  # Any errors returned while retriving the file.
  attr_reader :err

  def initialize(options)
    @release = options[:release]
    @version = options[:version]
    @path    = options[:path]
    @cmvc    = options[:cmvc]
    @lines, @err = get_lines
  end

  def basename
    @path.sub(/.*\//, '')
  end

  private

  # The text lines of the file
  def get_lines
    options = {
      :extract => @path,
      :release => @release,
      :version => @version,
      :family => 'aix',
      :stdout => ""
    }
    stdout, stderr, rc, signal = cmvc.file(options)
    return "", stderr if rc != 0
    return stdout, ""
  end
end
