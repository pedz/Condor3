# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class GetCmvcFromUser
  PseudoCmvc = Struct.new(:cmvc_login)
  
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
  
  # Options include :get_user which is a proc / lambda that is called
  # to return an object that can fulfill a user roll.  The user roll
  # needs to support a cmvc method and a set_cmvc method.
  def initialize(options = {})
    @options = options

    begin
      if user.nil?
        @cmd_result = cmd_result.new(stderr: "User not found")
        return
      end
    rescue
      @cmd_result = cmd_result.new(stderr: "Exception encountered when fetching user")
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
    stdout = @cmd_result.stdout.chomp
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
    @execute_cmvc_command ||= @options[:execute_cmvc_command] || ExecuteCmvcCommand
  end

  def cmd_result
    @cmd_result ||= @options[:cmd_result] || CmdResult
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  def user
    @user ||= @options[:get_user].call
  end
end
