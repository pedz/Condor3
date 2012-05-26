# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# rp2 has the concept of a version rather than a cmvc release.  (It
# has cmvc release as well in the source file records.)  When the
# pc_view is entered, the version is kept.  It appears that the triple
# (defect, version) uniquely identifies an APAR but I don't make the
# assumption that that is true.  We assume that the version name is
# always three bytes.  Currently there are two exceptionts to this:
# "32" and "13_64".
class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string :name, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
