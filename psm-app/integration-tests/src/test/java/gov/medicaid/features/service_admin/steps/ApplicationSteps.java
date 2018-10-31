package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.application.ui.ApplicationListPage;
import gov.medicaid.features.application.ui.ViewApplicationPage;
import gov.medicaid.features.service_admin.ui.ApplicationReviewPage;

import net.thucydides.core.annotations.Step;

import static net.thucydides.core.pages.PageObject.withParameters;

import static org.assertj.core.api.Assertions.assertThat;

public class ApplicationSteps {
    ApplicationListPage applicationListPage;

    ApplicationReviewPage applicationReviewPage;

    ViewApplicationPage viewApplicationPage;

    String approvedApplicationId = null;

    @Step
    public void navigateToReviewPageFor(String npi) {
        applicationListPage.clickActionForNpi(npi, ".reviewLink");
    }

    @Step
    public void approveApplication() {
        approvedApplicationId = applicationReviewPage.getApplicationId();
        applicationReviewPage.approve();
    }

    @Step
    public void rejectApplication() {
        approvedApplicationId = applicationReviewPage.getApplicationId();
        applicationReviewPage.reject();
    }

    @Step
    public void navigateToMostRecentApplication() {
        assertThat(approvedApplicationId).isNotNull();
        viewApplicationPage.open("view.application", withParameters(approvedApplicationId));
    }

    @Step
    public void verifyState(String state) {
        viewApplicationPage.verifyState(state);
    }
}
