#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe "welcome/index.html.erb" do
  it "should call welcome form for each of the forms we want" do
    presenter = double('presenter')
    # The 2nd argument is the path.  We don't want to test what it is.
    # The fact that the view can make the call says that the path is
    # valid.
    presenter.stub(:welcome_form) do |a, b, c, d|
      "#{a} #{c} '#{d}'".html_safe
    end
    presenter.should_receive(:welcome_form).exactly(6)
    view.stub(:presenter).and_return(presenter)
    render
    rendered.should have_content("swinfo item 'swinfo'")
    rendered.should have_content("which-filesets path 'which fileset'")
    rendered.should have_content("sha1s sha1 'sha1'")
    rendered.should have_content("defects defect 'cmvc defect'")
    rendered.should have_content("changes change 'cmvc defect changes'")
    rendered.should have_content("file-changes file 'file change history'")
  end
end
