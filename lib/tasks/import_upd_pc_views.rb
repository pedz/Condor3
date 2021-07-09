# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#!/usr/bin/env ruby
#
# This script will read in upd_pc_views that come from rp2.  Initially
# these are pulled out for all existing records.  For updates, we will
# find new pc_view via the last modified stamp they have.  We will
# then find all upd_pc_view with those pc_view ids.
#
# The upd_pc_view records from rp2 have:
# upd_pc_view: 
#                 update_id
#                 ptf_name
#                 fileset_id
#                 fileset_name
#                 vrmf
#                 pc_id
#                 defect_name
#                 bc_name
#                 product_id
#                 product_name
#                 version_id
#                 version_name
#
# Our upd_pc_views table has:
#       t.integer :update_id
#       t.integer :pc_id
#       t.fk :ptf_id
#       t.fk :fileset_id
#       t.fk :defect_id
#       t.fk :version_id
#
# We map between them thus:
# 
# update_id and pc_id are unchanged and is used to match records from
# rp2.
#
# bc_name is the build name.  It is kept unchanged.
#
# ptf_id is found by taking ptf_name and finding it in the ptfs table
# and then using its id.
#
# fileset_id is found by looking up fileset_name in lpps to get the
# lpp_id and then finding the lpp_id plus vrmf tuple in the filesets
# table.  Using that id as fileset_id.
#
# The defect_name is looked up in defects and its id is used as
# defect_id.
#
# The version_name is looked up in versions and its id is used as
# version_id.

GOOD_FAMILY = Regexp.new("aix")
GOOD_VERSION = Regexp.new("^(5[234].|[67]..)$")

Rails.logger.level = ActiveSupport::BufferedLogger::WARN

# reload_libs loads all the files */**/*.rb which includes this
# file.  The 'if' statement below prevents this file from causing an
# exception during the reload processing.
if ARGV[0]
  File.open(ARGV[0]) do |file|
    begin
      UpdPcView.transaction do
        file.each_line do |line|
          line.chomp!
          update_id, ptf_name, fileset_id, fileset_name, vrmf, pc_id,
          defect_name, bc_name, product_id, product_name, version_id,
          version_name = line.split('|')
          next unless GOOD_FAMILY.match(product_name)
          next unless GOOD_VERSION.match(version_name)
          
          ptf = Ptf.find_or_create_by_name ptf_name
          fileset_base_name = fileset_name.sub(/\..*/, '')
          lpp_base = LppBase.find_or_create_by_name fileset_base_name
          lpp = lpp_base.lpps.find_or_create_by_name fileset_name
          fileset = lpp.filesets.find_or_create_by_vrmf vrmf
          defect = Defect.find_or_create_by_name defect_name
          version = Version.find_or_create_by_name version_name

          upd_pc_view = UpdPcView.find(:first,
                                       :conditions => {
                                         :update_id => update_id,
                                         :pc_id => pc_id })
          if upd_pc_view
            upd_pc_view.update_attributes({ :bc_name => bc_name,
                                            :ptf_id => ptf.id,
                                            :fileset_id => fileset.id,
                                            :defect_id => defect.id,
                                            :version_id => version.id
                                          })
          else
            UpdPcView.create({ :update_id => update_id,
                               :pc_id => pc_id,
                               :bc_name => bc_name,
                               :ptf_id => ptf.id,
                               :fileset_id => fileset.id,
                               :defect_id => defect.id,
                               :version_id => version.id
                             })
          end
        end
      end
    rescue => e
      puts e.message
      puts e.backtrace
      puts "Line number is #{file.lineno}"
      exit- 1
    end
  end
end
