#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:lpp_name) do |n|
    seq = ["IPP", "devices.scsi.disk.diag.rte", "X11.compat.lib.X11R5",
           "X11.motif.lib", "devices.pci.14106602.diag", "bos.rte.odm",
           "bos.rte.libcfg", "X11.base.lib", "bos.alt_disk_install.rte",
           "bos.sysmgt.quota" ]
    seq[n % seq.length]
  end

  factory :lpp do
    name { generate(:lpp_name) }
  end
end
