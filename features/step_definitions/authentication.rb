module Authentication
  def visit_as(user, pass, path)
    case page.mode
    when :selenium
      visit("http://#{user.gsub(' ', '%20').gsub('@', '%40')}:#{pass}@localhost#{path}")

    when :rack_test
      encoded_login = ["#{user}:#{pass}"].pack("m*")
      page.driver.header 'Authorization', "Basic #{encoded_login}"
      visit(path)

    when :webkit
      page.driver.browser.authenticate(user, pass)
      visit(path)
    end
  end
end

World(Authentication)

Given /^A Real user is on the welcome page$/ do
  visit_as('pedzan@us.ibm.com', 'g0lf4you', welcome_path)
end

Given /^A test user is on the welcome page$/ do
  visit_as('testuser', 'secret', welcome_path)
end
