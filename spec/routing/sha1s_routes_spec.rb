#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "sha1s routes" do
  it "a POST => /sha1s to sha1s#create" do
    expect(post: "/sha1s").to route_to("sha1s#create")
  end

  it "a GET => /sha1s/1234567890ABCDEF to sha1s#show" do
    expect(get: "/sha1s/1234567890ABCDEF").to route_to(controller: "sha1s",
                                                          action: "show",
                                                          sha1: '1234567890ABCDEF')
  end

  it "a GET => /sha1s/1234567890ABCDEF.json to sha1s#show with json format" do
    expect(get: "/sha1s/1234567890ABCDEF.json").to route_to(controller: "sha1s",
                                                               action: "show",
                                                               sha1: '1234567890ABCDEF',
                                                               format: 'json')
  end
end
