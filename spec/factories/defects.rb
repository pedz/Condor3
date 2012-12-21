# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :defect do
    sequence(:name, 345678)
    sequence(:cq_defect, 12345) {|n| "SW0#{n}" }
  end
end
