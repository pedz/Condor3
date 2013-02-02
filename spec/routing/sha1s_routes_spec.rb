#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "sha1s routes" do
  it "routes post of /sha1s to sha1s controller create method" do
    expect(:post => "/sha1s").to route_to("sha1s#create")
  end

  it "routes get of /sha1s with a sha1 to sha1s controller show method" do
    expect(:get => "/sha1s/1234567890ABCDEF").to route_to(:controller => "sha1s",
                                                          :action => "show",
                                                          :sha1 => '1234567890ABCDEF')
  end

  it "routes get of path with json format to sha1s controller show method" do
    expect(:get => "/sha1s/1234567890ABCDEF.json").to route_to(:controller => "sha1s",
                                                               :action => "show",
                                                               :sha1 => '1234567890ABCDEF',
                                                               :format => 'json')
  end
end
