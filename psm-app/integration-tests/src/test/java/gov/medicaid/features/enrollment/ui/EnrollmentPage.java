package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.enrollment.steps.EnrollmentSteps;
import net.thucydides.core.pages.PageObject;
import net.thucydides.core.annotations.DefaultUrl;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
public class EnrollmentPage extends PageObject {
    public void loginAsProvider() {
        $("#username").sendKeys("p1");
        $("#password").sendKeys("p1");
        $("#btnLogin").click();
    }

    public void clickOnNewEnrollment(){
        $("#updateProfile > div > div > div > a").click();
        assertThat(getTitle().equals("Provider Type Page"));
    }

    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

    public void enterOrganizationInformation(Map<EnrollmentSteps.OrganizationalInformation, String> orgData) {
        $("[name=_15_npi]").sendKeys(orgData.get(EnrollmentSteps.OrganizationalInformation.NPI));
        $("[name=_15_effectiveDate]").sendKeys(orgData.get(EnrollmentSteps.OrganizationalInformation.EFFECTIVE_DATE));
    }
}
