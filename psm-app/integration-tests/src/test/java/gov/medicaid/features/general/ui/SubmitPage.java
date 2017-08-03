package gov.medicaid.features.general.ui;

import com.google.common.base.Function;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.Alert;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
// import static org.hamcrest.MatcherAssert.assertThat;
// import static org.hamcrest.core.StringContains.containsString;
import static org.assertj.core.api.Assertions.assertThat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.text.SimpleDateFormat;


import java.util.concurrent.TimeUnit;

public class SubmitPage extends PageObject {
    public void checkNoCriminalConviction() {
        $("[name=_08_criminalConvictionInd][value='N']").click();
    }
    public void checkNoCivilPenalty() {
        $("[name=_08_civilPenaltyInd][value='N']").click();
    }
    public void checkNoPreviousExclusion() {
        $("[name=_08_previousExclusionInd][value='N']").click();
    }
    public void checkYesCriminalConviction() {
        $("[name=_08_criminalConvictionInd][value='Y']").click();
    }
    public void checkYesCivilPenalty() {
        $("[name=_08_civilPenaltyInd][value='Y']").click();
    }
    public void checkYesPreviousExclusion() {
        $("[name=_08_previousExclusionInd][value='Y']").click();
    }
    public void enterProviderName(String providerName) {
        $("[name=_08_name]").type(providerName);
    }
    public void enterProviderTitle(String providerTitle) {
        $("[name=_08_title]").type(providerTitle);
    }
    public void clickReadAgreement() {
        $("[name=_08_accepted_0]").click();
    }
    //will only accept the current date
    public void enterValidDate() {
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Date today = Calendar.getInstance().getTime();
        String currentDate = df.format(today);
        $("[name=_08_date]").type(currentDate);
    }
    //enter a date 15 days in the future
    public void enterFutureDate() {
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.DATE, 15);
        String futureDate = df.format(c.getTime());
        $("[name=_08_date]").type(futureDate);
    }
    //Using a string for a past date as it will always be in the past
    public void enterPastDate() {
        $("[name=_08_date]").type("11/10/2005");
    }
    public void clickSubmitButton() {
        $(".buttonBox > .purpleBtn").click();
    }
    public void closePopup() {
//        WebDriverWait wait = new WebDriverWait(getDriver(), 10);
//        wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("buttonArea")));
        String parentWindowHandler = getDriver().getWindowHandle();
//        System.out.println(parentWindowHandler);
        String subWindowHandler = null;
        Set<String> handles = getDriver().getWindowHandles();
        Iterator<String> iterator = handles.iterator();
        while(iterator.hasNext()) {
            subWindowHandler = iterator.next();
//            System.out.println(subWindowHandler);
        }
        getDriver().switchTo().window(subWindowHandler);
        $("#submitEnrollmentModal > div > div:nth-child(2) > div > div > div > a").click();
        getDriver().switchTo().window(parentWindowHandler);
    }
    public void checkEnrollmentPage() {
        assertThat($(".head > h1").getText().contains("View Enrollment Details"));
        assertThat($("a[href$='/cms/provider/enrollment/jump?page=Personal+Information'").getText().contains("Personal Info"));
        assertThat($("a[href$='/cms/provider/enrollment/jump?page=License+Information'").getText().contains("License Info"));
        assertThat($("a[href$='/cms/provider/enrollment/jump?page=Practice+Information'").getText().contains("Practice Info"));
        assertThat($("a[href$='/cms/provider/enrollment/jump?page=Provider+Statement'").getText().contains("Provider Statement"));

    }
}
