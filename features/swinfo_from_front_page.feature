# Feature: Lookup swinfo from front page

#   A user viewing the front page can put a defect, APAR, or other items
#   into the swinfo search box and hit submit to get a list of swinfo hits
#   for that item

#   Scenario: Lookup Swinfo for Defect from Front Page
    
    
Feature: Welcome Page Choices
  In order to allow versitility
  A user will need a choice of queries that they can submit
  
  Scenario: swinfo query must be avalable on welcome page
    Given I am on the welcome page
    Then I should see a text box to enter a swinfo request
    And a submit button
