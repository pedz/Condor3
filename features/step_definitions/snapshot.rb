And /^I enter a sha1 into the sha1 form$/ do
  within('#sha1s-form') do
    fill_in('sha1', with: '9a81972bc88027b973a898cd319fe58b1f46279b')
  end
end

When /^I hit the sha1 submit button$/ do
  within('#sha1s-form') do
    click_button('Submit')
  end
end

Then /^I should see the hits$/ do
  find('.sha1s-container').should have_content('/usr/lib/drivers/nfs.ext')
end
