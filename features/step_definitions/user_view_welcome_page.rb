#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

Given /^I am on the welcome page$/ do
  case page.mode
  when :selenium
    visit("http://pedzan%40us.ibm.com:g0lf4you@localhost#{welcome_path}")

  when :rack_test
    encoded_login = ["pedzan@us.ibm.com:g0lf4you"].pack("m*")
    page.driver.header 'Authorization', "Basic #{encoded_login}"
    visit(welcome_path)

  when :webkit
    page.driver.browser.authenticate('pedzan@us.ibm.com', 'g0lf4you')
    visit(welcome_path)
  end
end

Then /^I should see multiple forms$/ do
  all('form').should have_at_least(2).forms
end

Then /^I see the (.*) form$/ do |form_name|
  @form = find_by_id(form_name)
end

And /^The form has (.*) to guide me to the correct text box$/ do |visual_text|
  @label = @form.find_field(visual_text)
end

And /^The text box is called (.*)$/ do |text_box_name|
  @text_box = @form.find_by_id(text_box_name)
end

And /^The form has a submit button$/ do
  @form.find('input[type=submit]')
end
