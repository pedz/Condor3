And /^I enter a sha1 into the sha1 form$/ do
  within('#sha1s-form') do
    fill_in('sha1', with: '3a173b57f14abd33433d4c47d8d44df50a568937')
  end
end

When /^I hit the sha1 submit button$/ do
  within('#sha1s-form') do
    click_button('Submit')
  end
end

Then /^I should see the hits$/ do
  puts Rails.env.to_s
  find('.sha1s-container').should have_content('/usr/lib/drivers/if_vi')
end
