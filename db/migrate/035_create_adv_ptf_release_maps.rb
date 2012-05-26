# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# These maps are produced from the ptfapardef records.  The first
# piece is the apar, defect, version mapping.  This is usually created
# before this mapping.  The creation process for this mapping first
# finds the apar_defect_version_map.  This is done by taking the apar
# and defect from the ptfapardef record.  The release in the record is
# mapped to a version by taking the last three characters of the
# release's name.  The apar_defect_version_map is then found or
# created if needed.  Its id is then used in this record along with
# the other ids.  There is a small bit of duplicate information in
# that the release points to a version.  The version can also be found
# by going to the apar_defect_version_map.  So... in theory only the
# release's leading characters should be saved...
class CreateAdvPtfReleaseMaps < ActiveRecord::Migration
  def self.up
    create_table :adv_ptf_release_maps do |t|
      t.fk :apar_defect_version_map_id
      t.fk :ptf_id
      t.fk :release_id
      t.timestamps
      t.unique [ :apar_defect_version_map_id, :ptf_id, :release_id ]
    end
    add_index :adv_ptf_release_maps, :apar_defect_version_map_id
    add_index :adv_ptf_release_maps, :ptf_id
    add_index :adv_ptf_release_maps, :release_id
  end

  def self.down
    drop_table :adv_ptf_release_maps
  end
end
