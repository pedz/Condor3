#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "cmvc defects routes" do
  it "a POST => /cmvc_defects to cmvc_defects#create" do
    expect(:post => "/cmvc_defects").to route_to("cmvc_defects#create")
  end

  it "a GET => /cmvc_defects/:cmvc_defect to cmvc_defects#show" do
    expect(:get => "/cmvc_defects/123456").to route_to(:controller => "cmvc_defects",
                                                       :action => "show",
                                                       :cmvc_defect => '123456')
  end

  it "a GET => /cmvc_defects/:cmvc_defect.json to cmvc_defects#show with json format" do
    expect(:get => "/cmvc_defects/123456.json").to route_to(:controller => "cmvc_defects",
                                                            :action => "show",
                                                            :cmvc_defect => '123456',
                                                            :format => 'json')
  end
end
