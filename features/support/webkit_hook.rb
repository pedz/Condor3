# Note... to use this, you need to tag your Scenario or Feature with
# both @javascript and @webkit.  e.g.
#  @javascript @webkit
#  Scenario: ...
# and the order is important.  You want the javascript hooks done
# first.

Before('@webkit') do
  puts "webkit"
  Capybara.current_driver = :webkit
end

Before('@javascript') do
  puts "javascript"
end