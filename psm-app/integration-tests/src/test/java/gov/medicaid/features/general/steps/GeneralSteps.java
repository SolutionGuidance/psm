package gov.medicaid.features.general.steps;

import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class GeneralSteps {
    
    private DashboardPage dashboardPage;
    private LoginPage loginPage;
    private MyProfilePage profilePage;

    @Step
    public void loginAsProvider() {
        loginPage.open();
        loginPage.enterProviderCredentials();
        loginPage.login();
        loginPage.checkUserLoggedIn("p1");
    }
    
    @Step
    public void checkOnDashboard() {
        dashboardPage.checkOnDashboard();
    }

    @Step
    public void clickMyProfile()  {
        dashboardPage.clickMyProfile();
    }

    @Step
    public void seeChangePassword()  {
        profilePage.checkChangePassword();
    }

}

