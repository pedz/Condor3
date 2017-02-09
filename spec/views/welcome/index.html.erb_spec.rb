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
    allow(presenter).to receive(:welcome_form) do |a, b, c, d|
      "#{a} #{c} '#{d}'".html_safe
    end
    expect(presenter).to receive(:welcome_form).exactly(6)
    allow(presenter).to receive(:vince)
    allow(view).to receive(:presenter).and_return(presenter)
    render
    expect(rendered).to have_content("swinfo item 'swinfo'")
    expect(rendered).to have_content("which-filesets path 'which fileset'")
    expect(rendered).to have_content("sha1s sha1 'sha1'")
    expect(rendered).to have_content("cmvc-defects cmvc_defect 'cmvc defect'")
    expect(rendered).to have_content("cmvc-changes cmvc_change 'cmvc defect changes'")
    expect(rendered).to have_content("file-changes file 'file change history'")
  end
end
