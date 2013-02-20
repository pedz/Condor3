# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# The User record for the application.  The ldap_id is the email
# intranet address of the user.
class User < ActiveRecord::Base
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
end
