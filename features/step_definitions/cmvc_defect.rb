And /^they fill in a defect in the cmvc defects form$/ do
  within('#cmvc-defects-form') do
    fill_in('cmvc_defect', with: '638587')
  end
end

And /^they hit the cmvc defect submit button$/ do
  within('#cmvc-defects-form') do
    click_button('Submit')
  end
end

Then /^they should see the defect displayed$/ do
  page.should have_content('name')
end
