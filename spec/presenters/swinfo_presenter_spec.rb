#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe SwinfoPresenter do
  # We really don't need this complex of data right here but it seems
  # to not spend much time so lets keep it.
  let(:data) { FactoryGirl.build_list(:upd_apar_def, 10) }

  let(:swinfo) {
    double('Swinfo').tap do |d|
      d.stub(:upd_apar_defs).and_return(data)
      d.stub(:errors).and_return([])
      d.stub(:item).and_return("12345")
    end
  }

  subject do
    SwinfoPresenter.new(view, swinfo)
  end

  it_behaves_like "a presenter"

  it "should hide the errors list if there are no errors" do
    markup = Capybara.string(subject.show_errors)
    markup.should have_selector("section[style='display: none;']")
  end

  it "should list the errors" do
    swinfo.stub(:errors).and_return(%w{ error1 error2 })
    markup = Capybara.string(subject.show_errors)
    markup.should_not have_selector("section[style='display: none;']")
    markup.should have_selector("ul")
    markup.should have_selector("li", :text => 'error1')
  end

  it "should present the table" do
    p = subject.show_table
    markup = Capybara.string(p)
    markup.should have_selector("table.upd_apar_defs thead")
    markup.should have_selector("table.upd_apar_defs tbody")
  end

  it "should present the results" do
    markup = Capybara.string(subject.append_results)
    a = JSON.parse(markup.find('script').text.sub(/^[^=]+=/, '').sub(/;$/, ''))
    swinfo.upd_apar_defs.each_index do |i|
      %w{ apar defect ptf }.each do |field|
        a[i][field].should == swinfo.upd_apar_defs[i][field]
      end
    end
  end

  it "should respond with JSON" do
    subject.to_json.should eq(data.to_json)
  end
end
