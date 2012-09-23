# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents an LPP.  An LPP is something like "bos.mp64"
# and can be thought of as the parent of a list of Filesets.
class Lpp < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the LPP
  
  ##
  # :attr: lpp_base_id
  # The id of the LppBase that this Lpp is part of.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: lpp_base
  # A belongs_to association to the LppBase that this Lpp belongs to.
  belongs_to :lpp_base

  ##
  # :attr: filesets
  # A has_many association to Fileset records belonging to this Lpp
  has_many :filesets

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
