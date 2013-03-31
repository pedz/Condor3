#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "source files routes" do
  it "a GET => /src_files/REL/a/long/file/1.2.3.4 to src_files#show" do
    expect(get: "/src_files/REL/a/long/file/1.2.3.4").to route_to(controller: "src_files",
                                                                     action: "show",
                                                                     release: 'REL',
                                                                     path: 'a/long/file',
                                                                     version: '1.2.3.4')
  end

  it "a GET => /src_files/REL/a/long/file/1.2.3.4.json to src_files#show with json format" do
    expect(get: "/src_files/REL/a/long/file/1.2.3.4.json").to route_to(controller: "src_files",
                                                                          action: "show",
                                                                          release: 'REL',
                                                                          path: 'a/long/file',
                                                                          version: '1.2.3.4',
                                                                          format: 'json')
  end
end
