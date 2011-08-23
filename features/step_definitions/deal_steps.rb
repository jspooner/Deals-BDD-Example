Then /^the deal should be saved$/ do
  page.should have_content("Deal was successfully created.")
end