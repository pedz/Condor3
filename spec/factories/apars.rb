# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :apar do
    sequence(:name, 22222) {|n| "IV#{n}" }
  end
end
