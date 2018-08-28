package gov.medicaid.features.service_admin.ui;

import gov.medicaid.features.PsmPage;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

public class ServiceAgentReviewScreeningPage extends PsmPage {
    public void clickOnDmfDetails() {
        WebElement td = $("//td[contains(text(),'DEATH MASTER FILE CHECK')]");
        WebElement dmfRow = td.findElement(By.xpath(".."));
        dmfRow.findElement(By.cssSelector(".autoScreeningResultLink")).click();

        switchToWindowOrFail("DMF Automatic Screening Details");
    }
}
