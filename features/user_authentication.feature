@ldap
Feature: User authenticates via Bluepages using LDAP
  In order to provide authentication, a Real user needs to have a
  valid Bluepages entry and associated password.

  Scenario: A Real user can view the front page
    Given A Real user is on the welcome page
    Then They should see multiple forms

  Scenario: A Test user can view the front page
    Given A Test user is on the welcome page
    Then They should see multiple forms

  Scenario: An Unknown user is not allowed
    Given An Unknown user goes to the welcome page
    Then They should see an Access Denied message

  Scenario: A Real user with an invalid password is not allowed
    Given A Real user but an invalid password goes to the welcome page
    Then They should see an Access Denied message
