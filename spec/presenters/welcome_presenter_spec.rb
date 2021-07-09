#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe WelcomePresenter do
  subject { WelcomePresenter.new(view) }

  it_behaves_like "a presenter"
  
  it "help text should have welcome specific instruction" do
    expect(subject.help_text).to match(/<dl>/)
  end

  it "should have a title" do
    expect(subject.page_title).to match(/Welcome/)
  end

  it "should provide a way to create UI forms" do
    markup = Capybara.string(subject.welcome_form('name-thing', 'path/to/name/thing', 'theparam', 'thelabel'))
    form = markup.find('form')
    expect(form[:action]).to eq('path/to/name/thing')
    expect(form[:id]).to eq('name-thing-form')
    expect(form[:method]).to eq('post')
    label = form.find('label')
    expect(label[:class]).to eq('form-description')
    expect(label[:for]).to eq('theparam')
    expect(label.text).to eq('thelabel')
    input = form.find('input[id="theparam"]')
    expect(input[:name]).to eq('theparam')
    expect(input[:type]).to eq('text')
    submit = form.find('input[type="submit"]')
    expect(submit[:id]).to eq('name-thing-submit')
    expect(submit[:name]).to eq('commit')
    expect(submit[:value]).to eq('Submit')
  end
end
