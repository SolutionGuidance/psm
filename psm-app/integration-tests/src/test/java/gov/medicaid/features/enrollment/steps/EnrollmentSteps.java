package gov.medicaid.features.enrollment.steps;

import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.enrollment.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.LoginPage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class EnrollmentSteps {
    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    private EnrollmentPage enrollmentPage;

    @Step
    public void loginAsProvider(){
        loginPage.open();
        loginPage.enterProviderCredentials();
        loginPage.login();
        loginPage.checkUserLoggedIn("p1");
    }

    public void createEnrollment() {
        dashboardPage.clickOnNewEnrollment();
    }

    public void selectOrganizationalProviderType() {
        enrollmentPage.selectProviderType("Dental Clinic");
        enrollmentPage.clickNext();
    }

    public void selectIndividualProviderType() {
        enrollmentPage.selectProviderType("Podiatrist");
        enrollmentPage.clickNext();
    }
}
