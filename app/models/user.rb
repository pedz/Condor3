# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# The User record for the application.  The ldap_id is the email
# intranet address of the user.
class User < ActiveRecord::Base
  # Raised if User does not have an LdapUser record.  Possibly thrown
  # when cmvc is accessed.
  class NoLDAP < Exception
  end

  # Raised if LdapUser associated with this User does not a uid field.
  # Possibly thrown when cmvc is accessed.
  class NoUID < Exception
  end

  # Raised if bootstrap_cmvc_user can not be created.
  class NoBootStrap < Exception
  end

  # Raised if no CMVC record matching UID field of the LdapUser
  # associate with this User can be found.
  class LoginNotFound < Exception
  end

  # Raised if the CMVC command to fetch returns an error
  class PopenFailed < Exception
  end

  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: ldap_id
  # The intranet email address for the user.

  ##
  # :attr: admin
  # A boolean to determine if the user is an admin for the site.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: cmvc
  # A has_one association to the Cmvc record for this User
  has_one :cmvc

  attr_protected :ldap_id, :admin

  accepts_nested_attributes_for :cmvc, :allow_destroy => true

  def ldap
    LdapUser::find(:attribute => 'mail', :value => ldap_id)
  end

  # Used for fun... Returns (or tries to) the first name of the User
  # from the LdapUser record.
  def first_name
    @first_name ||= 
      if (given = ldap.givenName).is_a? Array
        given.min { |a, b| a.length <=> b.length }
      else
        given
      end
  end

  # Override cmvc association.  If there is no Cmvc for this User,
  # attempts are made to determine what it is.  All cmvc activity
  # needs to have a real cmvc id and this otherride ensures that that
  # is the case.  The original cmvc association could be called
  # e.g. raw_cmvc and it could be made private but there didn't seem a
  # need for that.
  def cmvc
    cmvc_temp = super
    if cmvc_temp.nil? || cmvc_temp.login.nil? || cmvc_temp.login.blank?
      # Fetch the LdapUser for this User
      raise NoLDAP.new unless l = self.ldap
      # Must have a uid
      raise NoUID.new unless (uid = ldap.uid) || uid.blank?
      # Need a bootstrap cmvc id.  This can not be saved because there
      # is not user associated with it.
      raise NoBootStrap.new unless (boot_cmvc = Cmvc.find_or_initialize_by_login(CmvcHost::BootstrapCmvcUser) &&
                                    !boot_cmvc.blank?)
      # Find the CMVC User whoes ccum matches the uid
      cmvc_command = boot_cmvc.report!(:family => 'aix',
                                       :general => 'UserView',
                                       :where => "ccnum = '#{uid.downcase}' or ccnum = '#{uid}'",
                                       :select => "login")

      # Clean up output -- should be a single line with just the cmvc
      # login.
      stdout = cmvc_command.stdout.chomp
      # CMVC login must not be blank
      raise LoginNotFound.new if stdout.blank?
      # Dance to create a new Cmvc record for this User
      cmvc_temp = build_cmvc
      cmvc_temp.login = stdout
      cmvc_temp.save
    end
    cmvc_temp
  end
end
