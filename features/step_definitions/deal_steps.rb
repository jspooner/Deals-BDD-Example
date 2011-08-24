Then /^the deal should be saved$/ do
  page.should have_content("Deal was successfully created.")
end

When /^I click the "([^"]*)" field$/ do |selector|
  # find("#deal_start_date").trigger('blur')
  # click_link(selector)"
end

Then /^I should see a datepicker$/ do
  page.should have_css('#ui-datepicker-div')
  # page.should have_css('.ui-state-default')
end
