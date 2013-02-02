#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe "layouts/application" do
  it "puts the header tags into the header" do
    presenter = double('presenter')
    # Title called twice
    presenter.should_receive(:page_title).and_return('The Title'.html_safe)
    presenter.should_receive(:header_tags).and_return('<span>Howdy</span>'.html_safe)
    presenter.should_receive(:help_button).and_return('<div>Very Helpful</div>'.html_safe)
    presenter.should_receive(:home_button).and_return('Home'.html_safe)
    presenter.should_receive(:title_heading).and_return('Title Heading'.html_safe)
    view.stub(:presenter).and_return(presenter)
    render
    rendered.should have_content('The Title')
    rendered.should have_content('Howdy')
    rendered.should have_content('Very Helpful')
    rendered.should have_content('Home')
    rendered.should have_content('Title Heading')
  end
end
