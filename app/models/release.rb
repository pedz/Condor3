# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a CMVC release
class Release < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: name
  # The name of the Release e.g. bos61J

  ##
  # :attr: family_id
  # The id of the Family the Release is a part of

  ##
  # :attr: version_id
  # The Version associated with the Release.  e.g. bos61J will be
  # asslocated with Version 61J

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: family
  # A belongs_to association of Family
  belongs_to :family

  ##
  # :attr: version
  # A belongs_to association of Version
  belongs_to :version

  ##
  # :attr: adv_ptf_release_maps
  # A has_many association of AdvPtfReleaseMap
  has_many   :adv_ptf_release_maps
  
  # Secondary relations
  ##
  # :attr: apars
  # A has_many association of Apar records via adv_ptf_release_maps
  has_many :apars,    through: :adv_ptf_release_maps

  ##
  # :attr: defects,  through: :adv_ptf_release_maps
  # A has_many association of Defect records via adv_ptf_release_maps
  has_many :defects,  through: :adv_ptf_release_maps

  ##
  # :attr: versions
  # A has_many association of Version records via adv_ptf_release_maps
  has_many :versions, through: :adv_ptf_release_maps

  # returns self.name <=> other.name
  def <=>(other)
    self.name <=> other.name
  end
end
