package gov.medicaid.features.general.ui;


import net.thucydides.core.pages.PageObject;


public class EnrollmentPage extends PageObject {
    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

    public void setFEIN(String feinValue) {
        $("#fein").typeAndTab(feinValue);
    }


    public String getFEINValue() {
        return $("#fein").getValue();
    }
}
