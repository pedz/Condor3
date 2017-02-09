#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe "layouts/application" do
  it "adds the header tags into the header" do
    presenter = double('presenter')
    # Title called twice
    expect(presenter).to receive(:page_title).and_return('The Title'.html_safe)
    expect(presenter).to receive(:header_tags).and_return('<span>Howdy</span>'.html_safe)
    expect(presenter).to receive(:help_button).and_return('<div>Very Helpful</div>'.html_safe)
    expect(presenter).to receive(:home_button).and_return('Home'.html_safe)
    expect(presenter).to receive(:title_heading).and_return('Title Heading'.html_safe)
    allow(view).to receive(:presenter).and_return(presenter)
    render
    expect(rendered).to have_content('The Title')
    expect(rendered).to have_content('Howdy')
    expect(rendered).to have_content('Very Helpful')
    expect(rendered).to have_content('Home')
    expect(rendered).to have_content('Title Heading')
  end
end
