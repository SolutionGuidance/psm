package gov.medicaid.features.enrollment.ui;

import cucumber.api.PendingException;

public class OrganizationInfoPage extends EnrollmentPage {
    public void setFEIN(String feinValue) {
        $("#fein").typeAndTab(feinValue);
    }

    public String getFEINValue() {
        return $("#fein").getValue();
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
        $("[name='_15_effectiveDate']").type(effectiveDate);
    }

    public void setDoingBusinessAs(String dba) {
        $("#name").sendKeys(dba);
    }

    public void setLegalName(String legalNamne) {
        $("#legalName").sendKeys(legalNamne);
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
}
