#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
shared_examples_for "a presenter" do
  it "should provide a page title" do
    expect(subject.page_title).to_not be_blank
  end

  it "should provide the help text" do
    expect(subject.help_text).to_not be_blank
  end
end
