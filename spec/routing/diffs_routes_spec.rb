#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "diffs routes" do
  let(:diff_route) { "/diffs/REL/a/long/file/1.2.3.4" }

  let(:diff_w_v_route) { diff_route + "/p5.6.7.8"}
  
  it "a GET => /diff/release/some/path/Version1 to diffs#show" do
    expect(get: diff_route).to route_to(DiffRouteHash)
  end

  it "a GET => /diff/release/some/path/Version1.json diffs#show with json format" do
    expect(get:  diff_route + ".json").to route_to(DiffRouteHash.merge(format: 'json'))
  end

  it "a GET => /diff/release/some/path/Version1/pVersion2 to diffs#show" do
    expect(get: diff_w_v_route).to route_to(DiffPrevVersionRouteHash)
  end

  it "a GET => /diff/release/some/path/Version1/pVersion2.json to diffs#show with json format" do
    expect(get: diff_w_v_route + ".json").to route_to(DiffPrevVersionRouteHash.merge(format: 'json'))
  end
end
