#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:aix_file_id) { |n| n }

  sequence(:aix_file_path) { |n|
    aix_file_paths = [
                      "/the/path/to/file/a",
                      "/another/path/to/file/b",
                      "/third/path/to/file",
                      "/blah/blah/blah"
                     ]
    puts "aix_file_paths n = #{n}"
    aix_file_paths[n % aix_file_paths.length]
  }

  factory :aix_file do
    # id { generate(:aix_file_id) }
    # path { generate(:aix_file_path) }
    # association :fileset_aix_file_maps, strategy: :build
  end
end
