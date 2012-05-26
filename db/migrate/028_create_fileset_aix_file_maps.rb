# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# A fileset ships many files.  But if only one file changes, the next
# fileset will ship many of the same files.  Thus there is a many to
# many mapping between AIX files and filesets.  This map provides that
# mapping.
class CreateFilesetAixFileMaps < ActiveRecord::Migration
  def self.up
    create_table :fileset_aix_file_maps do |t|
      t.fk :fileset_id
      t.fk :aix_file_id
      t.timestamps
      t.unique [ :fileset_id, :aix_file_id ]
    end
  end

  def self.down
    drop_table :fileset_aix_file_maps
  end
end
