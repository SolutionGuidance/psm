package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.annotations.findby.By;

import org.openqa.selenium.WebElement;

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
        $("[name=_08_name], [name=_19_name]").type(providerName);
    }

    public void enterProviderTitle(String providerTitle) {
        $("[name=_08_title], [name=_19_title]").type(providerTitle);
    }

    public void acceptAllAgreements() {
        getDriver().findElements(By.cssSelector(".checkbox")).forEach(WebElement::click);
    }

    public void clickSubmitButton() {
        click($(".buttonBox > .purpleBtn"));
    }
}
