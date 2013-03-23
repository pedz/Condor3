#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 

# No longer used
And /^The database has a single entry$/ do
  @current_adv = FactoryGirl.create(:adv)
end

And /^I want to find (.*)$/ do |not_used|
  # do nothing
end

And /^I enter (.*) into the swinfo form$/ do |item|
  within('#swinfo-form') do
    fill_in('item', with: item)
  end
end

When /^I hit the swinfo submit button$/ do
  within('#swinfo-form') do
    click_button('Submit')
  end
end

Then /^I should see (.*) in the results$/ do |item|
  within('table.upd_apar_defs tbody') do
    tr1 = find('tr:first-child')
    tr1.text.should have_content(item)
  end
end
