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
      allow(d).to receive(:error).and_return(nil)
      allow(d).to receive(:path).and_return(path)
      allow(d).to receive(:version).and_return(version)
      allow(d).to receive(:release).and_return(release)
      allow(d).to receive(:lines).and_return(file_text)
    end
  end

  subject do
    SrcFilePresenter.new(view, get_src_file)
  end
  
  it_behaves_like "a presenter"

  it "should present the text if no errors" do
    markup = Capybara.string(subject.show_file)
    expect(markup).to have_selector("pre.src_file")
    expect(markup.find("pre.src_file")).to have_content(file_text)
  end

  it "should present the error when there is one" do
    allow(get_src_file).to receive(:error).and_return(fetch_error)
    markup = Capybara.string(subject.show_file)
    expect(markup.find("div.center_error_block")).to have_content(fetch_error)
  end
end
