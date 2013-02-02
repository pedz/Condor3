# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:family_name) { "aix" }

  factory :family do
    name { generate(:family_name) }
  end
end
