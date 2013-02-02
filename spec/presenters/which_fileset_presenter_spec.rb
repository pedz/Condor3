require 'spec_helper'

describe WhichFilesetPresenter do
  let(:data) { {
      '/the/first/path' => [ 'fileset1', 'fileset2' ],
      '/the/second/path' => [ 'fileset3', 'fileset4' ]
    }
  }

  let(:which_fileset) {
    double('WhichFileset').tap do |d|
      d.stub(:path).and_return('msnentdd')
      d.stub(:paths).and_return(data)
    end
  }

  subject do
    WhichFilesetPresenter.new(view, which_fileset)
  end
  
  it_behaves_like "a presenter"

  it "should present the table" do
    markup = Capybara.string(subject.show_table)
    markup.should have_selector("table.which_filesets thead")
    markup.should have_selector("table.which_filesets tbody")
  end

  it "should present a div when no hits are returned" do
    which_fileset.stub(:paths).and_return({})
    s = subject.show_table
    markup = Capybara.string(s)
    markup.should have_selector("div.which_filesets span")
  end
end
