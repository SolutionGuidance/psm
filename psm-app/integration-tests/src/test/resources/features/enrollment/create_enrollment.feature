Feature: Create a new enrollment
  A provider wishes to create an enrollment so they can be reimbursed for the
  work they do serving Medicaid patients.

  Scenario: Should save a draft
    Given The database is fresh from seed.sql
      And I am logged into the application as a provider
      And I click on "Create new enrollment" to start a new enrollment
      And I select "Dental Clinic" as provider type
      And I click "Next"
      And I enter values into all of the required organization information fields
      And I click "Next"
     When I click on "Save as Draft"
     Then I should see a success page

