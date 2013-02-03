#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe Sha1Presenter do
  let(:sha1_sample) { "1234567890123456789012345678901234567890" }

  let(:data) { FactoryGirl.build_list(:shipped_file, 10) }

  let(:sha1) {
    double("Sha1").tap do |d|
      d.stub(:sha1).and_return(sha1_sample)
      d.stub(:shipped_files).and_return(data)
    end
  }

  subject do
    Sha1Presenter.new(view, sha1)
  end

  it_behaves_like "a presenter"

  it "should present the table" do
    markup = Capybara.string(subject.show_table)
    markup.should have_selector("table.sha1s thead")
    markup.should have_selector("table.sha1s tbody")
  end

  it "should present a div when no hits are returned" do
    sha1.stub(:shipped_files).and_return({})
    s = subject.show_table
    markup = Capybara.string(s)
    markup.should have_selector("div.sha1s span")
  end
end
