package gov.medicaid.features.general.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import gov.medicaid.features.general.ui.UpdatePasswordPage;
import net.thucydides.core.annotations.Step;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class GeneralSteps {

    private PsmPage psmPage;
    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    private MyProfilePage profilePage;
    private UpdatePasswordPage updatePasswordPage;

    @Step
    public void clickLinkAssertTitle(String selector, String title) {
        psmPage.click$(selector);
        assertThat(psmPage.getTitle()).contains(title);
    }

    @Step
    public void hasNoServerError() {
        psmPage.hasNoServerError();
    }

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
    public void login(String username, String password) {
        loginPage.open();
        loginPage.enterCredentials(username, password);
        loginPage.login();
        loginPage.checkUserLoggedIn(username);
    }

    @Step
    public void checkOnDashboard() {
        dashboardPage.checkOnDashboard();
    }

    @Step
    public void navigateToDraftPage() {
        clickLinkAssertTitle(".enrollmentsLink", "Draft Enrollments");
    }

    @Step
    public void navigateToPendingPage() {
        navigateToDraftPage();
        clickLinkAssertTitle(".pendingTab", "Pending Enrollments");
    }

    @Step
    public void navigateToApprovedPage() {
        navigateToDraftPage();
        clickLinkAssertTitle(".approvedTab", "Approved Enrollments");
    }

    @Step
    public void navigateToDeniedPage() {
        navigateToDraftPage();
        clickLinkAssertTitle(".deniedTab", "Denied Enrollments");
    }

    @Step
    public void navigateToNotesPage() {
        navigateToDraftPage();
        clickLinkAssertTitle(".notesTab", "Notes");
    }

    @Step
    public void openFilterPanel() {
        if (dashboardPage.$(".filterBtn").getText().equals("Filter")) {
            dashboardPage.click$(".filterBtn");
        }
    }

    @Step
    public void clickMyProfile() {
        dashboardPage.clickMyProfile();
    }

    @Step
    public void seeChangePassword() {
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
    public void navigateToUpdatePasswordPage() {
        clickMyProfile();
        profilePage.click$("#change_password_link");
    }

    @Step
    public void navigateToAccountSetupPage() {
        clickMyProfile();
        profilePage.click$(".accountSetupLink");
    }

    @Step
    public void navigateToAdvancedSearchPage() {
        dashboardPage.click$(".advancedSearchLink");
    }
}
