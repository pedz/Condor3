#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'src_files/show' do
  it "should show the source file" do
    presenter = double("presenter")
    allow(view).to receive(:presenter).and_return(presenter)
    expect(presenter).to receive(:show_file).once
      .and_return("<pre class='src-file'></pre>".html_safe)
    render
    expect(rendered).to have_css("pre.src-file")
  end
end
