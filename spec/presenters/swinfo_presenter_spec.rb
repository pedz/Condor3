require 'spec_helper'

describe SwinfoPresenter do
  let(:data) { FactoryGirl.build_list(:upd_apar_def, 10) }
  let(:swinfo) {
    temp = Swinfo.new(item: "12345", sort: "defect, apar, ptf", page: 1)
    temp.stub(:upd_apar_defs).and_return(data)
    temp
  }

  subject do
    SwinfoPresenter.new(view, swinfo)
  end

  it_behaves_like "a presenter"

  it "should hide the errors list if there are no errors" do
    puts subject.show_errors
    markup = Capybara.string(subject.show_errors)
    markup.should have_selector("section[style='display: none;']")
  end

  it "should list the errors" do
    swinfo.stub(:errors).and_return(%w{ error1 error2 })
    markup = Capybara.string(subject.show_errors)
    markup.should_not have_selector("section[style='display: none;']")
    markup.should have_selector("ul")
    markup.should have_selector("li", :text => 'error1')
  end

  it "should present the table" do
    markup = Capybara.string(subject.show_table)
    markup.should have_selector("table.upd_apar_defs thead")
    markup.should have_selector("table.upd_apar_defs tbody")
  end

  it "should present the results" do
    markup = Capybara.string(subject.append_results)
    a = JSON.parse(markup.find('script').text.sub(/^[^=]+=/, '').sub(/;$/, ''))
    swinfo.upd_apar_defs.each_index do |i|
      %w{ apar defect ptf }.each do |field|
        a[i][field].should == swinfo.upd_apar_defs[i][field]
      end
    end
  end

  it "should respond with JSON" do
    subject.to_json.should eq(data.to_json)
  end
end
