package gov.medicaid.features.general.steps;

import gov.medicaid.features.general.ui.AccountSetupPage;
import gov.medicaid.features.general.ui.DashboardDraftPage;
import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.ForgotPasswordPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import gov.medicaid.features.general.ui.RegisterNewAccountPage;
import gov.medicaid.features.general.ui.UpdatePasswordPage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class GeneralSteps {

    private LoginPage loginPage;
    private RegisterNewAccountPage registerNewAccountPage;
    private ForgotPasswordPage forgotPasswordPage;
    private DashboardPage dashboardPage;
    private DashboardDraftPage dashboardDraftPage;
    private MyProfilePage profilePage;
    private AccountSetupPage accountSetupPage;
    private UpdatePasswordPage updatePasswordPage;

    @Step
    public void openRegisterNewAccountPage() {
        registerNewAccountPage.open();
    }

    @Step
    public void openForgotPasswordPage() {
        forgotPasswordPage.open();
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
    public void openDashboardDraftPage() {
        dashboardDraftPage.open();
    }

    @Step
    public void clickDashboardDraftPageFilterButton() {
        dashboardDraftPage.clickFilterButton();
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

    @Step
    public void openAccountSetupPage() {
        accountSetupPage.open();
    }
}
