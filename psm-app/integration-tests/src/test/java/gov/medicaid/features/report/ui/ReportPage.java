package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/admin/report")
public class ReportPage extends PsmPage {
    public void checkOnReportPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Reports");
    }
}
