#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "swinfo routes" do
  it "a POST => /swinfos to swinfo#create" do
    expect(:post => "/swinfos").to route_to("swinfos#create")
  end

  it "a GET => /swinfos/Item swinfo#show" do
    expect(:get => "/swinfos/12345").to route_to(:controller => "swinfos",
                                                 :action => "show",
                                                 :item => '12345')
  end

  it "a GET of /swinfos/Item/SortList/Page to swinfo#show" do
    expect(:get => "/swinfos/12345/sort%20list/15").to route_to(:controller => "swinfos",
                                                                :action => "show",
                                                                :item => '12345',
                                                                :sort => 'sort list',
                                                                :page => '15')
  end

  it "a GET of /swinfos/Item/SortList/Page.json to swinfo#show with json format" do
    expect(:get => "/swinfos/12345/sort%20list/15.json").to route_to(:controller => "swinfos",
                                                                     :action => "show",
                                                                     :item => '12345',
                                                                     :sort => 'sort list',
                                                                     :page => '15',
                                                                     :format => 'json')
  end
end
