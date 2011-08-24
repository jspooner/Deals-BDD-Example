Given /^there are (\d+) past (\d+) current and (\d+) future deals$/ do |past, current, future|
  past.to_i.times do
    Factory(:deal, {:start_date => Date.today-30, :end_date => Date.today-20})
  end
  current.to_i.times do
    Factory(:deal, {:start_date => Date.today-3, :end_date => Date.today+2})
  end
  current.to_i.times do
    Factory(:deal, {:start_date => Date.today+3, :end_date => Date.today+6})
  end
end

Then /^I should see (\d+) links to deals$/ do |arg1|
  page.should have_selector("div.deal a[href^='/deals/']", :count => arg1)
end
