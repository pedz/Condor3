require 'spec_helper'

describe WelcomePresenter do
  subject { WelcomePresenter.new(view) }

  it_behaves_like "a presenter"
  
  it "help text should have welcome specific instruction" do
    subject.help_text =~ /<dl>/
  end

  it "should have a title" do
    subject.page_title =~ /Welcome/
  end

  it "should provide a way to create UI forms" do
    markup = subject.welcome_form('name-thing', 'path/to/name/thing', 'theparam', 'thelabel')

  end

#   describe "the swinfo form" do
#     before(:each) do
#       render
#     end

#     def form
#       @form ||= rendered.find('form#swinfo_form')
#     end

#     def label
#       @label ||= form.find('label')
#     end

#     def text_box
#       @text_box ||= form.find('input[type="text"]')
#     end

#     it "should exist" do
#       form
#     end

#     it "should have an action of /swinfos" do
#       form[:action].should == '/swinfos'
#     end

#     it "shoule have a method of post" do
#       form[:method].should == 'post'
#     end

#     it "should have a label" do
#       label
#     end

#     describe "the label" do
#       it "should have text of 'swinfo'" do
#         label.text.should == 'swinfo'
#       end

#       it "should be for 'item'" do
#         label[:for].should == 'item'
#       end
#     end

#     it 'should have a text field' do
#       text_box
#     end

#     describe "the text field" do
#       it "should have a name of 'item'" do
#         text_box[:name].should == 'item'
#       end
#     end
#   end

#   it "the 'which filesets' form" do
#     render
#     within 'form#which_filesets_form' do |form|
#       form[:action].should == '/which_filesets'
#       form.should have_selector('input[type="submit"]')

#       form.find('label').tap do |label|
#         label.text.should == 'which fileset'
#         label[:for].should == 'path'
#       end

#       form.find('input[type="text"]').tap do |text_box|
#         text_box[:name].should == 'path'
#       end
#     end
#   end

#   it "the 'sha1' form" do
#     render
#     within 'form#sha1s_form' do |form|
#       form[:action].should == '/sha1s'
#       form.should have_selector('input[type="submit"]')

#       form.find('label').tap do |label|
#         label.text.should == 'sha1'
#         label[:for].should == 'sha1'
#       end

#       form.find('input[type="text"]').tap do |text_box|
#         text_box[:name].should == 'sha1'
#       end
#     end
#   end

#   it "the 'cmvc defect' form" do
#     render
#     within 'form#defects_form' do |form|
#       form[:action].should == '/defects'
#       form.should have_selector('input[type="submit"]')

#       form.find('label').tap do |label|
#         label.text.should == 'cmvc defect'
#         label[:for].should == 'defect'
#       end

#       form.find('input[type="text"]').tap do |text_box|
#         text_box[:name].should == 'defect'
#       end
#     end
#   end

#   it "the 'changes' form" do
#     render
#     within 'form#changes_form' do |form|
#       form[:action].should == '/changes'
#       form.should have_selector('input[type="submit"]')

#       form.find('label').tap do |label|
#         label.text.should == 'cmvc defect changes'
#         label[:for].should == 'change'
#       end

#       form.find('input[type="text"]').tap do |text_box|
#         text_box[:name].should == 'change'
#       end
#     end
#   end

  # it "the 'file changes' form" do
  #   render
  #   within 'form#file_changes_form' do |form|
  #     form[:action].should == '/file_changes'
  #     form.should have_selector('input[type="submit"]')
      
  #     form.find('label').tap do |label|
  #       label.text.should == 'file change history'
  #       label[:for].should == 'file'
  #     end

  #     form.find('input[type="text"]').tap do |text_box|
  #       text_box[:name].should == 'file'
  #     end
  #   end
  # end
end
