# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Table for Defects
class CreateDefects < ActiveRecord::Migration
  def self.up
    create_table :defects do |t|
      t.string :name, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :defects
  end
end
