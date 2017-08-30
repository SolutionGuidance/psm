package gov.medicaid.features.enrollment.ui;

import net.thucydides.core.pages.PageObject;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * PageObject to interact with the "Personal Info" step of an individual
 * provider enrollment. This page is reached by logging in, creating an
 * enrollment, and selecting an individual provider type.
 */
public class PersonalInfoPage extends PageObject {
    private static final String PROVIDER_TOO_YOUNG_ERROR_MESSAGE =
            "Provider age should be 18 or above during enrollment.";

    public void enterDOB(LocalDate dateOfBirth) {
        String dob = dateOfBirth.format(
                DateTimeFormatter.ofPattern("MM/dd/yyyy")
        );
        $("[name=_02_dob]").type(dob);
    }

    public void enterFirstName(String firstName) {
        $("#firstName").type(firstName);
    }

    public void enterMiddleName(String middleName) {
        $("#middleName").type(middleName);
    }

    public void enterLastName(String lastName) {
        $("[name=_02_lastName]").type(lastName);
    }

    public void enterNPI(String NPI) {
        $("[name=_02_npi]").type(NPI);
    }

    public void enterSSN(String SSN) {
        $("[name=_02_ssn]").type(SSN);
    }


    public void enterEmail(String email) {
        $("#emailAddress").type(email);
    }

    public void checkSameAsAbove() {
        $("#sameAsAbove").click();
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

    public void checkForTooYoungError() throws Exception {
        assertThat($(".errorInfo > ._02_dob").getText())
                .contains(PROVIDER_TOO_YOUNG_ERROR_MESSAGE);
    }
}
