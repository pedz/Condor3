# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:ptf_name, 123456) { |n| "U#{n}" }

  factory :ptf do
    name { generate(:ptf_name) }
  end
end
