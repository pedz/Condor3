
Given /^I am on the welcome page$/ do
  encoded_login = ["pedzan@us.ibm.com:lostgr8t"].pack("m*")
  page.driver.header 'Authorization', "Basic #{encoded_login}"
  visit(welcome_path)
end

Then /^I should see a text box to enter a swinfo request$/ do
  find(:xpath, '//label[text()="swinfo"]')
end

Then /^a submit button$/ do
  find(:xpath, '//form/label[text()="swinfo"]/../input[@type="submit"]')
end
