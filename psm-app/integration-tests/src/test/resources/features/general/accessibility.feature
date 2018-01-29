Feature: Accessibility Checks
  Users wish to access accessible pages

  Scenario: Login Page Accessibility
    Given I have the application open in my browser
    Then I should have no accessibility issues

#  Scenario: Provider Dashboard Page Accessibility
#    Given I am logged in
#    And I am on the dashboard page
#    Then I should have no accessibility issues