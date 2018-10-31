package gov.medicaid.features.application.ui;

import gov.medicaid.features.PsmPage;

import java.time.LocalDate;

/**
 * PageObject to interact with the "PCA Agency Info" step of an individual
 * provider application. This page is reached by logging in, creating an
 * application, and selecting an individual provider type.
 */
public class PersonalCareAssistantAgencyInfoPage extends PsmPage {

    public void enterAgencyName(String agencyName) {
        sendKeysIndividually("[name=_11_name]", agencyName);
    }

    public void enterAgencyId(String agencyId) {
        sendKeysIndividually("[name=_11_agencyId]", agencyId);
    }

    public void enterAgencyNpi(String agencyNpi) {
        sendKeysIndividually("[name=_11_npi]", agencyNpi);
    }

    public void enterFaxNumber(String fax1, String fax2, String fax3) {
        sendKeysIndividually("[name=_11_fax1]", fax1);
        sendKeysIndividually("[name=_11_fax2]", fax2);
        sendKeysIndividually("[name=_11_fax3]", fax3);
    }

    public void enterAgencyContactName(String agencyContactName) {
        sendKeysIndividually("[name=_11_contactName]", agencyContactName);
    }

    public void enterBackgroundStudyId(String backgroundStudyId) {
        sendKeysIndividually("[name=_11_bgsId]", backgroundStudyId);
    }

    public void enterClearanceDate(LocalDate clearanceDate) {
        sendKeysIndividually("[name=_11_clearanceDate]", format(clearanceDate));
    }

    public void clickNext() {
        click($(".nextBtn"));
    }
}
