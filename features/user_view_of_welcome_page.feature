Feature: User views Welcome page
  In order to allow versitility I will need a choice of queries that I
  can submit.
  
  Scenario: Various queries which must be avalable on the welcome page
    Given I am on the welcome page
    Then I should see multiple forms

  Scenario Outline: The types of queries should include
    Given I am on the welcome page
    Then I see the <FormName> form
    And The form has <VisualText> to guide me to the correct text box
    And The text box is called <TextBoxName>
    And The form has a submit button

    Examples:
    | VisualText          | FormName            | TextBoxName |
    | swinfo              | swinfo_form         | item        |
    | which fileset       | which_filesets_form | path        |
    | sha1                | sha1s_form          | sha1        |
    | cmvc defect         | defects_form        | defect      |
    | cmvc defect changes | changes_form        | change      |
    | file change history | file_changes_form   | file        |
