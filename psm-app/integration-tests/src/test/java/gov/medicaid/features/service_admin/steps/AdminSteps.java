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

package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.application.ui.ApplicationListPage;
import gov.medicaid.features.application.ui.OrganizationInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import gov.medicaid.features.service_admin.ui.ServiceAgentReviewScreeningPage;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.annotations.Steps;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class AdminSteps {

    @Steps
    GeneralSteps generalSteps;

    private PsmPage psmPage;
    private OrganizationInfoPage organizationInfoPage;
    private ApplicationListPage applicationListPage;
    private ServiceAgentReviewScreeningPage reviewScreeningPage;

    @Step
    public void goToAdminAllApplicationsPage() {
        generalSteps.clickLinkAssertTitle(".applicationsLink", "All Applications");
    }

    @Step
    public void goToAdminDraftPage() {
        goToAdminAllApplicationsPage();
        generalSteps.clickLinkAssertTitle(".draftTab", "Draft Applications");
    }

    @Step
    public void goToAdminPendingPage() {
        goToAdminAllApplicationsPage();
        generalSteps.clickLinkAssertTitle(".pendingTab", "Pending Applications");
    }

    @Step
    public void goToAdminApprovedPage() {
        goToAdminAllApplicationsPage();
        generalSteps.clickLinkAssertTitle(".approvedTab", "Approved Applications");
    }

    @Step
    public void goToAdminDeniedPage() {
        goToAdminAllApplicationsPage();
        generalSteps.clickLinkAssertTitle(".deniedTab", "Denied Applications");
    }

    @Step
    public void openWriteNoteModal() {
        psmPage.click$(".writeNotes");
        assertThat(psmPage.$("#writeNotesModal h2").getText().contains("Write Notes"));
    }

    @Step
    public void advanceFromPendingPageToViewOrganizationInfoPage() {
        WebElement row = applicationListPage.getTableRowForProviderType("Head Start");
        WebElement viewLink = row.findElement(By.className("viewLink"));
        psmPage.click(viewLink);
        assertThat(psmPage.getTitle().contains("Organization Information"));
    }

    @Step
    public void checkOnPersonalInformationPage() {
        assertThat(organizationInfoPage.isPersonalApplication());
    }

    @Step
    public void advanceFromPendingPageToReview(String npi) {
        applicationListPage.advanceToReview(npi);
    }

    @Step
    public void openDmfDetailsPage() {
        reviewScreeningPage.clickOnDmfDetails();
    }

    @Step
    public boolean npiRowExists(String npi) {
        return applicationListPage.getTableRowForNpi(npi) != null;
    }
}
