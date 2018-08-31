package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import java.time.LocalDate;

/**
 * PageObject to interact with the "Individual PCA Info" step of an individual
 * provider enrollment. This page is reached by logging in, creating an
 * enrollment, and selecting an individual provider type.
 */
public class PersonalCareAssistantPersonalInfoPage extends PsmPage {

    public void enterDOB(LocalDate dateOfBirth) {
        $("[name=_10_dob]").type(format(dateOfBirth));
    }

    public void enterFirstName(String firstName) {
        $("#firstName").type(firstName);
    }

    public void enterMiddleName(String middleName) {
        $("#middleName").type(middleName);
    }

    public void enterLastName(String lastName) {
        $("[name=_10_lastName]").type(lastName);
    }

    public void enterSSN(String SSN) {
        $("[name=_10_ssn]").type(SSN);
    }

    public void enterResidentialAddress(String residentialAddress) {
        $("[name=_10_addressLine1]")
                .type(residentialAddress);
    }

    public void enterCity(String city) {
        $("#ind_pca_information__10_city").type(city);
    }

    public void selectCounty(String countyName) {
        $(".countySelectFor").selectByVisibleText(countyName);
    }

    public void selectState(String state) {
        $(".stateSelectFor").selectByVisibleText(state);
    }

    public void setZipcode(String zipcode) {
        $(".zipInputFor").sendKeys(zipcode);
    }

    public void enterEmail(String email) {
        $("#emailAddress").type(email);
    }

    public void selectEighteenOrOlder() {
        click($("#ind_pca_information__10_adultInd_yes"));
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    public void addLicense() {
        click($("#addLicense"));
    }
}
