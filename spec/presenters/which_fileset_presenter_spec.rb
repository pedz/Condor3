#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe WhichFilesetPresenter do
  let(:data) { {
      '/the/first/path' => [ 'fileset1', 'fileset2' ],
      '/the/second/path' => [ 'fileset3', 'fileset4' ]
    }
  }

  let(:which_fileset) {
    double('WhichFileset').tap do |d|
      allow(d).to receive(:path).and_return('msnentdd')
      allow(d).to receive(:paths).and_return(data)
    end
  }

  subject do
    WhichFilesetPresenter.new(view, which_fileset)
  end
  
  it_behaves_like "a presenter"

  it "should present the table" do
    markup = Capybara.string(subject.show_table)
    expect(markup).to have_selector("table.which_filesets thead")
    expect(markup).to have_selector("table.which_filesets tbody")
  end

  it "should present a div when no hits are returned" do
    allow(which_fileset).to receive(:paths).and_return({})
    s = subject.show_table
    markup = Capybara.string(s)
    expect(markup).to have_selector("div.which_filesets span")
  end
end
