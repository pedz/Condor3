# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# A file as it appears on an installed AIX system.  The sha1 is
# computed so it can be determined when the shipped file actually
# changes.  We also create an index on the basename to help
# which_filesets.
class CreateAixFiles < ActiveRecord::Migration
  def self.up
    create_table :aix_files do |t|
      t.string :path, :null => false
      t.string :sha1, :null => false
      t.timestamps
      t.unique [ :path, :sha1 ]
    end
    # add_index :aix_files, "basename(path)"
    execute "CREATE INDEX base_file_name_idx ON aix_files(basename(path));"
  end

  def self.down
    # execute "DROP INDEX base_file_name_idx;"
    drop_table :aix_files
  end
end
