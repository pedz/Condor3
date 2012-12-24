# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ptfapardef do
    abstract { FactoryGirl.generate(:abstract) }
    apar { FactoryGirl.generate(:apar_name) }
    defect { FactoryGirl.generate(:defect_name) }
    family { FactoryGirl.generate(:family_name) }
    lpp { FactoryGirl.generate(:lpp_name) }
    lpp_base { lpp.sub(/\..*/, '') }
    ptf { FactoryGirl.generate(:ptf_name) }
    service_pack { FactoryGirl.generate(:service_pack_name) }
    release { FactoryGirl.generate(:release_name) }
    version { release.sub(/.*(...)$/, "\1") }
    vrmf { FactoryGirl.generate(:vrmf_name) }
  end
end
