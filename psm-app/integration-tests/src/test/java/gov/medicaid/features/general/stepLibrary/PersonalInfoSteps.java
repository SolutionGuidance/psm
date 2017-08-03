package gov.medicaid.features.general.stepLibrary;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.steps.ScenarioSteps;

import static org.assertj.core.api.Assertions.assertThat;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.PersonalInfoPage;


public class PersonalInfoSteps extends ScenarioSteps {
    LoginPage homepage;
    EnrollmentPage loggedInPage;
    PersonalInfoPage personalInfoPage;

    @Step
    public void getToPersonalInfoPage(String aProviderType) {
        homepage.open();
        homepage.enterProviderCredentials();
	homepage.login();
	homepage.checkUserLoggedIn("p1");
        loggedInPage.createEnrollment();
        loggedInPage.selectProviderType(aProviderType);
        loggedInPage.clickNext();
        loggedInPage.checkPersonalInfo();
    }
    @Step
    public void enterFirstName(String firstName) {
        personalInfoPage.enterFirstName(firstName);
    }
    @Step
    public void enterMiddleName(String middleName) {
        personalInfoPage.enterMiddleName(middleName);
    }
    @Step
    public void enterLastName(String lastName) {
        personalInfoPage.enterLastName(lastName);
    }
    @Step
    public void enterNPI(String NPI) {
        personalInfoPage.enterNPI(NPI);
    }
    @Step
    public void enterSSN(String SSN) {
        personalInfoPage.enterSSN(SSN);
    }
    @Step
    public void enterDOB(String DOB) {
        personalInfoPage.enterDOB(DOB);
    }
    @Step
    public void enterEmail(String email) {
        personalInfoPage.enterEmail(email);
    }
    @Step
    public void checkSameAsAbove() {
        personalInfoPage.checkSameAsAbove();
    }
    @Step
    public void enterContactName(String contactName) {
        personalInfoPage.enterContactName(contactName);
    }
    @Step
    public void enterContactEmail(String contactEmail) {
        personalInfoPage.enterContactEmail(contactEmail);
    }
    @Step
    public void clickNext() {
        personalInfoPage.clickNext();
    }
    @Step
    public void clickPrevious() {
        personalInfoPage.clickPrevious();
    }
    @Step
    public void confirmNoErrors() {
        personalInfoPage.confirmNoErrors();
    }
    @Step
    public void checkForTooYoungError() throws Exception {
        personalInfoPage.checkForTooYoungError();
    }

}
