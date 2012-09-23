# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model for the base component of an Lpp's name.  For example
# devices.pci.14106602.diag will have an LppBase of devices.  I'm not
# sure at this point where this is actually used.
class LppBase < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the LppBase

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: lpps
  # A has_many association to the Lpp records that has this same base
  # component for their name.
  has_many :lpps

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
