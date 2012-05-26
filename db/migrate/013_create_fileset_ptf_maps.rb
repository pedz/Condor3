# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# As described in Notes, the ptf to fileset mapping must be many to
# many.  This map does that.
class CreateFilesetPtfMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_ptf_maps do |t|
      t.fk :fileset_id
      t.fk :ptf_id
      t.timestamps
      t.unique [ :fileset_id, :ptf_id ]
    end
    add_index :fileset_ptf_maps, :ptf_id
  end

  def self.down
    drop_table :fileset_ptf_maps
  end
end
