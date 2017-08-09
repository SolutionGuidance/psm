package gov.medicaid.features.general.stepLibrary;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.steps.ScenarioSteps;

import static org.assertj.core.api.Assertions.assertThat;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.PersonalInfoPage;
import gov.medicaid.features.general.ui.PracticeInfoPage;
import gov.medicaid.features.general.ui.LicenseInfoPage;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;


public class PracticeInfoSteps extends ScenarioSteps {
    LoginPage homepage;
    EnrollmentPage loggedInPage;
    PersonalInfoPage personalInfoPage;
    LicenseInfoPage licenseInfoPage;
    PracticeInfoPage practiceInfoPage;

    Map <String, String> enteredInfo = new HashMap<String, String>();
    StringBuilder wholeAddress = new StringBuilder();

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
    public void getToPracticeInfoPage(String aProviderType, String licenseType) throws Exception {
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
        enteredInfo.put("First Name", validInfo.get("firstname"));
        personalInfoPage.enterLastName(validInfo.get("lastname"));
        enteredInfo.put("Last Name", validInfo.get("lastname"));
        personalInfoPage.enterNPI(validInfo.get("NPI"));
        enteredInfo.put("NPI", validInfo.get("NPI"));
        personalInfoPage.enterSSN(validInfo.get("SSN"));
        enteredInfo.put("Social Security Number", validInfo.get("SSN"));
        personalInfoPage.enterDOB(validInfo.get("DOB"));
        enteredInfo.put("Date of Birth", validInfo.get("DOB"));
        personalInfoPage.enterEmail(validInfo.get("email"));
        enteredInfo.put("Email Address", validInfo.get("email"));
        personalInfoPage.checkSameAsAbove();
        personalInfoPage.clickNext();
        licenseInfoPage.clickNo();
        licenseInfoPage.addLicense();
        licenseInfoPage.addLicenseType(licenseType);
        enteredInfo.put("Type of License/Certification", licenseType);
        licenseInfoPage.uploadFile(validInfo.get("license"));
        licenseInfoPage.enterLicenseNumber(validInfo.get("licenseNumber"));
        enteredInfo.put("License/Certification #", validInfo.get("licenseNumber"));
        licenseInfoPage.enterIssueDate(validInfo.get("issueDate"));
        enteredInfo.put("Original Issue Date", validInfo.get("issueDate"));
        licenseInfoPage.enterRenewalDate(validInfo.get("renewalDate"));
        enteredInfo.put("Renewal End Date", validInfo.get("renewalDate"));
        licenseInfoPage.enterIssueState(validInfo.get("issueState"));
        enteredInfo.put("Issuing State", validInfo.get("stateAbbreviation"));
        licenseInfoPage.clickNext();
    }
    @Step
    public void checkNoPrivatePractice() {

        practiceInfoPage.checkNoPrivatePractice();
        enteredInfo.put("Do you maintain your own private practice?", "No");
    }
    @Step
    public void checkNoGroupPractice() {
        practiceInfoPage.checkNoGroupPractice();
        enteredInfo.put("Are you employed and/or independently contracted by a group practice?", "No");
    }
    @Step
    public void checkYesPrivatePractice() {

        practiceInfoPage.checkYesPrivatePractice();
        enteredInfo.put("Do you maintain your own private practice?", "Yes");

    }
    @Step
    public void checkYesGroupPractice() {

        practiceInfoPage.checkYesGroupPractice();
        enteredInfo.put("Are you employed and/or independently contracted by a group practice?", "Yes");

    }
    @Step
    public void enterPracticeName(String practiceName) {

        practiceInfoPage.enterPracticeName(practiceName);
        enteredInfo.put("Private Practice Name", practiceName);
    }
    @Step
    public void enterEffectiveDate(String effectiveDate) {

        practiceInfoPage.enterEffectiveDate(effectiveDate);
        enteredInfo.put("Effective Date", effectiveDate);
    }
    @Step
    public void enterPracticeAddress(String practiceAddress) {

        practiceInfoPage.enterPracticeAddress(practiceAddress);
        wholeAddress.append(practiceAddress);
    }
    @Step
    public void enterCity(String city) {

        practiceInfoPage.enterCity(city);
        wholeAddress.append(city + ",");
    }
    @Step
    public void enterState(String state) {

        practiceInfoPage.enterState(state);
        //TODO Write a map mapping each State to its Abbreviation
        //Used because the summary page table displays an abbreviation, but user inputs a state's full name
        if (state.equals("Virginia")) {
            state = "VA";
        }
        wholeAddress.append(state + ",");
    }
    @Step
    public void enterZipCode(String zipCode) {

        practiceInfoPage.enterZipCode(zipCode);
        wholeAddress.append(zipCode);
        String address = wholeAddress.toString();
        address = address.replaceAll("\\s+","");
        enteredInfo.put("Practice Address", address);
    }
    @Step
    public void enterPhoneNumber(String phoneNumber) {

        practiceInfoPage.enterPhoneNumber(phoneNumber);
        enteredInfo.put("Practice Phone Number", phoneNumber);
    }
    @Step
    public void clickSameAsAbove() {
        practiceInfoPage.clickSameAsAbove();
    }
    @Step
    public void enterFiscalYear(String year) {
        practiceInfoPage.enterFiscalYear(year);
        enteredInfo.put("Fiscal Year End", year);
    }
    @Step
    public void checkFirstRemittanceSequence() {

        practiceInfoPage.checkFirstRemittanceSequence();
    }
    @Step
    public void clickNext() {
        practiceInfoPage.clickNext();
    }
    @Step
    public void checkSummaryPage() {
        practiceInfoPage.checkSummaryPage();
        Map<String,String> summaryValues = practiceInfoPage.getSummaryValues();
        assertThat(summaryValues.entrySet().equals(enteredInfo.entrySet()));
    }
}
