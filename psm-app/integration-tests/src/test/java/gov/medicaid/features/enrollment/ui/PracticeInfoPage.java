package gov.medicaid.features.enrollment.ui;

import net.thucydides.core.pages.PageObject;

import java.time.LocalDate;

import static gov.medicaid.features.IntegrationTests.format;
import static org.assertj.core.api.Assertions.assertThat;

public class PracticeInfoPage extends PageObject {
    public void checkNoPrivatePractice() {
        $("[name=_04_maintainsOwnPrivatePractice][value=N]").click();
        assertThat($("#privatePracitce > div").getText().contains("Private Practice"));
    }

    public void checkYesPrivatePractice() {
        $("[name=_04_maintainsOwnPrivatePractice][value=Y]").click();
    }

    public void checkNoGroupPractice() {
        $("[name=_04_employedOrContractedByGroup][value=N]").click();
    }

    public void checkYesGroupPractice() {
        $("[name=_04_employedOrContractedByGroup][value=Y]").click();
    }

    public void enterPracticeName(String practiceName) {
        $("[name=_05_name]").type(practiceName);
    }

    public void enterGroupNPI(String npi) {
        $("[name=_05_npi]").type(npi);
    }

    public void enterEffectiveDate(LocalDate effectiveDate) {
        $("[name=_05_effectiveDate]").type(
                format(effectiveDate)
        );
    }

    public void enterPracticeAddress1(String practiceAddress) {
        $("[name=_05_addressLine1]").type(practiceAddress);
    }

    public void enterPracticeAddress2(String practiceAddress) {
        $("[name=_05_addressLine2]").type(practiceAddress);
    }

    public void enterCity(String city) {
        $("[name=_05_city]").type(city);
    }

    public void enterState(String state) {
        $("[name=_05_state]").selectByVisibleText(state);
    }

    public void enterZipCode(String zipCode) {
        $("[name=_05_zip]").type(zipCode);
    }

    public void enterPhoneNumber(String phoneNumber) {
        String[] phoneNumberParts = phoneNumber.split("-");
        String areaCode = phoneNumberParts[0];
        String exchangeCode = phoneNumberParts[1];
        String subscriberNumber = phoneNumberParts[2];
        $("[name=_05_phone1]").type(areaCode);
        $("[name=_05_phone2]").type(exchangeCode);
        $("[name=_05_phone3]").type(subscriberNumber);
    }

    public void clickSameAsAbove() {
        $("[name=_05_billingSameAsPrimary]").click();
    }

    public void enterFein(String fein) {
        $("[name=_05_fein]").type(fein);
    }

    public void enterStateTaxId(String stateTaxId) {
        $("[name=_05_stateTaxId]").type(stateTaxId);
    }

    public void enterFiscalYearEnd(String yearEnd) {
        String[] yearEndParts = yearEnd.split("/");
        String month = yearEndParts[0];
        String day = yearEndParts[1];
        $("[name=_05_fye1]").type(month);
        $("[name=_05_fye2]").type(day);
    }

    public void enterEftVendorNumber(String eftVendorNumber) {
        $("[name=_05_eftVendorNo]").type(eftVendorNumber);
    }

    public void checkFirstRemittanceSequence() {
        $("input[value='PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER'").click();
    }

    public void clickNext() {
        $("#nextBtn").click();
    }
}
