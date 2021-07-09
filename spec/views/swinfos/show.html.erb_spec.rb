#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "swinfos/show" do
  it "should show the errors, table, and results" do
    presenter = double("presenter")
    allow(view).to receive(:presenter).and_return(presenter)
    expect(presenter).to receive(:show_errors).once.and_return("<ul id='errors'></ul>".html_safe)
    expect(presenter).to receive(:show_table).once.and_return("<table class='upd_apar_defs'></table>".html_safe)
    expect(presenter).to receive(:append_results).once.and_return("<script type='text/javascript'></script>".html_safe)
    render
    expect(rendered).to have_css("ul#errors")
    expect(rendered).to have_css("table.upd_apar_defs")
    expect(rendered).to have_css("script[type='text/javascript']", visible: false)
  end
end
