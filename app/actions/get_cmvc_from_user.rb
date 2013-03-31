# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# An _action_ that retrieves the CMVC id for a given "user".  The
# result is returned in the +stdout+ attribute if there is no error.
# The "user" is fetched when the +:get_user+ lambda is called.  If the
# +cmvc_login+ attribute is already set, then that is set into
# +stdout+.  Otherwise, a call to ExecuteCmvcCommand is done to try
# and retrieve the id from CMVC.
#
# A real user will be a User record.  The +ldap_id+ will be the
# intranet id for the user and is used to query the bluepages ldap
# server for the user.  The ldap entry should have a +uid+ field in
# it.  This field should match the +ccnum+ field of the CMVC record
# for the user.  To recap: user.ldap_id.uid == user.cmvc_login.ccnum
# (although the ccnum field is not saved).
#
# The command passed to ExecuteCmvcCommand is a Report to query and
# find this match.  When this command is done, the +:get_user+ field
# in the +options+ hash will point to a lambda that returns a
# PseudoCmvc struct with the +cmvc_login+ field filled out to
# CmvcHost::BootstrapCmvcUser.
#
# ExecuteCmvcCommand and the CmdResult classes may be passed in via
# +options+ to facilitate testing.
class GetCmvcFromUser
  # A Struct having a single attribute of +cmvc_login+ and satisfies
  # the duck type needed by this class
  PseudoCmvc = Struct.new(:cmvc_login)
  
  # Contains the user's cmvc id upon successful completion.
  def stdout
    @cmd_result.stdout
  end
  
  # Contains any error messages received during the lookup of the CMVC
  # id.
  def stderr
    @cmd_result.stderr
  end
  
  # The process's exit status of the command used to look up the CMVC
  # id.
  def rc
    @cmd_result.rc
  end
  
  # The name of the signal, if any, causing the lookup process to
  # terminate.
  def signal
    @cmd_result.signal
  end
  
  # * *Args*    :
  #   - +options+ -> A hash providing:
  #     * +:get_user+ -> A lambda returning a duck type with a
  #       read/write attribute of cmvc_login.
  #     * +:cache+ -> An optional cache objec that defaults to
  #       Condor3::Application.config.my_dalli
  #     * +:cmd_result+ -> An optional class name that defaults to
  #       CmdResult.
  #     * +:execute_cmvc_command+ -> An optional class name that
  #       defaults to ExecuteCmvcCommand
  def initialize(options = {})
    @options = options.dup

    begin
      if user.nil?
        @cmd_result = cmd_result.new(stderr: "User not found")
        return
      end
    rescue => e
      @cmd_result = cmd_result.new(stderr: "Exception encountered when fetching user: #{e.message}")
      return
    end
    
    cmvc_login = user.cmvc_login
    unless cmvc_login.blank?
      @cmd_result = cmd_result.new(stdout: cmvc_login)
      return
    end

    # Fetch the LdapUser for this User
    unless ldap = user.ldap
      @cmd_result = cmd_result.new(stderr: "User does not have LDAP entry")
      return
    end
    
    # Must have a uid
    unless ldap.respond_to?(:attribute_present?) &&
        ldap.attribute_present?(:uid) && (uid = ldap.uid) && !uid.blank?
      @cmd_result = cmd_result.new(stderr: "User's uid field in LDAP is blank or missing")
      return
    end

    # Need a bootstrap cmvc id.  This can not be saved because there
    # is no user associated with it.
    boot_cmvc = CmvcHost::BootstrapCmvcUser
    if boot_cmvc.blank?
      @cmd_result = cmd_result.new(stderr: "No bootstrap CMVC user set up")
      return
    end
    
    cmd_hash = {
      get_user: -> { PseudoCmvc.new(boot_cmvc) },
      cmd: 'Report',
      family: 'aix',
      general: 'UserView',
      where: "ccnum = '#{uid.downcase}' or ccnum = '#{uid}'",
      select: "login"
    }
    
    # Find the CMVC User whoes ccum matches the uid
    @cmd_result = execute_cmvc_command.new(cmd_hash)
    return if @cmd_result.rc != 0
    
    # Clean up output -- should be a single line with just the cmvc
    # login.
    @cmd_result.stdout.chomp!
    # CMVC login must not be blank
    if stdout.blank?
      @cmd_result = cmd_result.new(stderr: "CMVC search for ccnum = #{uid} returned no results")
      return
    end
    
    # Dance to create a new Cmvc record for this User
    user.cmvc_login = stdout
  end

  private
  
  def execute_cmvc_command
    @execute_cmvc_command ||= @options.delete(:execute_cmvc_command) || ExecuteCmvcCommand
  end

  def cmd_result
    @cmd_result ||= @options.delete(:cmd_result) || CmdResult
  end

  # Not used yet
  def cache
    @cache ||= @options.delete(:cache) || Condor3::Application.config.my_dalli
  end

  def user
    @user ||= @options.delete(:get_user).call
  end
end
