#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'diffs/show' do
  it "should show the changes in the file" do
    presenter = double("presenter")
    allow(view).to receive(:presenter).and_return(presenter)
    expect(presenter).to receive(:show_controls).once
      .and_return("<div class='controls'></pre>".html_safe)
    expect(presenter).to receive(:show_changes).once
      .and_return("<div class='changes'></pre>".html_safe)
    render
    expect(rendered).to have_css("div.controls")
    expect(rendered).to have_css("div.changes")
  end
end
