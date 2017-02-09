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
    expect(markup).to match(/favicon/)
  end

  it "should provide a home button" do
    markup = subject.home_button
    expect(markup).to match(/Home/)
  end
  
  it "should create a help buttong yielding to block" do
    expect(subject).to receive(:help_text).and_return("<div>Wow</div>".html_safe)
    markup = subject.help_button
    markup =~ /Wow/
  end

  it "should provide a title heading which calls `page_title' in child class" do
    expect(subject).to receive(:page_title).and_return('child title')
    markup = subject.title_heading
    expect(markup).to match(/child title/)
  end

  describe "block_error" do
    it "should return back a div" do
      ret = Capybara.string(subject.send(:error_block, "some error"))
      expect(ret).to have_selector('div.center_error_block', text: "some error")
    end
    
    it "should modify the login error" do
      err = "0010-057 Login condor on host raptor.austin.ibm.com is not authorized to
        access the CMVC server software as user vjlayton.  A host
        list member must be created for the CMVC user
        before the login on the specified host can access
        the CMVC server software.  "
      ret = Capybara.string(subject.send(:error_block, err))
      expect(ret).to have_selector('div.error_block', text: "0010-057")
    end
  end
end
