package gov.medicaid.features.general.ui;


import cucumber.api.PendingException;
import net.thucydides.core.pages.PageObject;


public class EnrollmentPage extends PageObject {
    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

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
            throw new PendingException(); // See Issue #346
        }
    }

    public void verifyMedicaidNumberAccepted() {
        throw new PendingException(); // See Issue #347
    }


    public boolean isPersonalEnrollment() {
        return this.getTitle().equals("Personal Information");
    }

    public boolean isOrganizaionalEnrollment() {
        return this.getTitle().equals("Organization Information");
    }

    public void setNPI(String npi) {
        $("[name='_15_npi']").sendKeys(npi);
    }

    public void setEffectiveDate(String effectiveDate) {
        $("[name='_15_effectiveDate']").type(effectiveDate);
    }


    public void setDoingBusinessAs(String dba) {
        $("#name").sendKeys(dba);
    }

    public void setLegalName(String legalNamne){
        $("#legalName").sendKeys(legalNamne);
    }

    public void setCity(String city){
        $(".cityInputFor").sendKeys(city);
    }

    public void selectState(String state){
        $(".stateSelectFor").selectByVisibleText(state);
    }

    public void setAddr1(String addr1) {
        $("[name='_15_addressLine1']").sendKeys(addr1);
    }

    public void setZipcode(String zipcode){
        $(".zipInputFor").sendKeys(zipcode);
    }
    public void selectCounty(String countyName){
        $(".countySelectFor").selectByVisibleText(countyName);
    }

    public void setPhoneNumber(String phoneNumber) {
        $("[name='_15_phone1']").sendKeys(phoneNumber);
    }

    public void setContactName(String contactName) {
        $("#contactName").sendKeys(contactName);
    }

    public void setContactPhone(String contactPhone){
        $("[name='_15_contactPhone1']").sendKeys(contactPhone);
    }

    public void enterIndividualMember() {
        $("#addMember").click();
    }

    public void setIndividualOwnerNPI(String npi){
        $("[name='_16_npi_0']").sendKeys(npi);
    }

    public void setIndividualOwnerName(String ownerName){
        $("[name='_16_name_0']").sendKeys(ownerName);
    }

    public void setIndividualProviderType(String providerType){
        $("[name='_16_providerType_0']").selectByVisibleText(providerType);
    }

    public void setIndividualOwnerSoSec(String soSec) {
        $("[name='_16_ssn_0']").sendKeys(soSec);
    }
}
