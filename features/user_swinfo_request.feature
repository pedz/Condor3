Feature: User submits a swinfo query
  In order to look up the entries for a given Defect or other item, I
  submit a query in the swinfo form.

  Scenario: Submit swinfo query for a defect via browser
    Given I am on the welcome page
    And I enter a defect into the swinfo form
    When I hit the submit button
    Then I should see the results
