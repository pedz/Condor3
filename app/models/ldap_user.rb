# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

#
# This is a class which should fetch entries from bluepages.  Many
# things need to be finalized because I do not know much about LDAP.
# But, that will happen over time.
#
class LdapUser < ActiveLdap::Base
  ldap_mapping(dn_attribute: 'uid',
               prefix: 'ou=bluepages',
               classes: [ 'ibmPerson' ])

  ##
  # :attr: mgr
  # A belongs_to assocation to the LdapUser manager for the current
  # LdapUser.
  belongs_to :mgr, class: 'LdapUser', foreign_key: 'manager', primary_key: 'dn'

  ##
  # :attr: deptmnt
  # A belongs_to assocation to the LdapDept for this LdapUser.
  belongs_to :deptmnt, class: 'LdapDept', foreign_key: 'dept', primary_key: 'dept'

  ##
  # :attr: mgr
  # A belongs_to assocation to the manager for this LdapUser.
  has_many   :manages, class: 'LdapUser', foreign_key: 'manager', primary_key: 'dn'

  # Used by the authentication processing.  Returns true if the
  # password is the correct password for the user specified by the
  # email address.
  def self.authenticate_from_email(email, password)
    return nil unless (u = find(:first, attribute: 'mail', value: email, attributes: [ 'dn']))
    begin
      # dn = u.dn.to_s.gsub(/\+/, "\\\\+")
      dn = u.dn.to_s
      logger.info("authenticate_from_email #{email} => #{dn}")
      u.connection.rebind(allow_anonymous: false, password: password, bind_dn: dn)
    rescue => e
      # logger.debug("authenticate_from_email denied #{e.class} #{e.message}")
      nil
    end
  end

  # def manages
  #   find(:all, attribute: 'manager', value: dn)
  # end

  # Used for interactive debugging only to fetch my ldap entry.
  def self.q
    find(:first, attribute: 'mail', value: 'pedzan@us.ibm.com')
  end

  private

  # def to_real_attribute_name(name, allow_normalized_name=nil)
  #   allow_normalized_name = true if allow_normalized_name.nil?
  #   super(name, allow_normalized_name)
  # end
end
