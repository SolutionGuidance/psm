package gov.medicaid.features.general.stepLibrary;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.steps.ScenarioSteps;

import static org.assertj.core.api.Assertions.assertThat;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.PersonalInfoPage;
import gov.medicaid.features.general.ui.PracticeInfoPage;
import gov.medicaid.features.general.ui.LicenseInfoPage;
import gov.medicaid.features.general.ui.SubmitPage;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class SubmitSteps extends ScenarioSteps {


    LoginPage homepage;
    EnrollmentPage loggedInPage;
    PersonalInfoPage personalInfoPage;
    LicenseInfoPage licenseInfoPage;
    PracticeInfoSteps practiceInfoSteps;
    PracticeInfoPage practiceInfoPage;
    SubmitPage submitPage;

    public Map<String, String> getValidInformation() throws Exception {
        Map<String, String> validInfo = new HashMap<String, String>();
        BufferedReader in = new BufferedReader(new FileReader("src/test/resources/files/valid_information.txt"));
        String line = "";
        while((line = in.readLine()) != null) {
            String[] parts = line.split(",");
            validInfo.put(parts[0].replaceAll("\\s+",""), parts[1].replaceAll("\\s+",""));
        }
        in.close();
        return validInfo;
    }

    @Step
    //Definitely repeating myself...not sure how to fix
    public void getToSubmitPage(String aProviderType, String licenseType) throws Exception {
        Map<String,String> validInfo = getValidInformation();
        homepage.open();
        homepage.open();
        homepage.enterProviderCredentials();
    	homepage.login();
    	homepage.checkUserLoggedIn("p1");
        loggedInPage.createEnrollment();
        loggedInPage.selectProviderType(aProviderType);
        loggedInPage.clickNext();
        loggedInPage.checkPersonalInfo();
        personalInfoPage.enterFirstName(validInfo.get("firstname"));
        personalInfoPage.enterLastName(validInfo.get("lastname"));
        personalInfoPage.enterNPI(validInfo.get("NPI"));
        personalInfoPage.enterSSN(validInfo.get("SSN"));
        personalInfoPage.enterDOB(validInfo.get("DOB"));
        personalInfoPage.enterEmail(validInfo.get("email"));
        personalInfoPage.checkSameAsAbove();
        personalInfoPage.clickNext();
        licenseInfoPage.clickNo();
        licenseInfoPage.addLicense();
        licenseInfoPage.addLicenseType(licenseType);
        licenseInfoPage.uploadFile(validInfo.get("license"));
        licenseInfoPage.enterLicenseNumber(validInfo.get("licenseNumber"));
        licenseInfoPage.enterIssueDate(validInfo.get("issueDate"));
        licenseInfoPage.enterRenewalDate(validInfo.get("renewalDate"));
        licenseInfoPage.enterIssueState(validInfo.get("issueState"));
        licenseInfoPage.clickNext();
        practiceInfoPage.checkYesPrivatePractice();
        practiceInfoPage.checkNoGroupPractice();
        practiceInfoPage.enterPracticeName(validInfo.get("practiceName"));
        practiceInfoPage.enterEffectiveDate(validInfo.get("effectiveDate"));
        practiceInfoPage.enterPracticeAddress(validInfo.get("practiceAddress"));
        practiceInfoPage.enterCity(validInfo.get("city"));
        practiceInfoPage.enterState(validInfo.get("state"));
        practiceInfoPage.enterZipCode(validInfo.get("zipCode"));
        practiceInfoPage.enterPhoneNumber(validInfo.get("phoneNumber"));
        practiceInfoPage.clickSameAsAbove();
        practiceInfoPage.enterFiscalYear(validInfo.get("fiscalYear"));
        practiceInfoPage.checkFirstRemittanceSequence();
        practiceInfoPage.clickNext();
        practiceInfoPage.clickNext();
    }
    @Step
    public void checkNoCriminalConviction() {
        submitPage.checkNoCriminalConviction();
    }
    @Step
    public void checkNoCivilPenalty() {
        submitPage.checkNoCivilPenalty();
    }
    @Step
    public void checkNoPreviousExclusion() {
        submitPage.checkNoPreviousExclusion();
    }
    @Step
    public void enterProviderName(String providerName) {
        submitPage.enterProviderName(providerName);
    }
    @Step
    public void enterProviderTitle(String providerTitle) {
        submitPage.enterProviderTitle(providerTitle);
    }
    @Step
    public void clickReadAgreement() {
        submitPage.clickReadAgreement();
    }
    @Step
    public void enterValidDate() {
        submitPage.enterValidDate();
    }
    @Step
    public void clickSubmitButton() {
        submitPage.clickSubmitButton();
    }
    @Step
    public void closePopup() {
        submitPage.closePopup();
    }
    public void checkEnrollmentPage() {
        submitPage.checkEnrollmentPage();
    }
}
