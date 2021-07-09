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
      allow(d).to receive(:upd_apar_defs).and_return(data)
      allow(d).to receive(:errors).and_return([])
      allow(d).to receive(:item).and_return("12345")
    end
  }

  subject do
    SwinfoPresenter.new(view, swinfo)
  end

  it_behaves_like "a presenter"

  it "should hide the errors list if there are no errors" do
    markup = Capybara.string(subject.show_errors)
    expect(markup).to have_selector("section[style='display: none;']", visible: false)
  end

  it "should list the errors" do
    allow(swinfo).to receive(:errors).and_return(%w{ error1 error2 })
    markup = Capybara.string(subject.show_errors)
    expect(markup).to_not have_selector("section[style='display: none;']")
    expect(markup).to have_selector("ul")
    expect(markup).to have_selector("li", text: 'error1')
  end

  it "should present the table" do
    p = subject.show_table
    markup = Capybara.string(p)
    expect(markup).to have_selector("table.upd_apar_defs thead")
    expect(markup).to have_selector("table.upd_apar_defs tbody")
  end

  it "should present the results" do
    markup = Capybara.string(subject.append_results)
    a = JSON.parse(markup.find('script', visible: false).text.sub(/^[^=]+=/, '').sub(/;$/, ''))
    swinfo.upd_apar_defs.each_index do |i|
      %w{ apar defect ptf }.each do |field|
        expect(a[i][field]).to eq(swinfo.upd_apar_defs[i][field])
      end
    end
  end

  it "should respond with JSON" do
    expect(subject.to_json).to eq(data.to_json)
  end
end
