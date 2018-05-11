package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;

import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/admin/reports/applications-by-reviewer")
public class ApplicationsByReviewerPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Applications by Reviewer");
    }

    public void clickViewReportButton() {
        click($(".viewApplicationsByReviewerButton"));
    }

    public void submitSearch(String d1, String d2) {
        evaluateJavascript("$('#startDate').val('" + d1 + "')");
        evaluateJavascript("$('#endDate').val('" + d2 + "')");
        clickViewReportButton();
    }

    public void checkHasResults() {
        assertThat($("#wrapper").containsElements(".tableData")).isTrue();
    }

    public void checkHasNoResults() {
        assertThat($("#wrapper .noResults").getText()).contains("No results found");
    }
}
