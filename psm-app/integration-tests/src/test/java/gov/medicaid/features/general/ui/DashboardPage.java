package gov.medicaid.features.general.ui;

import net.thucydides.core.pages.PageObject;

import static org.assertj.core.api.Assertions.assertThat;

public class DashboardPage extends PageObject {
    public void clickOnNewEnrollment() {
        $("#createNewEnrollment").click();
        assertThat(getTitle()).isEqualTo("Provider Type Page");
    }

    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

}
