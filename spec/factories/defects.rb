#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:defect_name, 345678) { |n| n.to_s }
  sequence(:cq_defect, 12345) {|n| "SW0#{n}" }

  factory :defect do
    name { generate(:defect_name) }
    cq_defect { generate(:cq_defect) }
  end
end
