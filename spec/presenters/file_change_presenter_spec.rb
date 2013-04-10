#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
require "spec_helper"

describe FileChangePresenter do
  let(:file_name) { "banana.c" }

  let(:file_error) { "A bad error message" }

  let(:get_file_changes) do
    double("GetFileChanges").tap do |d|
      d.stub(:error).and_return(nil)
      d.stub(:file_name).and_return(file_name)
      d.stub(:changes) do
        [
         Change.new('rel1', 'dt1', 'def1', 'lev1', '1.2.3.1', 'path1', 'type1', 'ref1', '2.3.4.1', 'abstract1'),
         Change.new('rel1', 'dt1', 'def2', 'lev1', '1.2.3.2', 'path1', 'type1', 'ref1', '2.3.4.2', 'abstract2'),
         Change.new('rel1', 'dt1', 'def3', 'lev1', '1.2.3.3', 'path1', 'type1', 'ref1', '2.3.4.3', 'abstract3'),
         Change.new('rel2', 'dt1', 'def4', 'lev1', '1.2.3.4', 'path1', 'type1', 'ref1', '2.3.4.4', 'abstract4'),
         Change.new('rel2', 'dt1', 'def5', 'lev1', '1.2.3.5', 'path1', 'type1', 'ref1', '2.3.4.5', 'abstract5'),
         Change.new('rel2', 'dt1', 'def6', 'lev1', '1.2.4.1', 'path2', 'type1', 'ref1', '',        'abstract6'),
         Change.new('rel2', 'dt1', 'def7', 'lev1', '1.2.4.2', 'path2', 'type1', 'ref1', '2.3.4.2', 'abstract7'),
         Change.new('rel3', 'dt1', 'def8', 'lev1', '1.2.4.3', 'path2', 'type1', 'ref1', '2.3.4.3', 'abstract8'),
         Change.new('rel3', 'dt1', 'def9', 'lev1', '1.2.4.4', 'path2', 'type1', 'ref1', '2.3.4.4', 'abstract9'),
         Change.new('rel3', 'dt1', 'defA', 'lev1', '1.2.4.5', 'path2', 'type1', 'ref1', '2.3.4.5', 'abstractA')
        ]
      end
    end
  end

  subject do
    FileChangePresenter.new(view, get_file_changes)
  end
  
  it_behaves_like "a presenter"

  it "should present the changes if no errors" do
    markup = Capybara.string(subject.show_changes)
    markup.should have_selector("div.changes")
    markup.find("div.changes").should have_content('path1')
    markup.find("div.changes").should have_content('Initial Drop')
    markup.find("div.changes").should have_content('path2')
  end

  it "should present the error when there is one" do
    get_file_changes.stub(:error).and_return(file_error)
    markup = Capybara.string(subject.show_changes)
    markup.find("div.center_error_block").should have_content(file_error)
  end
end
