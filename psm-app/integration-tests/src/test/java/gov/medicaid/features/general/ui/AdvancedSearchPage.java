package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;

public class AdvancedSearchPage extends PsmPage {
    public void searchByNpi(String npi) {
        $("#npiInput").sendKeys(npi);
        $("#showSearchEnrollmentsResultBtn").click();
    }
}
