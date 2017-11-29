package gov.medicaid.features.enrollment.ui;

import net.serenitybdd.core.annotations.findby.By;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.WebElement;

import java.util.List;

import static gov.medicaid.features.IntegrationTests.click;

public class EnrollmentPage extends PageObject {
    public void clickNext() {
        click(this, $(".nextBtn"));
    }

    void setNoForRadioButton(String name) {
        List<WebElement> buttons = getDriver().findElements(By.cssSelector("[name='" + name + "']"));
        click(this, buttons.get(1));
    }
}
