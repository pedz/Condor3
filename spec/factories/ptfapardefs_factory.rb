#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ptfapardef do
    abstract { generate(:abstract) }
    apar { generate(:apar_name) }
    defect { generate(:defect_name) }
    family { generate(:family_name) }
    lpp { generate(:lpp_name) }
    lpp_base { lpp.sub(/\..*/, '') }
    ptf { generate(:ptf_name) }
    service_pack { generate(:service_pack_name) }
    release { generate(:release_name) }
    version { release.sub(/.*(...)$/, "\1") }
    vrmf { generate(:vrmf_name) }
  end
end
