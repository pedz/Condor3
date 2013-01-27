require 'spec_helper'

describe WelcomePresenter do
  subject { WelcomePresenter.new(view) }

  it_behaves_like "a presenter"
  
  it "help text should have welcome specific instruction" do
    subject.help_text.should match(/<dl>/)
  end

  it "should have a title" do
    subject.page_title.should match(/Welcome/)
  end

  it "should provide a way to create UI forms" do
    markup = Capybara.string(subject.welcome_form('name-thing', 'path/to/name/thing', 'theparam', 'thelabel'))
    form = markup.find('form')
    form[:action].should eq('path/to/name/thing')
    form[:id].should eq('name-thing-form')
    form[:method].should eq('post')
    label = form.find('label')
    label[:class].should eq('form-description')
    label[:for].should eq('theparam')
    label.text.should eq('thelabel')
    input = form.find('input[id="theparam"]')
    input[:name].should eq('theparam')
    input[:type].should eq('text')
    submit = form.find('input[type="submit"]')
    submit[:id].should eq('name-thing-submit')
    submit[:name].should eq('commit')
    submit[:value].should eq('Submit')
  end
end
