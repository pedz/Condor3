# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :apar_defect_version_map, aliases: [ :adv ] do
    ignore do
      dname nil
      aname nil
      vname nil
    end
    association :apar, strategy: :build
    association :defect, strategy: :build
    association :version, strategy: :build

    after(:build) do |apar_defect_version_map, evaluator|
      apar_defect_version_map.apar.name = evaluator.aname if evaluator.aname
      apar_defect_version_map.defect.name = evaluator.dname if evaluator.dname
      apar_defect_version_map.version.name = evaluator.vname if evaluator.vname
    end
  end
end
