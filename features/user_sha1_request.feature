@snapshot @no-database-cleaner
Feature: User submits a sha1 query

  Scenario: Submit sha1 query
    Given A Test user is on the welcome page
    And I enter a sha1 into the sha1 form
    When I hit the sha1 submit button
    Then I should see the hits
