package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.TimeToReviewPage;

import net.thucydides.core.annotations.Step;

public class TimeToReviewReportSteps {
    private TimeToReviewPage timeToReviewPage;

    @Step
    public void checkOnTimeToReviewPage() {
        timeToReviewPage.checkOnPage();
    }

    @Step
    public void checkTimeToReviewPageHasNARowFor(String month) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasMean(month, "N/A");
        timeToReviewPage.checkRowHasMedian(month, "N/A");
    }

    @Step
    public void checkTimeToReviewPageHasRowWithEnrollments(String month, String numEnrollments) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasNumber(month, numEnrollments);
    }

    @Step
    public void downloadTimeToReviewReportCsv() {
        timeToReviewPage.click$(".downloadTimeToReview");
    }
}
