package gov.medicaid.features.enrollment.ui;


import cucumber.api.PendingException;
import net.thucydides.core.pages.PageObject;


public class EnrollmentPage extends PageObject {
    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }

    public void clickNext() {
        $("#nextBtn").click();
    }

    public void setFEIN(String feinValue) {
        $("#fein").typeAndTab(feinValue);
    }


    public String getFEINValue() {
        return $("#fein").getValue();
    }

    public void verifyApplicantNameAccepted() {
        if (isOrganizaionalEnrollment()) {
            $("#legalName").sendKeys("verify_name");
        } else {
            $("#firstName").sendKeys("first_name");
            $("#middleName").sendKeys("MI");
            $("[name='_02_lastName']").sendKeys("last_name");
        }
    }

    public void verifyContactNameAccepted() {
        $("#contactName").sendKeys("contact_name");
    }

    public void verifyContactPhoneAccepted() {
        if (isOrganizaionalEnrollment()) {
            $("[name='_15_contactPhone1']").sendKeys("217");
            $("[name='_15_contactPhone2']").sendKeys("217");
            $("[name='_15_contactPhone3']").sendKeys("217");
        } else {
            throw new PendingException("Issue #346 - Capture contact phone # for individual provider enrollments");
        }
    }

    public void verifyMedicaidNumberAccepted() {
        throw new PendingException("Issue #347 - Capture Medicaid Number for new Enrollments");
    }


    public boolean isPersonalEnrollment() {
        return this.getTitle().equals("Personal Information");
    }

    public boolean isOrganizaionalEnrollment() {
        return this.getTitle().equals("Organization Information");
    }
}
