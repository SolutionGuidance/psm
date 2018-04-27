package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import gov.medicaid.features.general.steps.GeneralSteps;
import gov.medicaid.features.report.steps.ReportSteps;

import net.thucydides.core.annotations.Steps;

public class ReportStepDefinitions {
    @Steps
    private ReportSteps reportSteps;

    @Steps
    private GeneralSteps generalSteps;

    @Given("^I am on the reports page$")
    public void i_am_on_the_reports_page() {
        generalSteps.navigateToReportsPage();
    }

    @Given("^I download the approval report$")
    public void i_download_the_approval_report() {
        reportSteps.downloadApplicationsApprovedReport();
    }

    @Then("^I should see the reports page$")
    public void i_should_see_the_reports_page() {
        reportSteps.checkOnReportPage();
    }
}
