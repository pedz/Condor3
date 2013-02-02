#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
And /^The database has a single entry$/ do
  @current_adv = FactoryGirl.create(:adv)
end

And /^I enter a defect into the swinfo form$/ do
  within('#swinfo-form') do
    fill_in('item', with: @current_adv.defect.name)
  end
end

When /^I hit the submit button$/ do
  within('#swinfo-form') do
    click_button('Submit')
  end
end

Then /^I should see the results$/ do
  within('table.upd_apar_defs tbody') do
    tr1 = find('tr:first-child')
    tds = tr1.all('td')
    tds[0].text.should == '1'
    tds[1].text.should == @current_adv.defect.name
    tds[2].text.should == "IV22222"
  end
end
