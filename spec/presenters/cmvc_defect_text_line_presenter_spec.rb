#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe CmvcDefectTextLinePresenter do
  let(:defect_name) { "123456" }

  let(:defect_text) { "Some defect text" }

  let(:defect_error) { "A bad error message" }

  let(:get_cmvc_defect_text_lines) do
    double("GetCmvcDefectTextLines").tap do |d|
      allow(d).to receive(:error).and_return(nil)
      allow(d).to receive(:type).and_return("Defect")
      allow(d).to receive(:defect_name).and_return(defect_name)
      allow(d).to receive(:lines).and_return(defect_text)
    end
  end

  subject do
    CmvcDefectTextLinePresenter.new(view, get_cmvc_defect_text_lines)
  end
  
  it_behaves_like "a presenter"

  it "should present the text if no errors" do
    markup = Capybara.string(subject.show_defect)
    expect(markup).to have_selector("pre.cmvc_defect")
    expect(markup.find("pre.cmvc_defect")).to have_content(defect_text)
  end

  it "should present the error when there is one" do
    allow(get_cmvc_defect_text_lines).to receive(:error).and_return(defect_error)
    markup = Capybara.string(subject.show_defect)
    expect(markup.find("div.center_error_block")).to have_content(defect_error)
  end
end
