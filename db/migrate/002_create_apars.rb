# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Table for APARs
# Note that abstract may be null (which sucks) but in the case that
# the APAR is found first via a pc_view record, the abstract is not
# known.  We later fill it in when we find the ptfapardef record.
class CreateApars < ActiveRecord::Migration
  def self.up
    create_table :apars do |t|
      t.string :name, :null => false, :unique => true
      t.string :abstract
      t.timestamps
    end
  end

  def self.down
    drop_table :apars
  end
end
