# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# RP2 groups CMVC Release names into their common Version.  For
# example, a CMVC Release of 'bos61J' will have a Version of '61J'.
class Version < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the Version

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
  # A has_many association of Release records for this Version
  has_many :releases
  
  ##
  # :attr: apar_defect_version_maps
  # A has_many association of AparDefectVersionMap records for this Version
  has_many :apar_defect_version_maps
  
  ##
  # :attr: upd_pc_views
  # A has_many association of UpdPcView records for this Version
  has_many :upd_pc_views
  
  # Secondary relations
  ##
  # :attr: defects
  # A has_many association of Defect records referencing this Version via
  # apar_defect_version_maps
  has_many :defects,  through: :apar_defect_version_maps

  ##
  # :attr: ptfs,     through: :apar_defect_version_maps
  # A has_many association of Ptf records referencing this Version via
  # apar_defect_version_maps
  has_many :ptfs,     through: :apar_defect_version_maps

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
