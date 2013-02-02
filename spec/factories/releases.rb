# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:release_name) do |n|
    releases = [
                "bos610",
                "bos61A",
                "bos61F",
                "bos61Q",
                "bos61X",
                "bos710",
                "bos71A",
                "bos71F",
                "bos71Q",
                "bos71X"
               ]
    releases[n % releases.length]
  end

  factory :release do
    name { generate(:release_name) }
  end
end
