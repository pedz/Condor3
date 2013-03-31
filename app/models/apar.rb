# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents an Retain APAR
class Apar < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the APAR such as IX12345
  
  ##
  # :attr: abstract
  # The abstract gathered from the ptfapardef.constant

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
  # A has_many association to AparDefectVersionMap
  has_many :apar_defect_version_maps

  # Secondary associations
  ##
  # :attr: defects
  # A has_many association to Defect via AparDefectVersionMap
  has_many :defects,              through: :apar_defect_version_maps

  ##
  # :attr: versions
  # A has_many association to Version via AparDefectVersionMap
  has_many :versions,             through: :apar_defect_version_maps

  ##
  # :attr: adv_ptf_release_maps
  # A has_many association to AdvPtfReleaseMap via AparDefectVersionMap
  has_many :adv_ptf_release_maps, through: :apar_defect_version_maps

  # Returns the PTFs that contain this APAR.
  def ptfs
    self.adv_ptf_release_maps.map { |m| m.ptf }
  end

  # Returns the releases that contain this APAR.
  def releases
    self.adv_ptf_release_maps.map { |m| m.release }
  end

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
