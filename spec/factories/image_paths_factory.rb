#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:image_path_path) do |n|
    paths = [
             "aix53X/5300-12-01_SP/inst.images/.toc",
             "aix53X/5300-12-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd1_server",
             "aix53X/5300-12-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd2_server",
             "aix53X/5300-12-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd3_server",
             "VIOS_61S_FP25_SP3.1_Only/.data/FP25SP3.1.fs",
             "VIOS_61S_FP25_SP3.1_Only/.data/FP25SP3.1.fs-",
             "VIOS_61S_FP25_SP3.1_Only/.data/FP25SP3.1.fsb",
             "VIOS_61S_FP25_SP3.1_Only/.data/FP25SP3.1.fsb-",
             "aix71D/7100-01-01_SP/inst.images/.toc",
             "aix71D/7100-01-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd1_server",
             "aix71D/7100-01-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd2_server",
             "aix71D/7100-01-01_SP/inst.images/MASTER_STACK/stack.OEMaix_cd3_server"
            ]
    paths[n % paths.length]
  end

  factory :image_path do
    path { generate(:image_path_path) }
  end
end
