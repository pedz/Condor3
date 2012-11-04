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

  def initialize(options)
    @release = options[:release]
    @version = options[:version]
    @path    = options[:path]
    @cmvc    = options[:cmvc]
    fetch_text
  end

  def basename
    @path.sub(/.*\//, '')
  end

  # Returns text as an array of lines
  def lines
    @cmd.lines
  end

  # Returns the text of the Defect or Feature
  def text
    @cmd.stdout
  end

  private

  # fetch the text of the source file.
  def fetch_text
    options = {
      :extract => @path,
      :release => @release,
      :version => @version,
      :family => 'aix',
      :stdout => ""
    }
    @cmd = @cmvc.file!(options)
  end
end
