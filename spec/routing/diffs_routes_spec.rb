#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "diffs routes" do
  it "routes get of diff to diffs controller show method" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4").to route_to(:controller => "diffs",
                                                                 :action => "show",
                                                                 :release => 'REL',
                                                                 :path => 'a/long/file',
                                                                 :version => '1.2.3.4')
  end

  it "routes get of file with json format to source files controller show method" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4.json").to route_to(:controller => "diffs",
                                                                      :action => "show",
                                                                      :release => 'REL',
                                                                      :path => 'a/long/file',
                                                                      :version => '1.2.3.4',
                                                                      :format => 'json')
  end

  it "routes get of diff with previous version to diffs controller show method" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4/p5.6.7.8").to route_to(:controller => "diffs",
                                                                          :action => "show",
                                                                          :release => 'REL',
                                                                          :path => 'a/long/file',
                                                                          :version => '1.2.3.4',
                                                                          :prev_version => '5.6.7.8')
  end

  it "routes get of file with previous version and json format to source files controller show method" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4/p5.6.7.8.json").to route_to(:controller => "diffs",
                                                                               :action => "show",
                                                                               :release => 'REL',
                                                                               :path => 'a/long/file',
                                                                               :version => '1.2.3.4',
                                                                               :prev_version => '5.6.7.8',
                                                                               :format => 'json')
  end
end
