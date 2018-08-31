package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;

import net.thucydides.core.annotations.DefaultUrl;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/admin/reports/time-to-review")
public class TimeToReviewPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Time to Review");
    }

    private Optional<WebElement> findRowForMonth(String month) {
        return getDriver().findElements(By.cssSelector("#wrapper .tableData .generalTable tr")).stream()
            .filter(tr ->
                tr.findElements(By.cssSelector("td")).size() > 0 &&
                tr.findElements(By.cssSelector("td")).get(0).getText().equals(month))
            .findFirst();
    }

    public void checkHasRowFor(String month) {
        assertThat(findRowForMonth(month).isPresent()).isTrue();
    }

    public void checkRowHasNumber(String month, String number) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(1).getText().equals(number)
        ).isTrue();
    }

    public void checkRowHasMean(String month, String mean) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(2).getText().equals(mean)
        ).isTrue();
    }

    public void checkRowHasMedian(String month, String median) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(3).getText().equals(median)
        ).isTrue();
    }
}
