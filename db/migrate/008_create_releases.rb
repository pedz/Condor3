# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Its unfortunate but "release" has two meanings.  I believe
# everywhere in Condor, "release" will be a cmvc release and not a
# release such as "5.2", etc.
# From the ptfapardef records a release will always point to a family
# (although of questionable value).  To get the link from the
# ptfapardef records to the pc_view records, a release will also point
# to a version.  The version will be the ending substring of the
# release.  Currently all versions we care about are exactly three
# characters.
class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name, :null => false
      t.fk :family_id
      t.fk :version_id
      t.timestamps
      t.unique [ :name, :family_id ]
    end
  end

  def self.down
    drop_table :releases
  end
end
