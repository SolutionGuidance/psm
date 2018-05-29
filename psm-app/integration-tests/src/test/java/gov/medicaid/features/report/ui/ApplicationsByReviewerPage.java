package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;

import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

@DefaultUrl("http://localhost:8080/cms/admin/reports/applications-by-reviewer")
public class ApplicationsByReviewerPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Applications by Reviewer");
    }

    public void clickViewReportButton() {
        click($(".viewApplicationsByReviewerButton"));
    }

    public void clearDates() {
        $("#startDate").clear();
        $("#endDate").clear();
    }

    public void submitSearch(String d1, String d2) {
        clearDates();
        $("#startDate").sendKeys(d1);
        $("#endDate").sendKeys(d2);
        clickViewReportButton();
    }

    public void checkHasResults() {
        assertThat($("#wrapper").containsElements(".tableData")).isTrue();
    }

    public void checkHasNoResults() {
        assertThat($("#wrapper .noResults").getText()).contains("No results found");
    }

    public void clickOnEnrollment(int enrollmentId) {
        Optional<WebElement> link =
            getDriver().findElements(By.cssSelector("#wrapper .tableData .generalTable tr td a")).stream()
                .filter(a -> a.getText().equals("" + enrollmentId))
            .findFirst();

        assertThat(link.isPresent()).isTrue();
        link.get().click();
    }
}
