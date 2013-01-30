require "spec_helper"

describe "defects routes" do
  it "routes post of /defects to defects controller create method" do
    expect(:post => "/defects").to route_to("defects#create")
  end

  it "routes get of /defects with a defect to defects controller show method" do
    expect(:get => "/defects/123456").to route_to(:controller => "defects",
                                                  :action => "show",
                                                  :defect => '123456')
  end

  it "routes get of path with json format to defects controller show method" do
    expect(:get => "/defects/123456.json").to route_to(:controller => "defects",
                                                       :action => "show",
                                                       :defect => '123456',
                                                       :format => 'json')
  end
end
