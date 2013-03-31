#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'diffs/show' do
  it "should show the changes in the file" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_controls).once
      .and_return("<div class='controls'></pre>".html_safe)
    presenter.should_receive(:show_changes).once
      .and_return("<div class='changes'></pre>".html_safe)
    render
    rendered.should have_css("div.controls")
    rendered.should have_css("div.changes")
  end
end
