package gov.medicaid.features.general.ui;

import com.google.common.base.Function;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
// import static org.hamcrest.MatcherAssert.assertThat;
// import static org.hamcrest.core.StringContains.containsString;
import static org.assertj.core.api.Assertions.assertThat;

import java.util.concurrent.TimeUnit;

public class LicenseInfoPage extends PageObject {
    public void clickNo() {
        $("input[value='N'").click();
    }
    public void addLicense() {
        $("#addLicense").click();
    }
    public void addLicenseType(String licenseType) {
        $("[name=_03_licenseType_0]").selectByVisibleText(licenseType);
    }
    public void uploadFile(String filepath) {
        $("[name=_03_attachment_0]").sendKeys(filepath);
    }
    public void enterLicenseNumber(String licenseNumber) {
        $("[name=_03_licenseNumber_0]").type(licenseNumber);
    }
    public void enterIssueDate(String issueDate) {
        $("[name=_03_originalIssueDate_0]").type(issueDate);
    }
    public void enterRenewalDate(String renewalDate) {
        $("[name=_03_renewalDate_0]").type(renewalDate);
    }
    public void enterIssueState(String issueState) {
        $("[name=_03_issuingState_0]").selectByVisibleText(issueState);
    }
    public void clickNext() {

        $("#nextBtn").click();
        assertThat(getTitle().contains("Practice Information"));
    }
}
