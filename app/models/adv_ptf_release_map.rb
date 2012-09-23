# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# This model is a join table between AparDefectVersionMap, Ptf, and
# Release.  This roughly equates to a single line in the
# ptfapardef.constant files.
class AdvPtfReleaseMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: apar_defect_version_map_id
  # The id of the AparDefectVersionMap
  
  ##
  # :attr: ptf_id
  # The id of the PTf
  
  ##
  # :attr: release_id
  # The id of the Release

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: apar_defect_version_map
  # A belongs_to association to an AparDefectVersionMap
  belongs_to :apar_defect_version_map

  ##
  # :attr: ptf
  # A belongs_to association to a Ptf
  belongs_to :ptf

  ##
  # :attr: release
  # A belongs_to association to a Release
  belongs_to :release
end
