# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :ldap_id, :null => false, :unique => true
      t.boolean :admin, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
