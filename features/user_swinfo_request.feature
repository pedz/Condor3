@snapshot @no-database-cleaner @javascript @webkit
Feature: User submits a swinfo query
  In order to look up the entries for a given Defect or other item, I
  submit a query in the swinfo form.

  Scenario Outline: Submit swinfo query for an item via browser
    Given A Test user is on the welcome page
    And I want to find <ItemType>
    And I enter <Item> into the swinfo form
    When I hit the swinfo submit button
    Then I should see <Item> in the results

    Examples:
    | ItemType            | Item                     |
    | a Defect            | 638587                   |
    | an APAR             | IZ08384                  |
    | a PTF               | U825141                  |
    | a VIOS Service Pack | VIOS 2.2.1.4             |
    | an AIX Serive Pack  | 6100-05-04               |
    | a Fileset with VRMF | bos.mp64 6.1.4.11        |
    | a Fileset           | devices.pci.14106902.rte |

  Scenario: Submit swinfo query for a CQ Defect via browser
    Given A Test user is on the welcome page
    And I want to find a CQ defect
    And I enter AX114369 into the swinfo form
    When I hit the swinfo submit button
    Then I should see 741813 in the results
