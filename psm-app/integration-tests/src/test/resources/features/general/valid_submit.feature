Feature: Submit the form with valid information

  Scenario Outline: Fill out the submit page
  Given I am at the submit information page as a <provider> with license <licenseType>
  And I select no to all the disclosure questions
  And I input <provider_name> and <provider_title> as provider name and title
  And I check the terms of agreement
  And I fill in today's date
  When I hit submit enrollment
  Then I should have successfully submitted the form

    Examples:
    |provider_name| provider_title|provider | licenseType|
    |p1           |p1             |Acupuncturist| Acupuncturist|
