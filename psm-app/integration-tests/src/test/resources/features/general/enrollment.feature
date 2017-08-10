Feature: Provider Enrollment Checks
  As a provider I want to submit an enrollment form so I can qualify to receive reimbursements
  for Medicaid expenses.

  @psm-4.5
  Scenario: The PSM shall provide a screen to verify entered information.
    Given I have started an enrollment
    And I have provided all required information for an organizational enrollment
    When  I click 'next' on the Ownership Info Page
    Then I should be able to verify all entered information



