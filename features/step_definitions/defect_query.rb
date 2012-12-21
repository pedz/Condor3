And /^The database is set up$/ do
  @current_adv = FactoryGirl.create(:adv)
end

And /^I enter a defect into the swinfo form$/ do
  within('#new_swinfo') do
    fill_in('swinfo[item]', with: @current_adv.defect.name)
  end
end

When /^I hit the submit button$/ do
  within('#new_swinfo') do
    click_button('Submit')
  end
end

Then /^I should see the results$/ do
  save_and_open_page
end
