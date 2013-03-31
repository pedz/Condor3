#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# A module to help issue CMVC commands from a particular host.  It
# will be configured by the cmvc.yml file in the config directory
# (which will be loaded by an initializer).
#
# The module will operate in one of two modes for the duration of the
# application: +ssh+ or +local+.  This is determined by the cmvc.yml file
# in the config directory with is keyed by the host name.
#
# In ssh mode, the request is done via ssh to a remote host.  In the
# case of local mode, the request is done locally.
#
# A boot strap user must be configured which is a cmvc user that the
# application has permission to become.  This is used to find the cmvc
# user id of the users of the application.
#
# In both modes, a single class method, exec, is provided.
module CmvcHost
  # Constant set at load time to the local hostname without the
  # domain.
  OurHost = Socket::gethostname.sub(/\..*/, '').downcase

  # The configuration stanza for the local host pulled from
  # config/cmvc.yml.  The keys are symbolized.
  Config = YAML.load(File.open("#{Rails.root}/config/cmvc.yml"))[OurHost].symbolize_keys

  # The value of Config[:method] which is either +local+ or +ssh+.
  Method = Config[:method]

  # The path to the cmvc commands pulled from Config[:path].  If
  # Method is +local+, this is the path to the local CMVC commands
  # such as Report, Defect, etc.  If Method is +ssh+, this is the path
  # to the CMVC commands for that host.
  Path = Config[:path]

  # The CMVC user that the application will use to look up an
  # individual's CMVC id.  The first time a user does a CMVC command,
  # their CMVC id is looked up.  See GetCmvcFromUser for more
  # details.
  BootstrapCmvcUser = Config[:bootstrap_cmvc_user]

  # An array created from Signal mapping the signam number to its name.
  Signum2Name = Signal.list.map { |k, v| k }

  case Method
  when "ssh"
    # executes the command via ssh to the remote host configured in
    # the cmvc.yml file for this host.
    #
    # * *Args*    :
    #   - +cmd+ -> A string such as "File -extract foo.c -become pedz ..."
    # * *Returns* :
    #   - A four tuple [ stdout, stderr, exit_code, exit_signal ]
    #     - +stdout+ -> the stdout of the command that was executed.
    #     - +stderr+ -> the stderr of the command that was executed.
    #     - +exit_code+ -> the exit exit code from the command: 0 is a
    #       good exit while anything else indicates an error.
    #     - +exit_signal+ -> the signal received (as a string), if
    #       any, by the command causing it to exit.
    #
    def self.exec(cmd)
      Rails.logger.debug("CmvcHost ssh exec: #{cmd}")
      stdout_data = ""
      stderr_data = ""
      exit_code = nil
      exit_signal = nil
      Net::SSH.start(Config[:hostname], Config[:username]) do |ssh|
        # stolen from stack exchange
        # http://stackoverflow.com/questions/3386233/how-to-get-exit-status-with-rubys-netssh-library
        # def ssh_exec!(ssh, command)
        ssh.open_channel do |channel|
          channel.exec("#{Path}/#{cmd}") do |ch, success|
            unless success
              abort "FAILED: couldn't execute command (ssh.channel.exec)"
            end
            channel.on_data do |ch,data|
              stdout_data += data
            end
            
            channel.on_extended_data do |ch,type,data|
              stderr_data += data
            end
            
            channel.on_request("exit-status") do |ch,data|
              exit_code = data.read_long
            end
            
            channel.on_request("exit-signal") do |ch, data|
              exit_signal = data.read_string
              exit_code = -1
            end
          end
        end
        ssh.loop
        # end
      end
      [stdout_data, stderr_data, exit_code, exit_signal]
    end

  when "local"
    def self.exec(cmd)
      Rails.logger.debug("CmvcHost local exec: #{cmd}")
      # create a temp file
      err_file = Tempfile.new("condor")
      # call the command.  Redirect stderr to temp file
      io = IO.popen("#{Path}/#{cmd} 2> #{err_file.path}")
      # get the standard output
      stdout_data = io.readlines(nil)[0]
      # close the popen command
      io.close
      # get the exit code of the popen command
      exit_status = $?
      # Now we have to "open" the temp file which does a rewind and
      # open for read.
      err_file.open
      # Read what was put into the temp file via stderr
      stderr_data = err_file.readlines(nil)[0]
      # close and delete the temp file
      err_file.close(true)
      # This is somewhat of a kludge.  Since popen uses a shell, the
      # exit status is what the shell returns.  Usually if the process
      # exited with a signal, the exit status from the shell will be
      # 128 plus the signal number.  This is true for bash and ksh and
      # probably all other used shells.
      if exit_status.exited?
        if exit_status.exitstatus > 128
          exit_code = -1
          exit_signal = Signum2Name[exit_status.exitstatus - 128] || "XXXX"
        else
          exit_code = exit_status.exitstatus
          exit_signal = ""
        end
      else
        exit_code = -1
        exit_signal = Signum2Name[exit_code.termsig] || "XXXX"
      end
      [stdout_data, stderr_data, exit_code, exit_signal ]
    end
  end
end
