Feature: Fill out the Practice Info with valid information

  This run will test valid inputs in which the provider selects the options
  of maintaining their own private practice and not being contracted by a
  group practice. Other valid scenarios to be tested are Private & Group, Not
  Private and not group, and not private and group.

  Scenario Outline: Proceed to Summary after entering valid practice information
    Given I am at the personal information page as a valid <provider> with license <licenseType>
    And I select Yes to maintaining my own private practice
    And I select No to being contracted by a group practice
    And I fill the form with "Kevin's Private Practice" for Private Practice Name
    And I fill the form with "11/15/2005" for Effective Date
    And I fill the form with "1000 West Main St" for Practice Address
    And I fill the form with "Charlottesville" for City
    And I fill the form with "Virginia" for State
    And I fill the form with "22904" for Zip Code
    And I fill the form with "703-861-7780" for Practice Phone Number
    And I check Same as Above for Billing Address
    And I fill the form with "11/15" for Fiscal Year End
    And I check the first Remittance Sequence
    When I hit next to go to the next page
    Then I should proceed to the next form with no errors

    Examples:
      |provider| licenseType |
      |Acupuncturist| Acupuncturist|
