Feature: Create Deals
	In order to display deals 
	As an admin
	I want add deals to the site.
	You can find wireframes at http://foobar.com
	
	Background:
		Given I am a user named "foo" with an email "user@test.com" and password "please"
	
	Scenario: Create a new deal
		Given I am on the new deal page
		When I fill in "Title" with "Mega skateboard deals"
		When I fill in "Start date" with "2011/9/1"
		When I fill in "End date" with "2011/9/1"
		When I fill in "Quantity" with "1000"
		And I press "Create Deal"
		Then the deal should be saved
		Then I should see "Mega skateboard deals"
	
	Scenario: Validate the new deal
		Given I am on the new deal page
		And I press "Create Deal"
		Then I should see "Title can't be blank"		
		 