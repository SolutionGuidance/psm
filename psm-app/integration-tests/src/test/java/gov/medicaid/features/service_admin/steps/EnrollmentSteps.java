package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.enrollment.ui.EnrollmentListPage;
import gov.medicaid.features.enrollment.ui.ViewEnrollmentPage;
import gov.medicaid.features.service_admin.ui.EnrollmentReviewPage;

import net.thucydides.core.annotations.Step;

import static net.thucydides.core.pages.PageObject.withParameters;

import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentSteps {
    EnrollmentListPage enrollmentListPage;

    EnrollmentReviewPage enrollmentReviewPage;

    ViewEnrollmentPage viewEnrollmentPage;

    String approvedEnrollmentId = null;

    @Step
    public void navigateToReviewPageFor(String npi) {
        enrollmentListPage.clickActionForNpi(npi, ".reviewLink");
    }

    @Step
    public void approveEnrollment() {
        approvedEnrollmentId = enrollmentReviewPage.getEnrollmentId();
        enrollmentReviewPage.approve();
    }

    @Step
    public void navigateToMostRecentEnrollment() {
        assertThat(approvedEnrollmentId).isNotNull();
        viewEnrollmentPage.open("view.enrollment", withParameters(approvedEnrollmentId));
    }

    @Step
    public void verifyState(String state) {
        viewEnrollmentPage.verifyState(state);
    }
}
