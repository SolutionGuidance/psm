Feature: Create a new enrollment
  We should put here some text on why a user would want to
  create a new enrollment

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
    
