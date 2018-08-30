package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * PageObject to interact with the "Personal Info" step of an individual
 * provider enrollment. This page is reached by logging in, creating an
 * enrollment, and selecting an individual provider type.
 */
public class PersonalInfoPage extends PsmPage {
    private static final String PROVIDER_TOO_YOUNG_ERROR_MESSAGE =
            "Provider age should be 18 or above during enrollment.";

    private static final String SAME_AS_ABOVE_EMAIL_ERROR_MESSAGE =
            "Email Address is required when same as above is checked.";

    public void enterDOB(LocalDate dateOfBirth) {
        $("[name=_02_dob]").type(format(dateOfBirth));
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
        click($("#sameAsAbove"));
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    public void checkForTooYoungError() throws Exception {
        checkForFormError("_02_dob", PROVIDER_TOO_YOUNG_ERROR_MESSAGE);
    }

    public void checkForSameAsAboveEmailError() throws Exception {
        assertThat($(".errorInfo > ._02_email").getText())
                .contains(SAME_AS_ABOVE_EMAIL_ERROR_MESSAGE);
    }

    public void checkEmailAddressDisplaysAsRequired() throws Exception {
        assertThat($("#requireEmailAddressLabel.required") != null);
        assertThat($("requireEmailAddressLabel.required.hidden") == null);
    }
}
