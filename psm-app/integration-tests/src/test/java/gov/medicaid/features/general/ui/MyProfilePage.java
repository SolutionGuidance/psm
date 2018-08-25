package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.annotations.findby.By;

import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class MyProfilePage extends PsmPage {

    public void checkChangePassword() {
        String changeLinkText = $("#change_password_link").getText();
        assertThat(changeLinkText).contains("Change Password");
    }

    public void clickChangePassword() {
        click($("#change_password_link"));
    }

    public void clickActionFor(String npi, String action) {
        Optional<WebElement> row =
            getDriver()
                .findElements(By.cssSelector(".generalTable tr"))
                .stream()
                .filter(tr ->
                    tr.findElements(By.cssSelector("td")).size() > 0 &&
                    tr.findElements(By.cssSelector("td")).get(0).getText().equals(npi))
                .findFirst();

        assertThat(row).isPresent();
        assertThat(row.get().findElement(By.cssSelector(action)).isDisplayed()).isTrue();

        row.get().findElement(By.cssSelector(action)).click();
    }
}
