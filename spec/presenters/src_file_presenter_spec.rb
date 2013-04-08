#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe SrcFilePresenter do
  let(:path) { "a/b/c" }

  let(:version) { "1.2 "}

  let(:release) { "foo45S"}

  let(:file_text) { "Some file text" }

  let(:fetch_error) { "A bad error message" }

  let(:get_src_file) do
    double("GetSrcFile").tap do |d|
      d.stub(:error).and_return(nil)
      d.stub(:path).and_return(path)
      d.stub(:version).and_return(version)
      d.stub(:release).and_return(release)
      d.stub(:lines).and_return(file_text)
    end
  end

  subject do
    SrcFilePresenter.new(view, get_src_file)
  end
  
  it_behaves_like "a presenter"

  it "should present the text if no errors" do
    markup = Capybara.string(subject.show_file)
    markup.should have_selector("pre.src_file")
    markup.find("pre.src_file").should have_content(file_text)
  end

  it "should present the error when there is one" do
    get_src_file.stub(:error).and_return(fetch_error)
    markup = Capybara.string(subject.show_file)
    markup.find("div.center_error_block").should have_content(fetch_error)
  end
end
