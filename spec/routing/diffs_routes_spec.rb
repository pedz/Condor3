#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "diffs routes" do
  it "a GET => /diff/release/some/path/Version1 to diffs#show" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4").to route_to(:controller => "diffs",
                                                                 :action => "show",
                                                                 :release => 'REL',
                                                                 :path => 'a/long/file',
                                                                 :version => '1.2.3.4')
  end

  it "a GET => /diff/release/some/path/Version1.json diffs#show with json format" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4.json").to route_to(:controller => "diffs",
                                                                      :action => "show",
                                                                      :release => 'REL',
                                                                      :path => 'a/long/file',
                                                                      :version => '1.2.3.4',
                                                                      :format => 'json')
  end

  it "a GET => /diff/release/some/path/Version1/pVersion2 to diffs#show" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4/p5.6.7.8").to route_to(:controller => "diffs",
                                                                          :action => "show",
                                                                          :release => 'REL',
                                                                          :path => 'a/long/file',
                                                                          :version => '1.2.3.4',
                                                                          :prev_version => '5.6.7.8')
  end

  it "a GET => /diff/release/some/path/Version1/pVersion2.json to diffs#show with json format" do
    expect(:get => "/diffs/REL/a/long/file/1.2.3.4/p5.6.7.8.json").to route_to(:controller => "diffs",
                                                                               :action => "show",
                                                                               :release => 'REL',
                                                                               :path => 'a/long/file',
                                                                               :version => '1.2.3.4',
                                                                               :prev_version => '5.6.7.8',
                                                                               :format => 'json')
  end
end
