# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Table of lpp names.  See notes in 004_create_lpp_bases.rb about lpp_base_id
class CreateLpps < ActiveRecord::Migration
  def self.up
    create_table :lpps do |t|
      t.string :name, :null => false
      t.fk :lpp_base_id
      t.timestamps
      t.unique [ :name, :lpp_base_id ]
    end
  end

  def self.down
    drop_table :lpps
  end
end
