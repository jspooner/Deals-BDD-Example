
Feature: Home Page
	In order to sell deals
	the home page should display open deals.

	Background:
		Given there are 4 past 4 current and 2 future deals

	Scenario: Create a new deal
		Given I am on the home page
		Then I should see 4 deals
		