# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#
# The upd_pc_views is a direct mapping of the upd_pc_view from rp2.
# The update_id and pc_id are unchanged.  They can be used to find if
# the rp2 record already exists in Condor or not.  The other id's have
# the same meaning but are remapped.  For example, ptf_name from the
# rp2 view is replaced with ptf_id.  Here is the complete list.
#
# bc_name is the build name.  It is kept unchanged.
#
# ptf_id is found by taking ptf_name and finding it in the ptfs table
# and then using its id.
#
# fileset_id is found by looking up fileset_name in lpps to get the
# lpp_id and then finding the lpp_id plus vrmf tuple in the filesets
# table.  Using that id as fileset_id.
#
# The defect_name is looked up in defects and its id is used as
# defect_id.
#
# The version_name is looked up in versions and its id is used as
# version_id.
#
class CreateUpdPcViews < ActiveRecord::Migration
  def self.up
    create_table :upd_pc_views do |t|
      t.integer :update_id
      t.integer :pc_id
      t.string  :bc_name
      t.fk      :ptf_id
      t.fk      :fileset_id
      t.fk      :defect_id
      t.fk      :version_id
      t.timestamps
      t.unique [ :update_id, :pc_id ]
    end
  end

  def self.down
    drop_table :upd_pc_views
  end
end
