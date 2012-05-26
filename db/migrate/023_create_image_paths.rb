# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# An image path is somewhat completely concocted but I keep them to
# help figure out which image paths I have not ransacked yet.
#
# I'm going to build on top of this arbitrariness by adding a
# non-package package.  All flat files that the scan mounts script
# comes accross will add an entry in to the image paths.  If the image
# really is a package then a real package record will be entered and
# used.  Otherwise, the image will point to the non-package package.
class CreateImagePaths < ActiveRecord::Migration
  def self.up
    create_table :image_paths do |t|
      t.string :path, :null => false, :unique => true
      t.fk :package_id
      t.timestamps
    end
  end

  def self.down
    drop_table :image_paths
  end
end
