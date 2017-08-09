package gov.medicaid.features.general.ui;

import com.google.common.base.Function;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import static org.assertj.core.api.Assertions.assertThat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.concurrent.TimeUnit;

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

    public void enterEffectiveDate(String effectiveDate) {
        $("[name=_05_effectiveDate]").type(effectiveDate);
    }

    public void enterPracticeAddress(String practiceAddress) {
        $("[name=_05_addressLine1]").type(practiceAddress);
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
        String middleThird = phoneNumberParts[1];
        String lastFourDigits = phoneNumberParts[2];
        $("[name=_05_phone1]").type(areaCode);
        $("[name=_05_phone2]").type(middleThird);
        $("[name=_05_phone3]").type(lastFourDigits);
    }

    public void clickSameAsAbove() {
        $("[name=_05_billingSameAsPrimary]").click();
    }

    public void enterFiscalYear(String year) {
        String[] yearParts = year.split("/");
        String month = yearParts[0];
        String day = yearParts[1];
        $("[name=_05_fye1]").type(month);
        $("[name=_05_fye2]").type(day);
    }

    public void checkFirstRemittanceSequence() {
        $("input[value='PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER'").click();
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

    public void checkSummaryPage() {
        //check that we're on the right page
        assertThat(getTitle().contains("Summary Information"));
        //check that the print button is working
        assertThat($(".printModalBtn").getText().contains("Print"));
    }
    public Map<String, String> getSummaryValues() {
        Map<String, String> summaryValues = new HashMap<String, String>();
//          //first name
        summaryValues.put($(".leftCol > div:nth-child(1) > label").getText(), $(".leftCol > div:nth-child(1) > span:nth-child(3)").getText());
//        //last name
        summaryValues.put($(".leftCol > div:nth-child(3) > label").getText(), $(".leftCol > div:nth-child(3) > span:nth-child(3)").getText());
//        //NPI
        summaryValues.put($(".leftCol > div:nth-child(4) > label").getText(), $(".leftCol > div:nth-child(4) > span:nth-child(3)").getText());
//        //SSN
        summaryValues.put($(".leftCol > div:nth-child(5) > label").getText(), $(".leftCol > div:nth-child(5) > span:nth-child(3)").getText());
//        //DOB
        summaryValues.put($(".leftCol > div:nth-child(6) > label").getText(), $(".leftCol > div:nth-child(6) > span:nth-child(3)").getText());
//        //Email
        summaryValues.put($(".rightCol > div:nth-child(1) > label").getText(), $(".rightCol > div:nth-child(1) > span:nth-child(3)").getText());
//        //Type of License
        summaryValues.put($(".generalTable > thead > tr > th:nth-child(2)").getText(), $(".generalTable > tbody > tr > td:nth-child(2)").getText());
//        //License Number
        summaryValues.put($(".generalTable > thead > tr > th:nth-child(3)").getText(), $(".generalTable > tbody > tr > td:nth-child(3)").getText());
//        //Original Issue Date
        summaryValues.put($(".generalTable > thead > tr > th:nth-child(4)").getText(), $(".generalTable > tbody > tr > td:nth-child(4)").getText());
//        //Renewal End Date
        summaryValues.put($(".generalTable > thead > tr > th:nth-child(5)").getText(), $(".generalTable > tbody > tr > td:nth-child(5)").getText());
//        //Issuing State
        summaryValues.put($(".generalTable > thead > tr > th:nth-child(6)").getText(), $(".generalTable > tbody > tr > td:nth-child(6)").getText());

        //private practice
        summaryValues.put($(".personalPanel > div:nth-child(13) > .wholeCol > div:nth-child(1) > label").getText(), $(".personalPanel > div:nth-child(13) > .wholeCol > div:nth-child(1) > span:nth-child(3)").getText());
        //independently contracted
        summaryValues.put($(".wholeCol > div:nth-child(2) > label").getText(), $(".wholeCol > div:nth-child(2) > span:nth-child(3)").getText());
//        //practice name
        summaryValues.put($(".wholeCol > div:nth-child(3) > label").getText(), $(".wholeCol > div:nth-child(3) > span:nth-child(3)").getText());
//        //effective date
        summaryValues.put($(".wholeCol > div:nth-child(4) > label").getText(), $(".wholeCol > div:nth-child(4) > span:nth-child(3)").getText());
//        //practice address
        summaryValues.put($(".wholeCol > div:nth-child(6) > label").getText(), $(".wholeCol > div:nth-child(6) > span:nth-child(3)").getText().replaceAll("\\s+",""));
//        //practice phone
        summaryValues.put($(".wholeCol > div:nth-child(7) > label").getText(), $(".wholeCol > div:nth-child(7) > span:nth-child(3)").getText().replaceAll("\\s+",""));
        //fiscal year end
        summaryValues.put($(".wholeCol > div:nth-child(12) > label").getText(), $(".wholeCol > div:nth-child(12) > span:nth-child(3)").getText().replaceAll("\\s+",""));

        return summaryValues;
    }
}
