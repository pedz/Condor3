#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'sha1s/show' do
  it "should show the table and results" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_table).once
      .and_return("<table class='sha1s'></table>".html_safe)
    render
    rendered.should have_css("table.sha1s")
  end
end
