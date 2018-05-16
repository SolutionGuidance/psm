Feature: Draft Applications Report
  Users wish to access the Draft Applications report

  Scenario: Can Access Draft Applications Page
    Given I am logged in as an admin
    And I am on the draft applications page
    Then I should see the draft applications page
    Then I should see some draft applications for '2017-08-01'

  Scenario: Download Draft Applications CSV
    Given I am logged in as an admin
    And I am on the draft applications page
    And I download the draft applications report
    Then I should have no errors
