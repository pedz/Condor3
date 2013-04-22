# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# A service that executes a command with CMVC.
class ExecuteCmvcCommand
  # The stdout of the command
  def stdout
    @result.stdout
  end
  
  # The stderr of the command
  def stderr
    @result.stderr
  end
  
  # The exit return code of the process that ran the command.
  def rc
    @result.rc
  end
  
  # The nane of the signal, if any, that caused the command to
  # terminate.
  def signal
    @result.signal
  end
  
  # * *Args*    :
  #   - +options+ -> A hash containing:
  #     * +:cmd+ -> The CMVC command to issue such as Report or File.
  #     * +:get_cmvc_from_user+ -> (optional) To facilitate testing,
  #       the service to map the user to the CMVC id may be passed
  #       in.  The default is GetCmvcFromUser.
  #     * +:get_user+ -> A lambda returning a duck type with a
  #       read/write attribute of cmvc_login.
  #     * +:cache+ -> (optional) To facilitate testing.  Defaults to
  #       Condor3::Application.config.my_dalli.  Used to cache results
  #       in production.
  #     * +cmd_result+ -> (optional) To facilitate testing, the class
  #       used to represent the result may be passed in.  The default
  #       is CmdResult.
  #     * +cmvc_host+ -> (optional) To facilitate testing, the service
  #       that is called to actually execute the string built up may
  #       be passed in.  The default is CmvcHost.
  def initialize(options = {})
    @options = options.dup

    @result = get_cmvc_from_user.new(@options)
    return if rc != 0

    @options.delete(:get_user)
    cmd = [ @options.delete(:cmd) , "-become", stdout ]
    @options.each_pair do |k, v|
      # We could add checking of the options to make sure they fit
      # with the command but lets just let cmvc check on its own.
      cmd << "-#{k}"
      cmd << "\"#{v}\"" unless v.blank?
    end

    cmd = cmd.join(' ')
    stdout, stderr, rc, signal = cmvc_host.exec(cmd)
    @result = cmd_result.new(stdout: stdout, stderr: stderr, rc: rc, signal: signal)
  end

  private

  def get_cmvc_from_user
    @get_cmvc_from_user ||= @options.delete(:get_cmvc_from_user) || GetCmvcFromUser
  end

  def cmd_result
    @cmd_result ||= @options.delete(:cmd_result) || CmdResult
  end

  def cmvc_host
    @cmvc_host ||= @options.delete(:cmvc_host) || CmvcHost
  end

  # Not used yet
  def cache
    @cache ||= @options.delete(:cache) || Condor3::Application.config.my_dalli
  end
end
