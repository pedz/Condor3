# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Condor copies most of what is in two views of RP2: pc_view and
# upd_pc_view.  The former essentially creates the
# AparDefectVersionMap although those entries may also be created by
# scanning the ptfapardef.constant files.  The latter (upd_pc_view) is
# essentially just copy into this model.
class UpdPcView < ActiveRecord::Base
  ##
  # :attr: id
  # The Integer primary key for the table.

  ##
  # :attr: update_id
  # The update_id from RP2.  It along with the pc_id form a key for
  # the table and is used to match up entries with RP2 entries.

  ##
  # :attr: pc_id
  # The pc_id field from RP2

  ##
  # :attr: bc_name
  # I believe this matches the CMVC build name.

  ##
  # :attr: ptf_id
  # The id attribute of the associated Ptf

  ##
  # :attr: fileset_id
  # The id attribute of the associated Fileset

  ##
  # :attr: defect_id
  # The id attribute of the associated Defect

  ##
  # :attr: version_id
  # The id attribute of the associated Version

  ##
  # :attr: created_at
  # Rails normal created_at timestamp that is when the db record was
  # created.

  ##
  # :attr: updated_at
  # Rails normal updated_at timestamp.  Each time the db record is
  # saved, this gets updated.

  ##
  # :attr: ptf
  # A belongs_to association to the Ptf
  belongs_to :ptf
  
  ##
  # :attr: fileset
  # A belongs_to association to the Fileset
  belongs_to :fileset
  
  ##
  # :attr: defect
  # A belongs_to association to the Defect
  belongs_to :defect

  ##
  # :attr: version
  # A belongs_to association to the Version
  belongs_to :version
end
