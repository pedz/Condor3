Feature: User views Welcome page
  In order to allow versitility I will need a choice of queries that I
  can submit.
  
  Scenario: Various queries which must be avalable on the welcome page
    Given A test user is on the welcome page
    Then I should see multiple forms

  Scenario Outline: The types of queries should include
    Given A test user is on the welcome page
    Then I see the <FormName> form
    And The form has <VisualText> to guide me to the correct text box
    And The text box is called <TextBoxName>
    And The form has a submit button

    Examples:
    | VisualText          | FormName            | TextBoxName |
    | swinfo              | swinfo-form         | item        |
    | which fileset       | which-filesets-form | path        |
    | sha1                | sha1s-form          | sha1        |
    | cmvc defect         | cmvc-defects-form   | cmvc_defect |
    | cmvc defect changes | cmvc-changes-form   | cmvc_change |
    | file change history | file-changes-form   | file        |

