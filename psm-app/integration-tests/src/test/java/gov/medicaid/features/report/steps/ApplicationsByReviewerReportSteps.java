package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ApplicationsByReviewerPage;

import net.thucydides.core.annotations.Step;

public class ApplicationsByReviewerReportSteps {
    private ApplicationsByReviewerPage applicationsByReviewerPage;

    @Step
    public void searchApplicationsInReviewBetween(String d1, String d2) {
        applicationsByReviewerPage.submitSearch(d1, d2);
    }

    @Step
    public void searchApplicationsInReviewWithClearedDates() {
        applicationsByReviewerPage.clearDates();
        applicationsByReviewerPage.clickViewReportButton();
    }

    @Step
    public void checkNoApplicationsByReviewerResults() {
        applicationsByReviewerPage.checkHasNoResults();
    }

    @Step
    public void checkApplicationsByReviewerHasResults() {
        applicationsByReviewerPage.checkHasResults();
    }

    @Step
    public void downloadApplicationsByReviewerReport() {
        applicationsByReviewerPage.click$(".downloadApplicationsByReviewerLink");
    }
}
