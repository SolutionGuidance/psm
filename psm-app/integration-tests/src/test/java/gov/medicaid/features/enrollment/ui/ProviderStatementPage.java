package gov.medicaid.features.enrollment.ui;

import net.thucydides.core.pages.PageObject;

import java.time.LocalDate;

import static gov.medicaid.features.IntegrationTests.DATE_FORMATTER;

public class ProviderStatementPage extends PageObject {
    public void checkNoCriminalConviction() {
        $("[name=_08_criminalConvictionInd][value='N']").click();
    }

    public void checkNoCivilPenalty() {
        $("[name=_08_civilPenaltyInd][value='N']").click();
    }

    public void checkNoPreviousExclusion() {
        $("[name=_08_previousExclusionInd][value='N']").click();
    }

    public void checkYesCriminalConviction() {
        $("[name=_08_criminalConvictionInd][value='Y']").click();
    }

    public void checkYesCivilPenalty() {
        $("[name=_08_civilPenaltyInd][value='Y']").click();
    }

    public void checkYesPreviousExclusion() {
        $("[name=_08_previousExclusionInd][value='Y']").click();
    }

    public void enterProviderName(String providerName) {
        $("[name=_08_name]").type(providerName);
    }

    public void enterProviderTitle(String providerTitle) {
        $("[name=_08_title]").type(providerTitle);
    }

    public void enterValidDate() {
        String currentDate = LocalDate.now().format(DATE_FORMATTER);
        $("[name=_08_date]").type(currentDate);
    }

    public void clickSubmitButton() {
        $(".buttonBox > .purpleBtn").click();
    }
}
