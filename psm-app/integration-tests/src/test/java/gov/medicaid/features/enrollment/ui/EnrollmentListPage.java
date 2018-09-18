package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.annotations.findby.By;

import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentListPage extends PsmPage {

    public void checkEnrollmentsInTable() {
        assertThat(
            getDriver()
            .findElements(By.cssSelector(".generalTable tr"))
            .size())
        .isGreaterThan(1);
    }

    public void filterByNpi(String npi) {
        // For providers
        if ($("#listByStatusNpi").isPresent()) {
            $("#listByStatusNpi").sendKeys(npi);
            $("#filterForm").submit();
        } else { // For admins
            $("#enrollmentSearchFilterNpiInput").sendKeys(npi);
            $("#showSearchEnrollmentsResultBtn").click();
        }
    }

    public void advanceToReview(String npi) {
        WebElement enrollmentRow = getTableRowForNpi(npi);
        assertThat(enrollmentRow).isNotNull();
        enrollmentRow.findElement(By.cssSelector(".reviewLink")).click();
    }

    public WebElement getTableRowForProviderType(String providerType) {
        WebElement td = $("//td[contains(text(),'" + providerType + "')]");
        WebElement row = td.findElement(By.xpath(".."));
        return row;
    }

    public WebElement getTableRowForNpi(String npi) {
        WebElement td = $("//td[contains(text(),'" + npi + "')]");
        WebElement row = td.findElement(By.xpath(".."));
        return row;
    }

    public void clickActionForNpi(String npi, String action) {
        Optional<WebElement> row = Optional.of(getTableRowForNpi(npi));

        assertThat(row).isPresent();
        assertThat(row.get().findElement(By.cssSelector(action)).isDisplayed()).isTrue();

        row.get().findElement(By.cssSelector(action)).click();
    }
}
