package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/admin/reports/draft-applications")
public class DraftApplicationsPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Draft Applications");
    }

    public void checkHasTableFor(String month) {
        boolean found = false;
        for (WebElementFacade wef : findAll("#wrapper .tableData .tableTitle h2")) {
            found = found || (wef.getText().equals(month));
        }
        assertThat(found).isTrue();
    }
}
