# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# The tuple of Apar, Defect, Version is created by either scanning the
# ptfapardef.constant files or the pc_view table from rp2.  Both are
# used.
class AparDefectVersionMap < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: apar_id
  # The id of the referenced Apar

  ##
  # :attr: defect_id
  # The id of the referenced Defect
  
  ##
  # :attr: version_id
  # The id of the referenced Version
  
  ##
  # :attr: pc_id
  # The pc_id field from the pc_view table from rp2.  This field is
  # used as one reference point to keep Condor's database in line with
  # rp2's tables.

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: apar
  # A belongs_to association to the referenced Apar
  belongs_to :apar

  ##
  # :attr: defect
  # A belongs_to association to the referenced Defect
  belongs_to :defect

  ##
  # :attr: version
  # A belongs_to association to the referenced Version
  belongs_to :version

  ##
  # :attr: adv_ptf_release_maps
  # A has_many association to AdvPtfReleaseMap
  has_many   :adv_ptf_release_maps

  # Secondary Relations
  ##
  # :attr: ptfs
  # A has_many association to Ptf via the AdvPtfReleaseMap
  has_many   :ptfs,     through: :adv_ptf_release_maps

  ##
  # :attr: releases
  # A has_many association to Release via the AdvPtfReleaseMap
  has_many   :releases, through: :adv_ptf_release_maps
end
