# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class ExecuteCmvcCommand
  def stdout
    @cmd_result.stdout
  end
  
  def stderr
    @cmd_result.stderr
  end
  
  def rc
    @cmd_result.rc
  end
  
  def signal
    @cmd_result.signal
  end
  
  def initialize(options)
    @options = options.dup

    @cmd_result = get_cmvc_from_user.new(@options)
    return if rc != 0

    cmd = [ @options.delete(:cmd) , "-become", stdout ]
    options.each_pair do |k, v|
      # We could add checking of the options to make sure they fit
      # with the command but lets just let cmvc check on its own.
      cmd << "-#{k}"
      cmd << "\"#{v}\"" unless v.blank?
    end

    Rails.logger.debug("CMD= #{cmd}")
    stdout, stderr, rc, signal = cmvc_host.exec(cmd)
    @cmd_result = cmd_result.new(stdout: stdout, stderr: stderr, rc: rc, signal: signal)
  end

  private

  def get_cmvc_from_user
    @get_cmvc_from_user ||= @options[:get_cmvc_from_user] || GetCmvcFromUser
  end

  def cmd_result
    @cmd_result ||= @options[:cmd_result] || CmdResult
  end

  def cmvc_host
    @cmvc_host ||= @options[:cmvc_host] || CmvcHost
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end
end
