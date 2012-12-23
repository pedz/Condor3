require 'spec_helper'

describe "layouts/application" do
  it "puts the header tags into the header" do
    presenter = double('presenter')
    # Title called twice
    presenter.should_receive(:page_title).and_return('The Title')
    presenter.should_receive(:header_tags).and_return('<span>Howdy</span>')
    presenter.should_receive(:help_button).and_return('<div>Very Helpful</div>')
    presenter.should_receive(:home_button).and_return('Home')
    presenter.should_receive(:title_heading).and_return('Title Heading')
    view.stub(:presenter).and_return(presenter)
    render
    rendered.has_content?('The Title')
    rendered.has_content?('Howdy')
    rendered.has_content?('Very Helpful')
    rendered.has_content?('Home')
    rendered.has_content?('Title Heading')
  end
end
