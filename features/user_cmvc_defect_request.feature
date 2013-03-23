@snapshot @no-database-cleaner @cmvc
Feature: User can view the text of a CMVC defect

  Scenario: User submits request to view CMVC defect
    Given A Real user is on the welcome page
    And they fill in a defect in the cmvc defects form
    And they hit the cmvc defect submit button
    Then they should see the defect displayed

    
