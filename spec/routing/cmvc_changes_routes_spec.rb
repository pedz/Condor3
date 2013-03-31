#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "cmvc changes routes" do
  it "a POST => /cmvc_changes to cmvc_changes#create" do
    expect(post: "/cmvc_changes").to route_to("cmvc_changes#create")
  end

  it "a GET => /cmvc_changes with a cmvc_change to cmvc_changes#show" do
    expect(get: "/cmvc_changes/123456").to route_to(controller: "cmvc_changes",
                                                       action: "show",
                                                       cmvc_change: '123456')
  end

  it "a GET => /cmvc_changes/cmvc_change.json to cmvc_changes#show with json format" do
    expect(get: "/cmvc_changes/123456.json").to route_to(controller: "cmvc_changes",
                                                            action: "show",
                                                            cmvc_change: '123456',
                                                            format: 'json')
  end
end
