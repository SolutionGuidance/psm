package gov.medicaid.features.general.ui;

import net.thucydides.core.pages.PageObject;

import static gov.medicaid.features.IntegrationTests.click;
import static org.assertj.core.api.Assertions.assertThat;

public class DashboardPage extends PageObject {
    public void clickOnNewEnrollment() {
        click(this, $("#createNewEnrollment"));
        assertThat(getTitle()).isEqualTo("Provider Type Page");
    }

    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        click(this, $("#nextBtn"));
    }

}
