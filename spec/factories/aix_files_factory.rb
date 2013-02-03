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
    aix_file_paths[n % aix_file_paths.length]
  }

  sequence(:aix_file_sha1) do |n|
    sha1s = [
             "94d682247313d41febb3e01139c1294d5f612f3e",
             "c9bf44783ca5f508b6d68eae38f0c96c96e92894",
             "1689797b4d812c99e0939a4bb9325e88a15aa329",
             "3ac6558f50a301f329f05d2852b8ea999918d8dd",
             "7a4878c29633a253e2c882cd686c443f2d71b7ff",
             "e51ab375f21a2af556802d3ac6968407e1e44389",
             "69991d6353af5b591acb0e67f41df47061e1a49d",
             "926687b247623e2d885f34e42da023bacb14defb",
             "4cc2c2af9f97e016d55e0a8bb218f1e479226198",
             "e8cc4e6a6e0abad241f95e9b4d3a0208dc5c26d0",
            ]
    sha1s[n % sha1s.length]
  end

  factory :aix_file do
    # id { generate(:aix_file_id) }
    # path { generate(:aix_file_path) }
    # association :fileset_aix_file_maps, strategy: :build
  end
end
