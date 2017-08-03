Feature: Fill out the personal information form with all valid information
  As a provider filling out a new enrollment, I should be able to move forward
  to the next page with no errors if I enter valid information

  Scenario Outline: Proceed to next page after entering valid form information
    Given I am logged in as a provider
    And I have created a new enrollment as a <provider> and am at the Personal Information Page
    And I fill the form with "p1" a valid first name
    And I fill the form with "p1" a valid last name
    And I fill the form with "0000000006" a valid NPI
    And I fill the form with "123-41-1234" a valid SSN
    And I fill the form with "11/15/1990" a valid birthday
    And I fill the form with "bob@gmail.com" a valid email
    And I check the same as above box
    When I hit next
    Then I will move on to the next form with no errors

    Examples:
      | provider                                |
      | Acupuncturist                           |
