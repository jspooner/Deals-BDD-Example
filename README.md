Snippets
========

1. features/step_definitions/deal_steps.rb
------------------------------------------

    Then /^the deal should be saved$/ do
      pending # express the regexp above with the code you wish you had
    end

2. config/routes.rb
-------------------

    resources :deals

3. Generate Scaffolding
-----------------------

    $ bundle exec rails g scaffold deals title:string start_date:datetime end_date:datetime quantity:integer description:text number_sold:integer

3. db/migrations/*_create_deals.rb
----------------------------------

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


4. spec/models/deal_spec.rb
---------------------------

    describe Deal do
      describe "init" do
        it { Deal.new.number_sold.should eql(0) }
        it { Deal.new.quantity.should eql(0) }
      end
    end

4a. Migrate & Test
------------------

    $ rake db:migrate
    $ RAILS_ENV=test rake db:migrate
    $ rake spec:models

5. FactoryGirl spec/factory.rb
------------------------------

    Factory.define :deal do |d|
      d.title 'Mega Skateboard deal'
      d.start_date (Date.today-5).to_date
      d.end_date (Date.today+5).to_date
      d.description 'Mega ramp skateboard by Jake Brown is on sale.'
      d.quantity 100
      d.number_sold 0
    end

5a. Update Controller Spec spec/controllers/deals_controller_spec.rb
--------------------------------------------------------------------

    def valid_attributes
      # {}
      Factory.attributes_for(:deal)
    end

    # Replace ever Deal.create with Factory(:deal)
    # deal = Deal.create! valid_attributes
    deal = Factory(:deal)


    $ rake spec:controllers

6. app/views/deals/_form.html.erb
---------------------------------

    <div class="field">
      <%= f.label :start_date %><br />
      <%= f.text_field :start_date %>
    </div>
    <div class="field">
      <%= f.label :end_date %><br />
      <%= f.text_field :end_date %>
    </div>

7. features/step_definitions/deal_steps.rb
------------------------------------------

    Then /^the deal should be saved$/ do
      page.should have_content("Deal was successfully created.")
    end

8. spec/models/deal_spec.rb
---------------------------

    describe "validation" do
      it { Deal.new.should have(1).errors_on(:title) }    
    end

    $ rake spec:models

9. app/models/deal.rb
---------------------

    validates_presence_of :title

    $ rake spec:models

10. features/step_definitions/home_steps.rb
-------------------------------------------

    Given /^there are (\d+) past (\d+) current and (\d+) future deals$/ do |arg1, arg2, arg3|
      pending # express the regexp above with the code you wish you had
    end

    Then /^I should see (\d+) deals$/ do |arg1|
      pending # express the regexp above with the code you wish you had
    end

11. features/step_definitions/home_steps.rb
-------------------------------------------

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

12. features/step_definitions/home_steps.rb
-------------------------------------------

    Then /^I should see (\d+) deals$/ do |arg1|
      pending # express the regexp above with the code you wish you had
    end

13. features/step_definitions/home_steps.rb
-------------------------------------------

    Then /^I should see (\d+) deals$/ do |arg1|
      page.should have_selector("div.deal", :count => arg1)
    end

14. spec/models/deal_spec.rb
----------------------------

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


15. app/models/deal.rb 
----------------------

    scope :current

16. app/models/deal.rb 
----------------------

    scope :current, where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)

17. app/models/deal.rb 
----------------------

    scope :current, lambda{ where("Date(start_date) <= ? AND Date(end_date) >= ?", Date.today.to_date, Date.today.to_date)}

18. spec/controllers/home_controller_spec.rb
--------------------------------------------

    it "should set the current deals" do
      deal = Factory(:deal)
      get :index
      assigns(:deals).should eq([deal])
    end

19. app/controllers/home_controller.rb
--------------------------------------

    @deals = Deal.current


20. app/views/home/index.html
-----------------------------

    <% @deals.each do |deal| %>
     <div class="deal">
      <%= deal.title %>
     </div>
    <% end %>

21. features/home_page.feature
------------------------------

    Then I should see 4 links to deals
    
22. features/step_definitions/home_steps.rb
-------------------------------------------

    Then /^I should see (\d+) links to deals$/ do |arg1|
      page.should have_selector("div.deal a[href^='/deals/']", :count => arg1)
    end
    
23. app/views/home/index.html
-----------------------------

    <% @deals.each do |deal| %>
     <div class="deal">
       <%= link_to deal.title, deal %>
     </div>
    <% end %>
