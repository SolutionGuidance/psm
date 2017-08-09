package gov.medicaid.features.general.stepLibrary;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.steps.ScenarioSteps;

import static org.assertj.core.api.Assertions.assertThat;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.PersonalInfoPage;
import gov.medicaid.features.general.ui.LicenseInfoPage;
import java.util.Map;
import java.util.HashMap;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;



public class LicenseInfoSteps extends ScenarioSteps {
    LoginPage homepage;
    EnrollmentPage loggedInPage;
    PersonalInfoPage personalInfoPage;
    LicenseInfoPage licenseInfoPage;

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
    public void getToLicenseInfoPage(String aProviderType) throws Exception {
        Map<String,String> validInfo = getValidInformation();
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
    }
    @Step
    public void clickNo() {
        licenseInfoPage.clickNo();
    }
    @Step
    public void addLicense() {
        licenseInfoPage.addLicense();
    }
    @Step
    public void addLicenseType(String licenseType) {
        licenseInfoPage.addLicenseType(licenseType);
    }
    @Step
    public void uploadFile(String filepath) {
        licenseInfoPage.uploadFile(filepath);
    }
    @Step
    public void enterLicenseNumber(String licenseNumber) {
        licenseInfoPage.enterLicenseNumber(licenseNumber);
    }
    @Step
    public void enterIssueDate(String issueDate) {
        licenseInfoPage.enterIssueDate(issueDate);
    }
    @Step
    public void enterRenewalDate(String renewalDate) {
       licenseInfoPage.enterRenewalDate(renewalDate);
    }
    @Step
    public void enterIssueState(String issueState) {
        licenseInfoPage.enterIssueState(issueState);
    }
    @Step
    public void clickNext() {
        licenseInfoPage.clickNext();
    }
}
