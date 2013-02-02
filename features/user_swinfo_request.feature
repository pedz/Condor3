#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
Feature: User submits a swinfo query
  In order to look up the entries for a given Defect or other item, I
  submit a query in the swinfo form.

  @javascript @webkit
  Scenario: Submit swinfo query for a defect via browser
    Given I am on the welcome page
    And The database has a single entry
    And I enter a defect into the swinfo form
    When I hit the submit button
    Then I should see the results
