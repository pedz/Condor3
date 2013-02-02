#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

Given /^I am on the welcome page$/ do
  # Note that currently when in the test environment, any username and
  # password will work but one needs to be supplied.  I'm assuming at
  # some point, I may have different types of users.
  case page.mode.to_s
  when 'selenium'
    visit("http://username:password@localhost#{welcome_path}")

  when 'rack_test'
    encoded_login = ["username:password"].pack("m*")
    page.driver.header 'Authorization', "Basic #{encoded_login}"
    visit(welcome_path)

  when 'webkit'
    page.driver.browser.authenticate('username', 'password')
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
