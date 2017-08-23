package gov.medicaid.features.enrollment.ui;


import net.serenitybdd.core.annotations.findby.By;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.WebElement;
import java.util.List;


public class EnrollmentPage extends PageObject {

    public void clickNext() {
        $("#nextBtn").click();
    }

    void setNoForRadioButton(String name) {
        List<WebElement> buttons = getDriver().findElements(By.cssSelector("[name='" + name + "']"));
        buttons.get(1).click();
    }
}
