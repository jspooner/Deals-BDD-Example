require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end

Factory.define :deal do |d|
  d.title 'Mega Skateboard deal'
  d.start_date (Date.today-5).to_date
  d.end_date (Date.today+5).to_date
  d.description 'Mega ramp skateboard by Jake Brown is on sale.'
  d.quantity 100
  d.number_sold 0
end