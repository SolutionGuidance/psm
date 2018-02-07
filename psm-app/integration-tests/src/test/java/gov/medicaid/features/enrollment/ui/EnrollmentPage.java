package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;
import net.serenitybdd.core.annotations.findby.By;
import org.openqa.selenium.WebElement;

import java.util.List;

public class EnrollmentPage extends PsmPage {
    public void clickNext() {
        click($(".nextBtn"));
    }

    void setNoForRadioButton(String name) {
        List<WebElement> buttons = getDriver().findElements(By.cssSelector("[name='" + name + "']"));
        click(buttons.get(1));
    }
}
