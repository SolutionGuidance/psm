package gov.medicaid.features.general.ui;


import net.thucydides.core.pages.PageObject;

import static org.assertj.core.api.Assertions.assertThat;

public class DashboardPage extends PageObject {
    public void clickOnNewEnrollment() {
        $("#mainContent > div > div.tabContent.contentT > div.tableHeader.tableHeader2 > a").click();
        assertThat(getTitle().equals("Provider Type Page"));
    }

    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

}
