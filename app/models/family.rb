# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# CMVC has "family" which is usually 'aix' or 'admin'.
class Family < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The CMVC name of the family.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: releases
  # A has_many association to the Release records associated with this
  # family
  has_many :releases

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
