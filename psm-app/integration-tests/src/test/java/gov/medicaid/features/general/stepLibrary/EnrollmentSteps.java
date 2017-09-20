package gov.medicaid.features.general.stepLibrary;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.steps.ScenarioSteps;

import static org.assertj.core.api.Assertions.assertThat;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.EnrollmentPage;


public class EnrollmentSteps extends ScenarioSteps {
    LoginPage homepage;
    EnrollmentPage loggedInPage;

    @Step
    public void login() {
        homepage.open();
        homepage.enterProviderCredentials();
    	homepage.login();
    	homepage.checkUserLoggedIn("p1");
    }
    @Step
    public void createEnrollment() {

        loggedInPage.createEnrollment();
    }
    @Step
    public void selectProviderType(String aProviderType) {

        loggedInPage.selectProviderType(aProviderType);
        loggedInPage.clickNext();
    }
    @Step
    public void checkPersonalInfo() {
        loggedInPage.checkPersonalInfo();
    }
}
