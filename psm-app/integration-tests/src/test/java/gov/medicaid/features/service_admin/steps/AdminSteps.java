package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;

import gov.medicaid.features.general.steps.GeneralSteps;
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

    @Step
    public void goToAdminAllEnrollmentsPage() {
        generalSteps.clickLinkAssertTitle(".enrollmentsLink", "All Enrollments");
    }

    @Step
    public void goToAdminDraftPage() {
        goToAdminAllEnrollmentsPage();
        generalSteps.clickLinkAssertTitle(".draftTab", "Draft Enrollments");
    }

    @Step
    public void goToAdminPendingPage() {
        goToAdminAllEnrollmentsPage();
        generalSteps.clickLinkAssertTitle(".pendingTab", "Pending Enrollments");
    }

    @Step
    public void goToAdminApprovedPage() {
        goToAdminAllEnrollmentsPage();
        generalSteps.clickLinkAssertTitle(".approvedTab", "Approved Enrollments");
    }

    @Step
    public void goToAdminDeniedPage() {
        goToAdminAllEnrollmentsPage();
        generalSteps.clickLinkAssertTitle(".deniedTab", "Denied Enrollments");
    }

    @Step
    public void openWriteNoteModal() {
        psmPage.click$(".writeNotes");
        assertThat(psmPage.$("#writeNotesModal h2").getText().contains("Write Notes"));
    }

    @Step
    public void advanceFromPendingPageToViewOrganizationInfoPage() {
        WebElement row = psmPage.getTableRowForProviderType("Head Start");
        WebElement viewLink = row.findElement(By.className("viewLink"));
        psmPage.click(viewLink);
        assertThat(psmPage.getTitle().contains("Organization Information"));
    }

    @Step
    public void checkOnPersonalInformationPage() {
        assertThat(organizationInfoPage.isPersonalEnrollment());
    }
}
