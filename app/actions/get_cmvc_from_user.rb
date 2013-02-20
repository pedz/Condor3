# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class GetCmvcFromUser
  ##
  # :attr: errors
  # Errors that were encountered while doing the translation
  attr_reader :errors

  ##
  # :attr: cmvc
  # The cmvc id for this user.  If any error occurred, this will be nil
  attr_reader :cmvc

  def initialize(options)
    @options = options

    @errors = []
    @cmvc = nil

    begin
      if user.nil?
        @errors << "User not found"
        return
      end
    rescue
      @errors << "Exception encountered when fetching user"
    end
    
    cmvc_temp = user.cmvc

    if cmvc_temp.nil? || cmvc_temp.login.nil? || cmvc_temp.login.blank?
      # Fetch the LdapUser for this User
      unless l = user.ldap
        @errors << "User does not have LDAP entry"
        return
      end

      # Must have a uid
      unless !ldap.attribute_present?(:uid) || (uid = ldap.uid) || uid.blank?
        @errors << "User's uid field in LDAP is blank"
        return
      end

      # Need a bootstrap cmvc id.  This can not be saved because there
      # is not user associated with it.
      unless (boot_cmvc = Cmvc.find_or_create_by_login(CmvcHost::BootstrapCmvcUser) && !boot_cmvc.blank?)
        @errors << "No bootstrap CMVC user set up"
        return
      end
      
      cmd_hash = {
        get_user: -> { Struct.new(:cmvc).new(boot_cmvc) }
        cmd: 'Report',
        family: 'aix',
        general: 'UserView',
        where: "ccnum = '#{uid.downcase}' or ccnum = '#{uid}'",
        select: "login"
      }

      # Find the CMVC User whoes ccum matches the uid
      cmvc_command = model.new(cmd_hash)

      # Clean up output -- should be a single line with just the cmvc
      # login.
      stdout = cmvc_command.stdout.chomp
      # CMVC login must not be blank
      if stdout.blank?
        @errors << "CMVC search for ccnum = #{uid} returned no results"
        return
      end

      # Dance to create a new Cmvc record for this User
      cmvc_temp = user.build_cmvc
      cmvc_temp.login = stdout
      cmvc_temp.save!
    end

    # Set @cmvc only if everything completed successfully
    @cmvc = cmvc_temp
  end

  private
  
  def model
    @model ||= @options[:model] || ExecuteCmvcCommand
  end

  # Not used yet
  def cache
    @cache ||= @options[:cache] || Condor3::Application.config.my_dalli
  end

  def user
    @user ||= @options[:get_user].call
  end
end
