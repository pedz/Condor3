# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# A fileset is distinguished by the lpp name and the vrmf.  Just to
# repeat it here, a package is a group of filesets (not the other way
# around).  And a fileset is a group of files which I call aix_paths.
class CreateFilesets < ActiveRecord::Migration
  def self.up
    create_table :filesets do |t|
      t.fk :lpp_id
      t.string :vrmf, :null => false
      t.timestamps
      t.unique [ :lpp_id, :vrmf ]
    end
  end

  def self.down
    drop_table :filesets
  end
end
