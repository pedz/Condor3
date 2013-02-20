# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model representing the equivalent of a CMVC defect
class Defect < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the defect.  e.g. 543543

  ##
  # :attr: cq_defect
  # The CQ name for the defect.  e.g. AW12345

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: apar_defect_version_maps
  # A has_many association to the AparDefectVersionMap records.
  has_many :apar_defect_version_maps

  ##
  # :attr: upd_pc_views
  # A has_many association to the UpdPcView records.
  has_many :upd_pc_views
  
  # Secondary relations
  ##
  # :attr: apars
  # A has_many association to Apar via AparDefectVersionMap
  has_many :apars,                :through => :apar_defect_version_maps

  ##
  # :attr: versions
  # A has_many association to Version via AparDefectVersionMap
  has_many :versions,             :through => :apar_defect_version_maps

  ##
  # :attr: adv_ptf_release_maps
  # A has_many association to AdvPtfReleaseMap via AparDefectVersionMap
  has_many :adv_ptf_release_maps, :through => :apar_defect_version_maps

  # Returns the Ptf records that shipped the defect.
  def ptfs
    self.adv_ptf_release_maps.map { |m| m.ptf }
  end

  # Returns the CMVC Release records where the defect was released.
  def releases
    self.adv_ptf_release_maps.map { |m| m.release }
  end

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
