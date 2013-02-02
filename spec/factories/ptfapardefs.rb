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
