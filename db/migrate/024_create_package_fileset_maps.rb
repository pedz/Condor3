# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# A package ships many filesets.  But the next package may ship a
# subset of the previous filesets un changed.  Thus there must be a
# many to many mapping from packages to filesets.  This map provides
# that mappig.
class CreatePackageFilesetMaps < ActiveRecord::Migration
  def self.up
    create_table :package_fileset_maps do |t|
      t.fk :package_id
      t.fk :fileset_id
      t.timestamps
      t.unique [ :package_id, :fileset_id ]
    end
  end

  def self.down
    drop_table :package_fileset_maps
  end
end
