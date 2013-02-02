# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:build_name) do |n|
    names = [
             "v2010_06A0",
             "o2003_10A0",
             "s2009_38A0",
             "h2009_44A1",
             "f2010_09A0",
             "b2004_14A0",
             "x2011_31A0",
             "e2006_35A0",
             "q2011_50A0",
             "q2007_46A0"
            ]
    names[n % names.length]
  end
  
  factory :upd_apar_def do
    abstract     { generate(:abstract) }
    apar         { generate(:apar_name) }
    build_name   { generate(:build_name) }
    cq_defect    { generate(:cq_defect) }
    defect       { generate(:defect_name) }
    lpp          { generate(:lpp_name) }
    lpp_base     { lpp.sub(/\..*/, '') }
    ptf          { generate(:ptf_name) }
    service_pack { generate(:service_pack_name) }
    version      { generate(:release_name).sub(/.*(...)$/, "\1") }
    vrmf         { generate(:vrmf_name) }
  end
end
