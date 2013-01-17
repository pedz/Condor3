require 'spec_helper'

describe "welcome/index.html.erb" do
  it "should call welcome form for each of the forms we want" do
    presenter = double('presenter')
    presenter.stub(:welcome_form) do |a, b, c|
      "#{a} #{b} #{c}".html_safe
    end
    presenter.should_receive(:welcome_form).exactly(6)
    view.stub(:presenter).and_return(presenter)
    render
    rendered.should have_content('swinfo item swinfo')
    rendered.should have_content('which_filesets path which fileset')
    rendered.should have_content('sha1s sha1 sha1')
    rendered.should have_content('defects defect cmvc defect')
    rendered.should have_content('changes change cmvc defect changes')
    rendered.should have_content('file_changes file file change history')
  end
end
