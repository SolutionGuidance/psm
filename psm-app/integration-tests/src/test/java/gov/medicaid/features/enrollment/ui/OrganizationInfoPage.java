package gov.medicaid.features.enrollment.ui;

import cucumber.api.PendingException;

import static org.assertj.core.api.Assertions.assertThat;

public class OrganizationInfoPage extends EnrollmentPage {
    private static final String ORGANIZATION_FEIN_ERROR_MESSAGE =
            "Organization FEIN length must be 9 characters.";

    public void setFEIN(String feinValue) {
        $("#fein").typeAndTab(feinValue);
    }

    public void verifyApplicantNameAccepted() {
        if (isOrganizaionalEnrollment()) {
            $("#legalName").sendKeys("verify_name");
        } else {
            $("#firstName").sendKeys("first_name");
            $("#middleName").sendKeys("MI");
            $("[name='_02_lastName']").sendKeys("last_name");
        }
    }

    public void verifyContactNameAccepted() {
        $("#contactName").sendKeys("contact_name");
    }

    public void verifyContactPhoneAccepted() {
        if (isOrganizaionalEnrollment()) {
            $("[name='_15_contactPhone1']").sendKeys("217");
            $("[name='_15_contactPhone2']").sendKeys("217");
            $("[name='_15_contactPhone3']").sendKeys("217");
        } else {
            throw new PendingException("Issue #346 - Capture contact phone # for individual provider enrollments");
        }
    }

    public void verifyContactEmailAccepted() {
        $("#contactEmail").sendKeys("contact_email");
    }

    public void verifyMedicaidNumberAccepted() {
        throw new PendingException("Issue #347 - Capture Medicaid Number for new Enrollments");
    }

    public boolean isPersonalEnrollment() {
        return this.getTitle().equals("Personal Information");
    }

    public boolean isOrganizaionalEnrollment() {
        return this.getTitle().equals("Organization Information");
    }

    public void setNPI(String npi) {
        $("[name='_15_npi']").type(npi);
    }

    public void setEffectiveDate(String effectiveDate) {
        sendKeysIndividually("[name='_15_effectiveDate']", effectiveDate);
    }

    public void setDoingBusinessAs(String dba) {
        $("#name").sendKeys(dba);
    }

    public void setLegalName(String legalName) {
        $("#legalName").sendKeys(legalName);
    }

    public void setCity(String city) {
        $(".cityInputFor").sendKeys(city);
    }

    public void selectState(String state) {
        $(".stateSelectFor").selectByVisibleText(state);
    }

    public void setAddr1(String addr1) {
        $("[name='_15_addressLine1']").sendKeys(addr1);
    }

    public void setZipcode(String zipcode) {
        $(".zipInputFor").sendKeys(zipcode);
    }

    public void selectCounty(String countyName) {
        $(".countySelectFor").selectByVisibleText(countyName);
    }

    public void setPhoneNumber(String phoneNumber) {
        $("[name='_15_phone1']").sendKeys(phoneNumber);
    }

    public void setContactName(String contactName) {
        $("#contactName").sendKeys(contactName);
    }

    public void setContactPhone(String contactPhone) {
        $("[name='_15_contactPhone1']").sendKeys(contactPhone);
    }

    public void setContactEmail(String contactEmail) {
        $("[name='_15_contactEmail']").sendKeys(contactEmail);
    }

    public void checkForFeinError() throws Exception {
        assertThat($(".errorInfo > ._15_fein").getText())
                .contains(ORGANIZATION_FEIN_ERROR_MESSAGE);
    }
}
