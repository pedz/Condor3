require 'spec_helper'

describe "welcome/index.html.erb" do
  it "should call welcome form for each of the forms we want" do
    presenter = double('presenter')
    presenter.should_receive(:welcome_form).exactly(6).and_return(->(a, b, c) { "#{a} #{b} #{c}" })
    view.stub(:presenter).and_return(presenter)
    render
    rendered.has_content?('swinfo item swinfo')
    rendered.has_content?('which_filesets path which fileset')
    rendered.has_content?('sha1s sha1 sha1')
    rendered.has_content?('defects defect cmvc defect')
    rendered.has_content?('changes change cmvc defect changes')
    rendered.has_content?('file_changes file file change history')
  end
end
