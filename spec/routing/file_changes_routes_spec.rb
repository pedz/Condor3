#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "file changes routes" do
  it "a POST => /file_changes to file_changes#create" do
    expect(post: "/file_changes").to route_to("file_changes#create")
  end

  it "a GET => /file_changes/a/long/file.foo to file_changes#show" do
    expect(get: "/file_changes/a/long/file.foo").to route_to(controller: "file_changes",
                                                                action: "show",
                                                                file: 'a/long/file.foo')
  end

  it "a GET => /file_changes/a/long/file.foo.json to file_changes#show with json format" do
    expect(get: "/file_changes/a/long/file.foo.json").to route_to(controller: "file_changes",
                                                                     action: "show",
                                                                     file: 'a/long/file.foo',
                                                                     format: 'json')
  end

  it "a GET => /file_changes/a/long/file.foo.html to file_changes#show with html format" do
    expect(get: "/file_changes/a/long/file.foo.html").to route_to(controller: "file_changes",
                                                                     action: "show",
                                                                     file: 'a/long/file.foo',
                                                                     format: 'html')
  end
end
