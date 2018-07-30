package gov.medicaid.features.general.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.enrollment.ui.EnrollmentListPage;
import gov.medicaid.features.general.ui.AdvancedSearchPage;
import gov.medicaid.features.general.ui.AllEnrollmentsPage;
import net.thucydides.core.annotations.Step;

public class SearchSteps {
    PsmPage psmPage;
    AllEnrollmentsPage allEnrollmentsPage;
    AdvancedSearchPage advancedSearchPage;
    EnrollmentListPage enrollmentListPage;

    @Step
    public void filterByNpi(String npi) {
        enrollmentListPage.filterByNpi(npi);
    }

    @Step
    public void quickSearchByNpi(String npi) {
        allEnrollmentsPage.quickSearch(npi);
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
