package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class DraftApplicationsReportStepDefinitions {
    @Steps
    private DraftApplicationsReportSteps draftApplicationsSteps;

    @Given("^I download the draft applications report$")
    public void i_download_the_draft_applications_report() {
        draftApplicationsSteps.downloadDraftReportCsv();
    }

    @Then("^I should see the draft applications page$")
    public void i_should_see_the_draft_applications_page() {
        draftApplicationsSteps.checkOnDraftApplicationsPage();
    }

    @Then("^I should see some draft applications for '(.*)'$")
    public void i_should_see_some_draft_applications_for(String month) {
        draftApplicationsSteps.checkDraftApplicationsPageHasTableFor(month);
    }
}
