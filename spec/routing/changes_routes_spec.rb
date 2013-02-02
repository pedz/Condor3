#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "changes routes" do
  it "routes post of /changes to changes controller create method" do
    expect(:post => "/changes").to route_to("changes#create")
  end

  it "routes get of /changes with a change to changes controller show method" do
    expect(:get => "/changes/123456").to route_to(:controller => "changes",
                                                  :action => "show",
                                                  :change => '123456')
  end

  it "routes get of path with json format to changes controller show method" do
    expect(:get => "/changes/123456.json").to route_to(:controller => "changes",
                                                       :action => "show",
                                                       :change => '123456',
                                                       :format => 'json')
  end
end
