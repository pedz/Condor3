And /^I enter a full AIX path into the which filesets form$/ do
  within('#which-filesets-form') do
    fill_in('path', with: '/usr/lib/drivers/nfs.ext')
  end
end

And /^I enter a partial AIX path into the which filesets form$/ do
  within('#which-filesets-form') do
    fill_in('path', with: 'nfs.ext')
  end
end

When /^I hit the which filesets submit button$/ do
  within('#which-filesets-form') do
    click_button('Submit')
  end
end

Then /^I should see which filesets ship that particular AIX file$/ do
  find('.which-filesets-container').should have_content('/usr/lib/drivers/nfs.ext')
end
