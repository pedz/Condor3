And /^The database is set up$/ do
  @current_adv = FactoryGirl.create(:adv)
end

And /^I enter a defect into the swinfo form$/ do
  within('#swinfo_form') do
    fill_in('item', with: @current_adv.defect.name)
  end
end

When /^I hit the submit button$/ do
  within('#swinfo_form') do
    click_button('Submit')
  end
end

Then /^I should see the results$/ do
  pending
end
