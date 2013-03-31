# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A service which retrieves the specified file from CMVC.
class GetSrcFile
  ##
  # :attr: path
  # The path of the source file that was retrieved.
  attr_reader :path

  ##
  # :attr: version
  # The sccs version of the file that was retrieved.
  attr_reader :version

  ##
  # :attr: release
  # The CMVC release of the file that was retrieved.
  attr_reader :release
  
  ##
  # :attr: lines
  # The text lines of the source file.
  attr_reader :lines
  
  ##
  # :attr: error
  # The error that occurred when fetching the source file.
  attr_reader :error
  
  # * *Args*    :
  #   - +options+ -> A hash containing:
  #     * +:path+ -> The path for the file to retrieve.
  #     * +:version+ -> The SCCS version for the file to retrieve.
  #     * +:release+ -> The CMVC release for the file to retrieve.
  #     * +:get_user+ -> A lambda returning a duck type with a
  #       read/write attribute of cmvc_login.
  #     * +:execute_cmvc_command+ -> (optional) To facilitate
  #       testing.  Defaults to ExecuteCmvcCommand.  Used to query
  #       CMVC if no previous version is given.
  #     * +:cache+ -> (optional) To facilitate testing.  Defaults to
  #       Condor3::Application.config.my_dalli.  Used to cache results
  #       in production.
  def initialize(options)
    @options = options.dup
    @path = @options[:path]
    @version = @options[:version]
    @release = @options[:release]
    @lines = nil
    @error = nil

    dalli_params = {
      request: 'src_file',
      path: @path,
      version: @version,
      release: @release
    }
    unless (@lines = cache.read(dalli_params))
      exec_params = {
        get_user: @options[:get_user],
        cmd: 'File',
        family: 'aix',
        extract: @path,
        version: @version,
        release: @release,
        stdout: nil
      }

      cmd = execute_cmvc_command.new(exec_params)
      if (cmd.rc == 0)
        @lines = cmd.stdout

        # Need to do something with rc
        rc = cache.write(dalli_params, @lines)
      else
        # don't cache up error since it may be due to a transiant
        # problem
        @error = cmd.stderr
      end
    end
  end

  private

  def execute_cmvc_command
    @execute_cmvc_command ||= @options[:execute_cmvc_command] || ExecuteCmvcCommand
  end

  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end
end
