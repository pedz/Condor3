#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "swinfo routes" do
  it "routes post of /swinfos to swinfo controller create method" do
    expect(:post => "/swinfos").to route_to("swinfos#create")
  end

  it "routes get of item to swinfo controller show method" do
    expect(:get => "/swinfos/12345").to route_to(:controller => "swinfos",
                                                 :action => "show",
                                                 :item => '12345')
  end

  it "routes get of item, sort, and page to swinfo controller show method" do
    expect(:get => "/swinfos/12345/sort%20list/15").to route_to(:controller => "swinfos",
                                                                :action => "show",
                                                                :item => '12345',
                                                                :sort => 'sort list',
                                                                :page => '15')
  end

  it "routes get of item, sort, and page with json format to swinfo controller show method" do
    expect(:get => "/swinfos/12345/sort%20list/15.json").to route_to(:controller => "swinfos",
                                                                     :action => "show",
                                                                     :item => '12345',
                                                                     :sort => 'sort list',
                                                                     :page => '15',
                                                                     :format => 'json')
  end
end
