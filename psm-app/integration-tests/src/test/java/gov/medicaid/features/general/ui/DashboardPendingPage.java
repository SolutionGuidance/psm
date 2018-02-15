package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

@DefaultUrl("http://localhost:8080/cms/provider/dashboard/pending")
public class DashboardPendingPage extends PsmPage {

    public void clickFilterButton() {
        click($(".filterBtn"));
    }
}
