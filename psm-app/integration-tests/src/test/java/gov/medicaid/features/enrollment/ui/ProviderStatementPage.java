package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import java.time.LocalDate;

public class ProviderStatementPage extends PsmPage {
    public void checkNoCriminalConviction() {
        click($("[name=_08_criminalConvictionInd][value='N']"));
    }

    public void checkNoCivilPenalty() {
        click($("[name=_08_civilPenaltyInd][value='N']"));
    }

    public void checkNoPreviousExclusion() {
        click($("[name=_08_previousExclusionInd][value='N']"));
    }

    public void checkYesCriminalConviction() {
        click($("[name=_08_criminalConvictionInd][value='Y']"));
    }

    public void checkYesCivilPenalty() {
        click($("[name=_08_civilPenaltyInd][value='Y']"));
    }

    public void checkYesPreviousExclusion() {
        click($("[name=_08_previousExclusionInd][value='Y']"));
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
        click($(".buttonBox > .purpleBtn"));
    }
}
