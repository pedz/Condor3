#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'file_changes/show' do
  it "should show the defect" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_changes).once
      .and_return("<div class='file-changes'></pre>".html_safe)
    render
    rendered.should have_css("div.file-changes")
  end
end
