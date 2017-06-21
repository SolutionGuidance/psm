Feature: Create a new enrollment
  A provider wishes to create an enrollment so they can be reimbursed for the
  work they do serving Medicaid patients.

  Scenario: Should save a draft after entering data on the
  "organizational information" page
    Given: The database is fresh from seed.sql
      And: I am logged into the application as a provider
      And: I click on "Create new enrollment"
      And: I select "Dental Clinic" as provider type
      And: I click "Next"
      And: I enter data into all of the required fields
      And: I click "Next"
     When: I click on "Save as Draft"
     Then: I should see a success page

