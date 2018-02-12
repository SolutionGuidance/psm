package gov.medicaid.features.general.steps;

import gov.medicaid.features.general.ui.DashboardApprovedPage;
import gov.medicaid.features.general.ui.DashboardDeniedPage;
import gov.medicaid.features.general.ui.DashboardDraftPage;
import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.DashboardPendingPage;
import net.thucydides.core.annotations.Step;

@SuppressWarnings("unused")
public class DashboardSteps {

    private DashboardPage dashboardPage;
    private DashboardDraftPage dashboardDraftPage;
    private DashboardPendingPage dashboardPendingPage;
    private DashboardApprovedPage dashboardApprovedPage;
    private DashboardDeniedPage dashboardDeniedPage;

    @Step
    public void checkOnDashboard() {
        dashboardPage.checkOnDashboard();
    }

    @Step
    public void clickDashboardPageFilterButton() {
        dashboardPage.clickFilterButton();
    }

    @Step
    public void clickMyProfile() {
        dashboardPage.clickMyProfile();
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
    public void openDashboardPendingPage() {
        dashboardPendingPage.open();
    }

    @Step
    public void clickDashboardPendingPageFilterButton() {
        dashboardPendingPage.clickFilterButton();
    }

    @Step
    public void openDashboardApprovedPage() {
        dashboardApprovedPage.open();
    }

    @Step
    public void clickDashboardApprovedPageFilterButton() {
        dashboardApprovedPage.clickFilterButton();
    }

    @Step
    public void openDashboardDeniedPage() {
        dashboardDeniedPage.open();
    }

    @Step
    public void clickDashboardDeniedPageFilterButton() {
        dashboardDeniedPage.clickFilterButton();
    }
}
