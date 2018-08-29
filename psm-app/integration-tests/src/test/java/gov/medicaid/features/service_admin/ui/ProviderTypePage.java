package gov.medicaid.features.service_admin.ui;

import gov.medicaid.features.PsmPage;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class ProviderTypePage extends PsmPage {
    public void updateDescriptionInput(String desc) {
        $("#createEditProviderTypeProviderType").clear();
        $("#createEditProviderTypeProviderType").sendKeys(desc);
    }

    public void submitSave() {
        click$(".saveProviderTypeBtn");
    }

    public void assertViewing(String desc) {
        assertThat(getTitle()).contains("View Provider Type - Functions (Service Admin)");

        Optional<WebElement> descRow = getDriver().findElements(By.cssSelector(".wholeCol"))
            .stream()
            .filter(div ->
                div.findElements(By.cssSelector("label")).size() == 1 &&
                "Provider Type".equals(div.findElement(By.cssSelector("label")).getText()))
            .findFirst();

        assertThat(descRow.isPresent()).isTrue();
        assertThat(descRow.get().getText().contains(desc));
    }

    public void view(String desc) {
        getAndAssertProviderTypeRow(desc).findElement(By.cssSelector(".viewProviderLink")).click();
    }

    public void edit(String desc) {
        getAndAssertProviderTypeRow(desc).findElement(By.cssSelector(".editProviderLink")).click();
    }

    public void noProviderTypeInList(String desc) {
        assertThat(getProviderTypeRow(desc)).isEmpty();
    }

    public void delete(String desc) {
        getAndAssertProviderTypeRow(desc).findElement(By.cssSelector(".deleteProviderTypeBtn")).click();

        assertThat($("#deleteProviderTypesModal").isDisplayed()).isTrue();

        $("#deleteProviderTypesModal .saveBtn").click();
    }

    public void addAgreementsAndLicenses() {
        click$("#remaining_provider_agreement_1");
        click$("#remaining_provider_agreement_3");
        click$("#addProviderTypeLicense");
    }

    private WebElement getAndAssertProviderTypeRow(String desc) {
        Optional<WebElement> descRow = getProviderTypeRow(desc);
        assertThat(descRow.isPresent()).isTrue();
        return descRow.get();
    }

    private Optional<WebElement> getProviderTypeRow(String desc) {
        return getDriver().findElements(By.cssSelector("tr"))
            .stream()
            .filter(div ->
                div.findElements(By.cssSelector("td label")).size() > 0 &&
                desc.equals(div.findElement(By.cssSelector("td label")).getText()))
            .findFirst();
    }
}
