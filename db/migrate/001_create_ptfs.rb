# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Table for PTFs
class CreatePtfs < ActiveRecord::Migration
  def self.up
    create_table :ptfs do |t|
      t.string :name, :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :ptfs
  end
end
