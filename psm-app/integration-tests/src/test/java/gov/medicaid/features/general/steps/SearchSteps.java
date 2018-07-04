package gov.medicaid.features.general.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.enrollment.ui.EnrollmentListPage;
import gov.medicaid.features.general.ui.AdvancedSearchPage;
import gov.medicaid.features.general.ui.DashboardPage;

import net.thucydides.core.annotations.Step;

public class SearchSteps {
    PsmPage psmPage;
    DashboardPage dashboardPage;
    AdvancedSearchPage advancedSearchPage;
    EnrollmentListPage enrollmentListPage;

    @Step
    public void filterByNpi(String npi) {
        enrollmentListPage.filterByNpi(npi);
    }

    @Step
    public void quickSearchByNpi(String npi) {
        dashboardPage.quickSearch(npi);
    }

    @Step
    public void advancedSearchByNpi(String npi) {
        advancedSearchPage.searchByNpi(npi);
    }

    @Step
    public void verifySearchResults() {
        enrollmentListPage.checkEnrollmentsInTable();
    }
}
