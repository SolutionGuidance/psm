package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ProviderTypesPage;

import net.thucydides.core.annotations.Step;

public class ProviderTypesReportSteps {
    private ProviderTypesPage providerTypesPage;

    @Step
    public void checkProviderTypesPageHasEnrollmentsForMonth(
        int numEnrollments,
        String providerTypeDesc,
        String month
    ) {
        providerTypesPage.checkEnrollmentsForMonth(numEnrollments, providerTypeDesc, month);
    }

    @Step
    public void checkProviderTypesPageHasNoResultsForMonth(String month) {
        providerTypesPage.checkHasNoResultsForMonth(month);
    }

    @Step
    public void selectProviderTypeOption(String providerTypeDesc) {
        providerTypesPage.selectProviderType(providerTypeDesc);
    }

    @Step
    public void filterProviderTypes() {
        providerTypesPage.click$(".viewProviderTypesButton");
    }

    @Step
    public void checkProviderTypeSelected(String providerTypeDesc) {
        providerTypesPage.checkProviderTypeSelected(providerTypeDesc);
    }

    @Step
    public void checkOnProviderTypesPage() {
        providerTypesPage.checkOnPage();
    }

    @Step
    public void downloadProviderTypesReportCsv() {
        providerTypesPage.click$(".downloadProviderTypes");
    }
}
