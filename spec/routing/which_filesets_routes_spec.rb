#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "which filesets routes" do
  it "routes post of /which_filesets to which filesets controller create method" do
    expect(:post => "/which_filesets").to route_to("which_filesets#create")
  end

  it "routes get of path to which filesets controller show method" do
    expect(:get => "/which_filesets/a/long/path.foo").to route_to(:controller => "which_filesets",
                                                                  :action => "show",
                                                                  :path => 'a/long/path.foo')
  end

  it "routes get of path with json format to which filesets controller show method" do
    expect(:get => "/which_filesets/a/long/path.foo.json").to route_to(:controller => "which_filesets",
                                                                       :action => "show",
                                                                       :path => 'a/long/path.foo',
                                                                       :format => 'json')
  end

  it "routes get of path with html format to which filesets controller show method" do
    expect(:get => "/which_filesets/a/long/path.foo.html").to route_to(:controller => "which_filesets",
                                                                       :action => "show",
                                                                       :path => 'a/long/path.foo',
                                                                       :format => 'html')
  end
end
