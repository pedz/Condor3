#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe "swinfos/show" do
  it "should show the errors, table, and results" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_errors).once.and_return("<ul id='errors'></ul>".html_safe)
    presenter.should_receive(:show_table).once.and_return("<table class='upd_apar_defs'></table>".html_safe)
    presenter.should_receive(:append_results).once.and_return("<script type='text/javascript'></script>".html_safe)
    render
    rendered.should have_css("ul#errors")
    rendered.should have_css("table.upd_apar_defs")
    rendered.should have_css("script[type='text/javascript']")
  end
end
