# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a PTF.
class Ptf < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the PTF. e.g. U123456

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: adv_ptf_release_maps
  # A has_many association of AdvPtfReleaseMap records that belong to
  # this PTF.
  has_many :adv_ptf_release_maps

  ##
  # :attr: fileset_ptf_maps
  # A has_many association of FilesetPtfMap records that belong to
  # this PTF.
  has_many :fileset_ptf_maps
  
  ##
  # :attr: upd_pc_views
  # A has_many association of UpdPcView that belong to this PTF.
  has_many :upd_pc_views
  
  # Secondary relations
  ##
  # :attr: apar_defect_version_maps
  # A has_many association of AparDefectVersionMap via adv_ptf_release_maps
  has_many :apar_defect_version_maps, :through => :adv_ptf_release_maps

  ##
  # :attr: releases
  # A has_many association of Release via adv_ptf_release_maps
  has_many :releases,                 :through => :adv_ptf_release_maps

  ##
  # :attr: filesets
  # A has_many association of Fileset via fileset_ptf_maps
  has_many :filesets,                 :through => :fileset_ptf_maps

  # Returns the Apar records via apar_defect_version_maps
  def apars
    self.apar_defect_version_maps.map { |m| m.apar }
  end

  # Returns the Defect records via apar_defect_version_maps
  def defects
    self.apar_defect_version_maps.map { |m| m.defect }
  end

  # Returns the Version records via apar_defect_version_maps
  def versions
    self.apar_defect_version_maps.map { |m| m.version }
  end

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
