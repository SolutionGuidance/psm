package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ReviewedDocumentsPage;

import net.thucydides.core.annotations.Step;

public class ReviewedDocumentsReportSteps {
    private ReviewedDocumentsPage reviewedDocumentsPage;

    @Step
    public void checkOnReviewedDocumentsPage() {
        reviewedDocumentsPage.checkOnPage();
    }

    @Step
    public void checkReviewedDocumentsPageHasRowWithEnrollments(String month, String numDocuments) {
        reviewedDocumentsPage.checkHasRowFor(month);
        reviewedDocumentsPage.checkRowHasNumber(month, numDocuments);
    }

    @Step
    public void downloadReviewedDocumentsReportCsv() {
        reviewedDocumentsPage.click$(".downloadReviewedDocuments");
    }
}
