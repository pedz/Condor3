#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe CmvcChangePresenter do
  let(:defect_name) { "123456" }

  let(:defect_error) { "A bad error message" }

  let(:get_cmvc_defect_changes) do
    double("GetCmvcDefectTextLines").tap do |d|
      d.stub(:error).and_return(nil)
      d.stub(:defect_name).and_return(defect_name)
      d.stub(:changes).and_return([Change.new('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j')])
    end
  end

  subject do
    CmvcChangePresenter.new(view, get_cmvc_defect_changes)
  end
  
  it_behaves_like "a presenter"

  it "should present the changes if no errors" do
    markup = Capybara.string(subject.show_changes)
    markup.should have_selector("ul.defect")
    markup.find("ul.defect").should have_content('c')
  end

  it "should present the error when there is one" do
    get_cmvc_defect_text_lines.stub(:error).and_return(defect_error)
    markup = Capybara.string(subject.show_changes)
    markup.should have_selector("div.error_block")
    markup.find("div.error_block").should have_content(defect_error)
  end
end
