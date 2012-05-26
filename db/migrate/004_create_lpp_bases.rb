# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# The ptfapardef.constant files have a column which seems to be the
# stem of the lpp name.  I call it the lpp_base.  The lpp table has a
# reference to the lpp_base.
class CreateLppBases < ActiveRecord::Migration
  def self.up
    create_table :lpp_bases do |t|
      t.string :name, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :lpp_bases
  end
end
