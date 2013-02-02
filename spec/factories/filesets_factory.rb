#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:vrmf_name) do |n|
    vrmfs = [
             "6.1.0.1",
             "6.1.0.2",
             "6.1.0.3",
             "6.1.1.1",
             "6.1.1.1",
             "7.1.0.1",
             "7.1.0.2",
             "7.1.0.3",
             "7.1.1.1",
             "7.1.1.1"
            ]
    vrmfs[n % vrmfs.length]
  end

  factory :fileset do
    association :lpp, strategy: :build
    vrmf { generate(:vrmf_name) }
  end
end
