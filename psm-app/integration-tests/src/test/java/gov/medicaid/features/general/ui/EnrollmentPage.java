package gov.medicaid.features.general.ui;


import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.pages.PageObject;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.List;
import java.util.regex.Pattern;
// import static org.hamcrest.MatcherAssert.assertThat;
// import static org.hamcrest.core.StringContains.containsString;
import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentPage extends PageObject {
    @FindBy(css=".userSection")
    WebElement header;

    public void checkHeader() {
        assertThat(header.getText().contains("Welcome, p1"));
    }
    public void createEnrollment() {
        assertThat($("a[href$='enrollment/start'").getText().contains("Create New Enrollment"));
        $("a[href$='enrollment/start'").click();
        assertThat(getTitle().contains("Provider Type Page"));
        assertThat($(".head").getText().contains("Select Provider Type"));
    }
    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType").selectByVisibleText(aProviderType);
    }
    public void clickNext() {
        $("#nextBtn").click();
    }
    public void checkPersonalInfo() {
        assertThat(getTitle().contains("Personal Information"));
        assertThat($(".head").getText().contains("Enrollment Application"));
    }
}
