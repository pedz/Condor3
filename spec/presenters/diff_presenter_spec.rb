#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe DiffPresenter do
  let(:path) { "a/b/c" }

  let(:prev_version) { "1.2.3 "}
  
  let(:version) { "1.2.4 "}

  let(:release) { "foo45S"}

  let(:page_params) do
    {
      path: path,
      release: release,
      version: version
    }
  end
  
  let(:old_file_lines) do
    [
     "Line 1",
     "Line 2",
     "Line 3",
     "Line 4",
     "Line 5",
     "Line 6",
     "Line 7"
    ]
  end
  
  let(:new_file_lines) do
    [
     "Line 1",
     "Line 4",
     "Line 5",
     "Line 8",
     "Line 6",
     "Line 7 new"
    ]
  end
  
  let(:old_file) do
    OpenStruct.new(
                   path: path,
                   release: release,
                   version: prev_version,
                   lines: old_file_lines
                   )
  end

  let(:old_seq) do
    [
     ["match", nil, "Line 1"],
     ["discard_a", 1, "Line 2"],
     ["discard_a", 1, "Line 3"],
     ["match", nil, "Line 4"],
     ["match", nil, "Line 5"],
     ["discard_b", 2, nil],
     ["match", nil, "Line 6"],
     ["change", 3, "Line 7"]
    ]
  end

  let(:new_file) do
    OpenStruct.new(
                   path: path,
                   release: release,
                   version: version,
                   lines: new_file_lines
                   )
  end
  
  let(:new_seq) do
    [
     ["match", nil, "Line 1"],
     ["discard_a", 1, nil],
     ["match", nil, "Line 4"],
     ["match", nil, "Line 5"],
     ["discard_b", 2, "Line 8"],
     ["match", nil, "Line 6"],
     ["change", 3, "Line 7 new"]
    ]
  end

  let(:diff_count) { 3 }

  let(:get_diff) do
    double("GetDiff").tap do |d|
      d.stub(:error).and_return(nil)
      d.stub(:old_seq).and_return(old_seq)
      d.stub(:old_file).and_return(old_file)
      d.stub(:new_seq).and_return(new_seq)
      d.stub(:new_file).and_return(new_file)
      d.stub(:diff_count).and_return(diff_count)
      d.stub(:page_params).and_return(page_params)
    end
  end

  subject do
    DiffPresenter.new(view, get_diff)
  end

  it_behaves_like "a presenter"

  it "should present the controller section" do
    markup = Capybara.string(subject.show_controls)
    markup.should have_selector("button#prev-diff")
    markup.should have_selector("span#hunk-index")
    markup.should have_selector("span#hunk-count")
    markup.should have_selector("button#next-diff")
  end

  it "should present the file changes" do
    markup = Capybara.string(subject.show_changes)
    markup.find('div#top-title-table div#top-title').tap do |f|
      f.text.should match(release)
      f.text.should match(path)
      f.text.should match(prev_version)
    end
    markup.find('div#top').tap do |top|
      %w[ pre.code pre.match pre.discard-a pre.discard-b pre.change].each do |klass|
        top.should have_selector(klass)
      end
      (1 .. diff_count).each do |cnt|
        top.should have_selector("pre\#diff-top-#{cnt}")
      end
    end
    markup.find('div#bot-title-table div#bot-title').tap do |f|
      f.text.should match(release)
      f.text.should match(path)
      f.text.should match(version)
    end
    markup.find('div#bot').tap do |bot|
      %w[ pre.code pre.match pre.discard-a pre.discard-b pre.change].each do |klass|
        bot.should have_selector(klass)
      end
      (1 .. diff_count).each do |cnt|
        bot.should have_selector("pre\#diff-bot-#{cnt}")
      end
    end
  end
end


