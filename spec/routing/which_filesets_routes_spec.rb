#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "which filesets routes" do
  it "a POST => /which_filesets which_filesets#create" do
    expect(:post => "/which_filesets").to route_to("which_filesets#create")
  end

  it "a GET => /which_filesets/a/long/path.foo to which_filesets#show" do
    expect(:get => "/which_filesets/a/long/path.foo").to route_to(:controller => "which_filesets",
                                                                  :action => "show",
                                                                  :path => 'a/long/path.foo')
  end

  it "a GET => /which_filesets/a/long/path.foo.json to which_filesets#show with json format" do
    expect(:get => "/which_filesets/a/long/path.foo.json").to route_to(:controller => "which_filesets",
                                                                       :action => "show",
                                                                       :path => 'a/long/path.foo',
                                                                       :format => 'json')
  end

  it "a GET /which_filesets/a/long/path.foo.html to which_filesets#show with html format" do
    expect(:get => "/which_filesets/a/long/path.foo.html").to route_to(:controller => "which_filesets",
                                                                       :action => "show",
                                                                       :path => 'a/long/path.foo',
                                                                       :format => 'html')
  end
end
