package gov.medicaid.features.enrollment.ui;

import net.thucydides.core.pages.PageObject;

import java.time.LocalDate;

import static gov.medicaid.features.IntegrationTests.click;
import static gov.medicaid.features.IntegrationTests.DATE_FORMATTER;

public class ProviderStatementPage extends PageObject {
    public void checkNoCriminalConviction() {
        click(this, $("[name=_08_criminalConvictionInd][value='N']"));
    }

    public void checkNoCivilPenalty() {
        click(this, $("[name=_08_civilPenaltyInd][value='N']"));
    }

    public void checkNoPreviousExclusion() {
        click(this, $("[name=_08_previousExclusionInd][value='N']"));
    }

    public void checkYesCriminalConviction() {
        click(this, $("[name=_08_criminalConvictionInd][value='Y']"));
    }

    public void checkYesCivilPenalty() {
        click(this, $("[name=_08_civilPenaltyInd][value='Y']"));
    }

    public void checkYesPreviousExclusion() {
        click(this, $("[name=_08_previousExclusionInd][value='Y']"));
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
        click(this, $(".buttonBox > .purpleBtn"));
    }
}
