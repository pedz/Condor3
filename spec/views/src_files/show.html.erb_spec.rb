#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe 'src_files/show' do
  it "should show the source file" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_file).once
      .and_return("<pre class='src-file'></pre>".html_safe)
    render
    rendered.should have_css("pre.src-file")
  end
end
