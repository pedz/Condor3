#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe CmvcDefectChangePresenter do
  let(:defect_name) { "123456" }

  let(:defect_error) { "A bad error message" }

  let(:get_cmvc_defect_changes) do
    double("GetCmvcDefectChanges").tap do |d|
      allow(d).to receive(:error).and_return(nil)
      allow(d).to receive(:defect_name).and_return(defect_name)
      allow(d).to receive(:changes) do
        [
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.1', 'path1', 'type1', 'ref1', '2.3.4.1', 'abstract1'),
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.2', 'path2', 'type1', 'ref1', '2.3.4.2', 'abstract1'),
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.3', 'path3', 'type1', 'ref1', '2.3.4.3', 'abstract1'),
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.4', 'path4', 'type1', 'ref1', '2.3.4.4', 'abstract1'),
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.5', 'path5', 'type1', 'ref1', '2.3.4.5', 'abstract1'),
         Change.new('rel2', 'dt1', 'def1', 'lev1', '1.2.4.1', 'path1', 'type1', 'ref1', '',        'abstract1'),
         Change.new('rel2', 'dt1', 'def1', 'lev1', '1.2.4.2', 'path2', 'type1', 'ref1', '2.3.4.2', 'abstract1'),
         Change.new('rel2', 'dt1', 'def1', 'lev1', '1.2.4.3', 'path3', 'type1', 'ref1', '2.3.4.3', 'abstract1'),
         Change.new('rel2', 'dt1', 'def1', 'lev1', '1.2.4.4', 'path4', 'type1', 'ref1', '2.3.4.4', 'abstract1'),
         Change.new('rel2', 'dt1', 'def1', 'lev1', '1.2.4.5', 'path5', 'type1', 'ref1', '2.3.4.5', 'abstract1')
        ]
      end
    end
  end

  subject do
    CmvcDefectChangePresenter.new(view, get_cmvc_defect_changes)
  end
  
  it_behaves_like "a presenter"

  it "should present the changes if no errors" do
    markup = Capybara.string(subject.show_changes)
    expect(markup).to have_selector("div.defect")
    expect(markup.find("div.defect")).to have_content('Initial Drop')
  end

  it "should present the error when there is one" do
    allow(get_cmvc_defect_changes).to receive(:error).and_return(defect_error)
    markup = Capybara.string(subject.show_changes)
    expect(markup.find("div.center_error_block")).to have_content(defect_error)
  end
end
