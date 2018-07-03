package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;
import net.serenitybdd.core.annotations.findby.By;

import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentListPage extends PsmPage {

    public void checkEnrollmentsInTable() {
        assertThat(
            getDriver()
            .findElements(By.cssSelector(".generalTable tr"))
            .size())
        .isGreaterThan(1);
    }

    public void filterByNpi(String npi) {
        // For providers
        if ($("#listByStatusNpi").isPresent()) {
            $("#listByStatusNpi").sendKeys(npi);
            $("#paginationForm").submit();
        } else { // For admins
            $("#enrollmentSearchFilterNpiInput").sendKeys(npi);
            $("#showSearchEnrollmentsResultBtn").click();
        }
    }
}
