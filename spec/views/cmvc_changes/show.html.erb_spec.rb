#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'cmvc_changes/show' do
  it "should show the defect" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_changes).once
      .and_return("<pre class='cmvc-defects'></pre>".html_safe)
    render
    rendered.should have_css("pre.cmvc-defects")
  end
end
