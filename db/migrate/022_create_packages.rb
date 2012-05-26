# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# A package as found on the disk.  The sha1 should uniquely determine
# the package to a high probability.
class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :name, :null => false
      t.string :sha1, :null => false
      t.timestamps
      t.unique [ :name, :sha1 ]
    end
  end

  def self.down
    drop_table :packages
  end
end
