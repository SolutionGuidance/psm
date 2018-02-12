package gov.medicaid.features.general.steps;

import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import gov.medicaid.features.general.ui.UpdatePasswordPage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class GeneralSteps {

    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    private MyProfilePage profilePage;
    private UpdatePasswordPage updatePasswordPage;

    @Step
    public void navigateToRegisterNewAccountPage() {
        loginPage.open();
        loginPage.click$(".registerNewAccountLink");
    }

    @Step
    public void navigateToForgotPasswordPage() {
        loginPage.open();
        loginPage.click$(".forgotPasswordLink");
    }

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

    @Step
    public void clickChangePassword() {
        profilePage.clickChangePassword();
    }

    @Step
    public void seeUpdatePassword() {
        updatePasswordPage.checkUpdatePassword();
    }

    @Step
    public void openUpdatePasswordPage() {
        updatePasswordPage.open();
    }
}
