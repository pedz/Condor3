#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require 'spec_helper'

describe ApplicationPresenter do
  subject { ApplicationPresenter.new(view) }

  it "should provide the header_tags" do
    markup = subject.header_tags
    markup.should =~ /favicon/
  end

  it "should provide a home button" do
    markup = subject.home_button
    markup.should =~ /Home/
  end
  
  it "should create a help buttong yielding to block" do
    subject.should_receive(:help_text).and_return("<div>Wow</div>".html_safe)
    markup = subject.help_button
    markup =~ /Wow/
  end

  it "should provide a title heading which calls `page_title' in child class" do
    subject.should_receive(:page_title).and_return('child title')
    markup = subject.title_heading
    markup.should =~ /child title/
  end
end
