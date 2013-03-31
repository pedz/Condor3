# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A class that represents the action that retrieves a source file from
# CMVC.
class GetDiff
  ##
  # :attr: old_file
  # The _original_ file (file on the left side of the diff algorithm)
  attr_reader :old_file

  ##
  # :attr: new_file
  # The _new_ file (file on the right side of the diff algorithm)
  attr_reader :new_file

  ##
  # :attr: error
  # The error that occurred when fetching the source file.
  attr_reader :error
  
  ##
  # :attr: page_params
  # A hash of the basic file parameters passed in.  This is used for
  # the title mostly since errors can leave other elements empty.
  # This will also be used as the hash for the caching.
  attr_reader :page_params

  # * *Args*    :
  #   - +options+ -> A hash providing:
  #     * +:get_user+ -> A lambda returning a duck type with a
  #       read/write attribute of cmvc_login.
  #     * +:release+ -> The CMVC release of the new file
  #     * +:path+ -> The CMVC path of the new file
  #     * +:version+ -> The CMVC SCCS id (or version) of the new file
  #     * +:prev_version+ -> (optional) If specified, provides the
  #       previous SCCS of the file and uses the same path and release
  #       as the new file.  If not specified, CMVC is queried for the
  #       previous SCCS version.
  #     * +:get_src_file+ -> (optional) To facilitate testing.  Defaults
  #       to GetSrcFile.  Used to fetch the files from CMVC.
  #     * +:execute_cmvc_command+ -> (optional) To facilitate
  #       testing.  Defaults to ExecuteCmvcCommand.  Used to query
  #       CMVC if no previous version is given.
  #     * +:cache+ -> (optional) To facilitate testing.  Defaults to
  #       Condor3::Application.config.my_dalli.  Used to cache results
  #       in production.
  #     * +:src_file_diff+ -> (optional) To facilitate testing.
  #       Defaults to SrcFileDiff.  Used to create the @diffs
  def initialize(options)
    @options = options.dup
    @old_file = nil
    @new_file = nil
    @error = nil

    new_file_params = {
      release: @options.delete(:release),
      path: @options.delete(:path),
      version: @options.delete(:version)
    }
    @page_params = new_file_params.merge(action: 'diff')

    if @options.has_key? :prev_version
      old_file_params = new_file_params.merge(version: @options[:prev_version])
    else
      return if (old_file_params = find_prev_version(new_file_params)).nil?
    end

    # The merge(@options) does not work for get_user... I have no idea
    # why.
    old_file_params[:get_user] = @options[:get_user]
    new_file_params[:get_user] = @options[:get_user]

    @old_file = get_src_file.new(old_file_params.merge(@options))
    if @old_file.error
      @error = "#{@old_file.error}\nwhile fetching old file"
      return
    end

    @new_file = get_src_file.new(new_file_params.merge(@options))
    if @new_file.error
      @error = "#{@new_file.error}\nwhile fetching new file"
      return
    end

    @diffs = src_file_diff.new(@old_file.lines.split("\n"), @new_file.lines.split("\n"))
  end

  # Returns the number of "Hunks" in the diff
  def diff_count
    (@diffs && @diffs.diff_count) || 0
  end

  # Returns the old_seq of the diff algorithm
  def old_seq
    (@diffs && @diffs.old_seq) || []
  end

  # Returns the new_seq of the diff algorithm
  def new_seq
    (@diffs && @diffs.new_seq) || []
  end

  private

  def find_prev_version(params)
    options = {
      get_user: @options[:get_user],
      cmd:     "Report",
      family:  "aix",
      general: "Versions v, \
                Versions prev_v, \
                Path p, \
                Path prev_p, \
                Changes c, \
                Changes prev_c, \
                Releases r, \
                Releases prev_r, \
                Files f, \
                Files prev_f",
      where:   "r.name = '#{params[:release]}' and \
                p.name = '#{params[:path]}' and \
                v.SID = '#{params[:version]}'  and \
                c.pathId = p.id and \
                c.fileId = f.id and \
                c.versionId = v.id and \
                f.pathId = p.id and \
                f.releaseId = r.id and \
                v.previousId = prev_v.id and \
                prev_v.id = prev_c.versionId and \
                prev_c.pathId = prev_p.id and \
                prev_c.fileId = prev_f.id and \
                prev_f.releaseId = prev_r.id and \
                r.name >= prev_r.name \
                ORDER BY prev_r.name DESC \
                FETCH FIRST 1 ROW ONLY",
      select:  "prev_r.name as release, \
                prev_p.name as path, \
                prev_v.SID as sccsid"
    }

    cmd = execute_cmvc_command.new(options)
    if cmd.rc != 0
      @error = "#{cmd.stderr}\nwhile fetching previous version"
      return nil
    end
    
    prev_params = {}
    prev_params[:release], prev_params[:path], prev_params[:version] = cmd.stdout.chomp.split(/\|/)
    prev_params
  end

  def get_src_file
    @get_src_file ||= @options[:get_src_file] || GetSrcFile
  end
  
  def execute_cmvc_command
    @execute_cmvc_command ||= @options[:execute_cmvc_command] || ExecuteCmvcCommand
  end

  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  def src_file_diff
    @src_file_diff ||= @options[:src_file_diff] || SrcFileDiff
  end
end
