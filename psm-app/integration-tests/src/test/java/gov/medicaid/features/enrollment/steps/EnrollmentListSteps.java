package gov.medicaid.features.enrollment.steps;

import gov.medicaid.features.enrollment.ui.EnrollmentListPage;

import net.thucydides.core.annotations.Step;

public class EnrollmentListSteps {
    EnrollmentListPage enrollmentListPage;

    @Step
    void verifyEnrollmentsInTable() {
        enrollmentListPage.checkEnrollmentsInTable();
    }
}
