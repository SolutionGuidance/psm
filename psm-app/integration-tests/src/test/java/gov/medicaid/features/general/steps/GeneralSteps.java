package gov.medicaid.features.general.steps;

import gov.medicaid.features.general.ui.LoginPage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class GeneralSteps {
    
    private LoginPage loginPage;

    @Step
    public void loginAsProvider() {
        loginPage.open();
        loginPage.enterProviderCredentials();
        loginPage.login();
        loginPage.checkUserLoggedIn("p1");
    }

}

