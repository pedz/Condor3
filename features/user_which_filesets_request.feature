@snapshot @no-database-cleaner
Feature: User can determine which filesets shipped a particular AIX file

  Scenario: Submit which fileset query using full path
    Given A Test user is on the welcome page
    And I enter a full AIX path into the which filesets form
    When I hit the which filesets submit button
    Then I should see which filesets ship that particular AIX file

  Scenario: Submit which fileset query using partial path
    Given A Test user is on the welcome page
    And I enter a partial AIX path into the which filesets form
    When I hit the which filesets submit button
    Then I should see which filesets ship that particular AIX file
