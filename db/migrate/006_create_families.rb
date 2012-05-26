# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# The 7th field in a ptfapardef.constant record I call 'family' -- I
# have no idea why.  It appears to be completely useless.
class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :name, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :families
  end
end
