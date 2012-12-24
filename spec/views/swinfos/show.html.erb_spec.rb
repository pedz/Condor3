require "spec_helper"

describe "swinfos/show" do
  it "should show the errors, table, and results" do
    presenter = double("presenter")
    view.stub(:presenter).and_return(presenter)
    presenter.should_receive(:show_errors).once.and_return("<ul id='errors'></ul>")
    presenter.should_receive(:show_table).once.and_return("<table class='upd_apar_defs'></table>")
    presenter.should_receive(:append_results).once.and_return("<script type='text/javascript'></script>")
    render
    rendered.has_css?("ul#errors")
    rendered.has_css?("table.upd_apar_defs")
    rendered.has_css?("script[type='text/javascript']")
  end
end
