# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# It may be that a fileset ships in only one service pack but I rather
# doubt it.  And clearly a service pack ships many filesets.  So the
# mapping must be many to many.  This map provides that.
class CreateServicePackFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :service_pack_fileset_maps do |t|
      t.fk :service_pack_id
      t.fk :fileset_id
      t.timestamps
      t.unique [ :service_pack_id, :fileset_id ]
    end
    add_index :service_pack_fileset_maps, :fileset_id
  end

  def self.down
    drop_table :service_pack_fileset_maps
  end
end
