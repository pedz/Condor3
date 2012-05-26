# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#
# This migration ties in with a change to import_pc_views.  I added
# the pc_id to the apar_defect_version_maps table thinking that it
# might make updating from RP2 easier.  The key is adding cq_defect to
# defects to keep trace of the cq defect name.
#
class AddCqAndPcId < ActiveRecord::Migration
  def self.up
    # Trying to not allow nulls.  A pc_id of -1 will mean that we
    # don't know it.
    add_column(:apar_defect_version_maps, :pc_id, :integer,
               { :default => -1, :null => false })

    # ditto from above... disallow nulls.  Let cq_defect default to
    # "NONE"
    add_column(:defects, :cq_defect, :string,
               { :default => "NONE", :null => false })
  end

  def self.down
    remove_column :apar_defect_version_maps, :pc_id
    remove_column :defects, :cq_defect
  end
end
