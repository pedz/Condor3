
Given /^I am on the welcome page$/ do
  encoded_login = ["pedzan@us.ibm.com:lostgr8t"].pack("m*")
  page.driver.header 'Authorization', "Basic #{encoded_login}"
  visit(welcome_path)
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
