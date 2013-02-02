#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "file changes routes" do
  it "routes post of /file_changes to file_changes controller create method" do
    expect(:post => "/file_changes").to route_to("file_changes#create")
  end

  it "routes get of file to file changes controller show method" do
    expect(:get => "/file_changes/a/long/file.foo").to route_to(:controller => "file_changes",
                                                                :action => "show",
                                                                :file => 'a/long/file.foo')
  end

  it "routes get of file with json format to file changes controller show method" do
    expect(:get => "/file_changes/a/long/file.foo.json").to route_to(:controller => "file_changes",
                                                                     :action => "show",
                                                                     :file => 'a/long/file.foo',
                                                                     :format => 'json')
  end

  it "routes get of file with html format to file changes controller show method" do
    expect(:get => "/file_changes/a/long/file.foo.html").to route_to(:controller => "file_changes",
                                                                     :action => "show",
                                                                     :file => 'a/long/file.foo',
                                                                     :format => 'html')
  end
end
