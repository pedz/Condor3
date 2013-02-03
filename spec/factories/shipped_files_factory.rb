#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipped_file do
    aix_file      { generate(:aix_file_path) }
    image_path    { generate(:image_path_path) }
    lpp           { generate(:lpp_name) }
    package       { generate(:package_name) }
    service_pack  { generate(:service_pack_name) }
    aix_file_sha1 { generate(:aix_file_sha1) }
    vrmf          { generate(:vrmf_name) }
  end
end
