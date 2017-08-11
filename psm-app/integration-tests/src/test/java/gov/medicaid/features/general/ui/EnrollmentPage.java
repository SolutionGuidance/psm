package gov.medicaid.features.general.ui;


import cucumber.api.PendingException;
import net.serenitybdd.core.annotations.findby.By;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.WebElement;

import java.util.List;


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

    public void setIndividualHireDate(String hireDate) {
        $("[name='_16_startDate_0'").type(hireDate);
    }

    public void setIndividualOwnerDOB(String dob) {
        $("[name='_16_dob_0']").type(dob);
    }

    public void selectEntityType(String entityType) {
        $("#entityType").selectByVisibleText(entityType);
    }

    public void addOwnership() {
        $("#addOwnership").click();
    }

    public void selectOwnershipType(String ownershipType) {
        $(".ownershipType").selectByVisibleText(ownershipType);
    }

    public void setOwnershipFirstName(String first) {
        $("[name='_17_iboFirstName_0']").sendKeys(first);
    }

    public void setOwnershipMiddleName(String middle){
        $("[name='_17_iboMiddleName_0']").sendKeys(middle);
    }

    public void setOwnershipLastName(String last){
        $("[name='_17_iboLastName_0']").sendKeys(last);
    }

    public void setOwnershipSoSec(String sosec) {
        $("[name='_17_iboSSN_0']").sendKeys(sosec);
    }

    public void setOwnershipAddr1(String addr1){
        $("[name='_17_iboAddressLine1_0']").sendKeys(addr1);
    }

    public void setOwnershipDOB(String dob) {
        $("[name='_17_iboDOB_0']").type(dob);
    }

    public void setOwnershipHireDate(String hireDate) {
        $("[name='_17_iboHireDate_0']").type(hireDate);
    }

    public void setOwnershipCity(String city){
        $("[name='_17_iboCity_0']").sendKeys(city);
    }

    public void selectOwnershipState(String state){
        $("[name='_17_iboState_0']").selectByVisibleText(state);
    }

    public void setOwnershipZip(String zip) {
        $("[name='_17_iboZip_0']").sendKeys(zip);
    }

    public void selectOwnershipCounty(String county){
        $("[name='_17_iboOtherState_0']").selectByVisibleText(county);
    }

    public void clickDisclosure() {
        $("[name='_17_iboCounty_0']").click();
    }

    public void setControlOwnershipOtherLegalName(String legalName){
        $("[name='_17_iboOtherInterestInd_0']").sendKeys(legalName);
    }

    public void setControlOwnershipPctInterest(double pctInterest){
        $("[name='_17_iboOtherInterestName_0']").sendKeys(String.valueOf(pctInterest));
    }

    public void setControlOwnershipAddr1(String addr1) {
        $("[name='_17_iboOtherAddressLine2_0']").sendKeys(addr1);
    }

    public void setControlOwnershipCity(String city) {
        $("[name='_17_iboOtherZip_0']").sendKeys(city);
    }

    public void setControlOwnershipZip(String zip) {
        $("[name='_17_iboOtherZip']").sendKeys(zip);
    }

    public void selectControlOwnershipState(String state) {
        $("[name='_17_iboOtherState']").selectByVisibleText(state);
    }


    public void setNoToAllDisclosures() {
        String disclosureFields[] = {
                "_18_empCriminalConvictionInd",
                "_18_empCivilPenaltyInd",
                "_18_empPreviousExclusionInd",
                "_18_criminalConvictionInd",
                "_18_civilPenaltyInd",
                "_18_previousExclusionInd"
        };

        for(int i = 0; i < disclosureFields.length; i++){
            setNoForRadioButton(disclosureFields[i]);
        }

    }

    private void setNoForRadioButton(String name){
        List<WebElement> buttons = getDriver().findElements(By.cssSelector("[name='"+name+"']"));
        buttons.get(1).click();
    }
}
