package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

@DefaultUrl("http://localhost:8080/cms/provider/dashboard/rejected")
public class DashboardDeniedPage extends PsmPage {

    public void clickFilterButton() {
        click($(".filterBtn"));
    }
}
