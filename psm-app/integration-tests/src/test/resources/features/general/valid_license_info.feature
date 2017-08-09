Feature: Filling out the license information form with valid information should
  allow me to reach the next page with no errors

  Scenario Outline: Proceed to the next page after inputting valid info to license information
    when I am not a provider at a PHS Indian Hospital
    Given I am logged in as a <provider> and I am at the license information form
    And I choose a valid type of license of <valid_license>
    And I upload an acceptable file from location "../../../../../../README.md"
    And I use a valid certification number of "930"
    And I use a valid origin date of "11/11/1995"
    And I use a valid renewal date of "11/11/2000"
    And I use a valid issuing state of "Alabama"
    When I hit the next button
    Then I should be on the next step of the form

    Examples:
      | provider | valid_license|
      |Acupuncturist| Acupuncturist|
