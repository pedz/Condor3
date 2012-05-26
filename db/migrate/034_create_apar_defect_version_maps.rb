# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Essentially these maps are produced from the pc_view input.  The
# exception is when a ptfapardef record specifies something that has
# not yet been seen in a pc_view record.
#
# While the pc_view has other data, it does not seem to be of use.
# In particular, the un-listed PTF field is not used.  In the pc_view
# it is just a PTF and there is not a release nor a fileset in the
# pc_view.  Subsequent calls to rp2 could be made to flush out the
# information but the belief is that eventually (perhaps even at the
# same time) the same information will be present in a ptfapardef
# record and the form in that record is far easier to work with.
class CreateAparDefectVersionMaps < ActiveRecord::Migration
  def self.up
    create_table :apar_defect_version_maps do |t|
      t.fk :apar_id
      t.fk :defect_id
      t.fk :version_id
      t.timestamps
      t.unique [ :apar_id, :defect_id, :version_id ]
    end
    add_index :apar_defect_version_maps, :defect_id
    add_index :apar_defect_version_maps, :version_id
  end

  def self.down
    drop_table :apar_defect_version_maps
  end
end
