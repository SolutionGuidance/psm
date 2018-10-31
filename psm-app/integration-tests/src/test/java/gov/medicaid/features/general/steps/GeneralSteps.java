/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.features.general.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.general.ui.AllApplicationsPage;
import gov.medicaid.features.general.ui.LoginPage;
import gov.medicaid.features.general.ui.MyProfilePage;
import gov.medicaid.features.general.ui.UpdatePasswordPage;
import net.thucydides.core.annotations.Step;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class GeneralSteps {

    private PsmPage psmPage;
    private LoginPage loginPage;
    private AllApplicationsPage allApplicationsPage;
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
    public void checkForFormError(String errorClass, String errorText) {
        psmPage.checkForFormError(errorClass, errorText);
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
    public void checkOnAllApplicationsPage() {
        allApplicationsPage.checkOnAllApplicationsPage();
    }

    @Step
    public void goToProviderDraftPage() {
        clickLinkAssertTitle(".draftTab", "Draft Applications");
    }

    @Step
    public void goToProviderPendingPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".pendingTab", "Pending Applications");
    }

    @Step
    public void goToProviderApprovedPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".approvedTab", "Approved Applications");
    }

    @Step
    public void goToProviderDeniedPage() {
        goToProviderDraftPage();
        clickLinkAssertTitle(".deniedTab", "Denied Applications");
    }

    @Step
    public void openFilterPanel() {
        if (allApplicationsPage.$(".filterBtn").getText().equals("Filter")) {
            allApplicationsPage.click$(".filterBtn");
        }
    }

    @Step
    public void clickMyProfile() {
        allApplicationsPage.clickMyProfile();
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
        allApplicationsPage.click$(".advancedSearchLink");
    }
}
