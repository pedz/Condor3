# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:apar_name, 22222) {|n| "IV#{n}" }
  sequence(:abstract) { |n| "Random Apar Abstract #{n} Blah"}

  factory :apar do
    abstract FactoryGirl.generate(:abstract)
    name FactoryGirl.generate(:apar_name)
  end
end