# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:service_pack_name) do |n|
    packs = [
             "6100-01-02",
             "6100-01-03",
             "6100-01-04",
             "6100-01-05",
             "6100-01-06",
             "6100-02-02",
             "6100-02-03",
             "6100-02-04",
             "6100-02-05",
             "6100-02-06"
            ]
    packs[n % packs.length]
  end
  
  factory :service_pack do
    name { generate(:service_pack_name) }
  end
end
