package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class EnrollmentListStepDefinitions {
    @Steps
    EnrollmentListSteps enrollmentListSteps;

    @Then("^I should see enrollments$")
    public void i_should_see_enrollments() {
        enrollmentListSteps.verifyEnrollmentsInTable();
    }
}
