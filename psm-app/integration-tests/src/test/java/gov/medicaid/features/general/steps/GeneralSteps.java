package gov.medicaid.features.general.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.general.ui.AllEnrollmentsPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import gov.medicaid.features.general.ui.UpdatePasswordPage;
import net.thucydides.core.annotations.Step;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class GeneralSteps {

    private PsmPage psmPage;
    private LoginPage loginPage;
    private AllEnrollmentsPage allEnrollmentsPage;
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
    public void checkOnAllEnrollmentsPage() {
        allEnrollmentsPage.checkOnAllEnrollmentsPage();
    }

    @Step
    public void goToProviderDraftPage() {
        clickLinkAssertTitle(".draftTab", "Draft Enrollments");
    }

    @Step
    public void goToProviderPendingPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".pendingTab", "Pending Enrollments");
    }

    @Step
    public void goToProviderApprovedPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".approvedTab", "Approved Enrollments");
    }

    @Step
    public void goToProviderDeniedPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".deniedTab", "Denied Enrollments");
    }

    @Step
    public void openFilterPanel() {
        if (allEnrollmentsPage.$(".filterBtn").getText().equals("Filter")) {
            allEnrollmentsPage.click$(".filterBtn");
        }
    }

    @Step
    public void clickMyProfile() {
        allEnrollmentsPage.clickMyProfile();
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
        allEnrollmentsPage.click$(".advancedSearchLink");
    }
}
