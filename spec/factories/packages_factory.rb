#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:package_name) do |n|
    names = [
             "devices.common.IBM.iscsi",
             "devices.common.IBM.fc",
             "devices.common.IBM.fc",
             "devices.chrp.vdevice",
             "devices.chrp.pci",
             "bos.wpars",
             "bos.sysmgt",
             "bos.sysmgt",
             "bos.svpkg",
             "bos",
            ]
    names[n % names.length]
  end
  
  factory :package do
  end
end
