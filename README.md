Set Up
======

```bash
git checkout git@github.com:jspooner/Deals-BDD-Example.git .
cd Deals-BDD-Example
```

For Sqlite

```bash
mv database.yml.template database.yml
````

```ruby
gem 'sqlite3'
# gem 'mysql2'
```

For MySQL

```bash
mv mysql_database.yml.template database.yml
```

Update gem file for sqlite or mysql

```bash
$ bundle install
$ rake db:create
$ rake db:migrate
$ RAILS_ENV=test rake db:migrate
$ rake db:seed
```

Snippets
========

1\. features/step_definitions/deal_steps.rb
------------------------------------------
```ruby
Then /^the deal should be saved$/ do
  pending # express the regexp above with the code you wish you had
end
```

2\. config/routes.rb
--------------------

```ruby
  resources :deals
```

3\. Generate Scaffolding
------------------------

```bash
$ bundle exec rails g scaffold deals title:string start_date:datetime end_date:datetime quantity:integer description:text number_sold:integer
```

4\. db/migrations/*_create_deals.rb
-----------------------------------

```ruby
class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.integer :quantity, :default => 0
      t.integer :number_sold, :default => 0
      t.timestamps
    end
  end
end
```

5\. spec/models/deal_spec.rb
---------------------------

```ruby
describe Deal do
  describe "init" do
    it { Deal.new.number_sold.should eql(0) }
    it { Deal.new.quantity.should eql(0) }
  end
end
```

6\. Migrate & Test
------------------
```bash
$ rake db:migrate
$ RAILS_ENV=test rake db:migrate
$ rake spec:models
```

7\. FactoryGirl spec/factory.rb
------------------------------
```ruby
Factory.define :deal do |d|
  d.title 'Mega Skateboard deal'
  d.start_date (Date.today-5).to_date
  d.end_date (Date.today+5).to_date
  d.description 'Mega ramp skateboard by Jake Brown is on sale.'
  d.quantity 100
  d.number_sold 0
end
```

8\. Update Controller Spec spec/controllers/deals_controller_spec.rb
--------------------------------------------------------------------

```ruby
def valid_attributes
  # {}
  Factory.attributes_for(:deal)
end

# Replace ever Deal.create with Factory(:deal)
# deal = Deal.create! valid_attributes
deal = Factory(:deal)
```

```bash
$ rake spec:controllers
```

9\. app/views/deals/_form.html.erb
---------------------------------

```html
    <div class="field">
      <%= f.label :start_date %><br />
      <%= f.text_field :start_date %>
    </div>
    <div class="field">
      <%= f.label :end_date %><br />
      <%= f.text_field :end_date %>
    </div>
```

10\. features/step_definitions/deal_steps.rb
------------------------------------------

```ruby
Then /^the deal should be saved$/ do
  page.should have_content("Deal was successfully created.")
end
```

11\. spec/models/deal_spec.rb
---------------------------

```ruby
describe "validation" do
  it { Deal.new.should have(1).errors_on(:title) }    
end
```

```bash
$ rake spec:models
```

12\. app/models/deal.rb
---------------------

```ruby
validates_presence_of :title
```
```bash
$ rake spec:models
```

13\. features/step_definitions/home_steps.rb
-------------------------------------------

```ruby
Given /^there are (\d+) past (\d+) current and (\d+) future deals$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see (\d+) deals$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
```

14\. features/step_definitions/home_steps.rb
-------------------------------------------

```ruby
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
```

15\. features/step_definitions/home_steps.rb
-------------------------------------------

```ruby
Then /^I should see (\d+) deals$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
```

16\. features/step_definitions/home_steps.rb
-------------------------------------------

```ruby
Then /^I should see (\d+) deals$/ do |arg1|
  page.should have_selector("div.deal", :count => arg1)
end
```

17\. spec/models/deal_spec.rb
----------------------------

```ruby
describe "queries" do
  before(:each) do
    @past    = Factory(:deal, { :start_date => 30.days.ago, :end_date => 29.days.ago })
    @current = Factory(:deal, { :start_date => 5.days.ago, :end_date => 5.days.from_now })
    @future  = Factory(:deal, { :start_date => 5.days.from_now, :end_date => 10.days.from_now })
  end
  it "should find current deals" do
    deals = Deal.current
    deals.should have(1).item
    deals.first.should eql(@current)
  end
end
```

18\. app/models/deal.rb 
----------------------

```ruby
scope :current
```

19\. app/models/deal.rb 
----------------------

```ruby
scope :current, where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)
```

20\. app/models/deal.rb 
----------------------

```ruby
scope :current, lambda{ where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)}
```

21\. spec/controllers/home_controller_spec.rb
--------------------------------------------

```ruby
it "should set the current deals" do
  deal = Factory(:deal)
  get :index
  assigns(:deals).should eq([deal])
end
```

22\. app/controllers/home_controller.rb
--------------------------------------

```ruby
@deals = Deal.current
```

23\. app/views/home/index.html
-----------------------------

```html
    <% @deals.each do |deal| %>
     <div class="deal">
      <%= deal.title %>
     </div>
    <% end %>
```

24\. features/home_page.feature
------------------------------

```cucumber
    Then I should see 4 links to deals
```

25\. features/step_definitions/home_steps.rb
-------------------------------------------

```ruby
Then /^I should see (\d+) links to deals$/ do |arg1|
  page.should have_selector("div.deal a[href^='/deals/']", :count => arg1)
end
```

26\. app/views/home/index.html
-----------------------------

```ruby
    <% @deals.each do |deal| %>
     <div class="deal">
       <%= link_to deal.title, deal %>
     </div>
    <% end %>
```







