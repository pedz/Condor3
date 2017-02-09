#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'cmvc_defects/show' do
  it "should show the defect" do
    presenter = double("presenter")
    allow(view).to receive(:presenter).and_return(presenter)
    expect(presenter).to receive(:show_defect).once
      .and_return("<pre class='cmvc-defects'></pre>".html_safe)
    render
    expect(rendered).to have_css("pre.cmvc-defects")
  end
end
