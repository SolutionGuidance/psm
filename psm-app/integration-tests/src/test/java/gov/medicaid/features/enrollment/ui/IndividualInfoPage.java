package gov.medicaid.features.enrollment.ui;

public class IndividualInfoPage extends EnrollmentPage {

    public void enterIndividualMember() {
        click($("#addMember"));
    }

    public void setIndividualOwnerNPI(String npi) {
        $("[name='_16_npi_0']").type(npi);
    }

    public void setIndividualOwnerName(String ownerName) {
        $("[name='_16_name_0']").sendKeys(ownerName);
    }

    public void setIndividualProviderType(String providerType) {
        $("[name='_16_providerType_0']").selectByVisibleText(providerType);
    }

    public void setIndividualOwnerSoSec(String soSec) {
        $("[name='_16_ssn_0']").sendKeys(soSec);
    }

    public void setIndividualHireDate(String hireDate) {
        sendKeysIndividually("[name='_16_startDate_0'", hireDate);
    }

    public void setIndividualOwnerDOB(String dob) {
        sendKeysIndividually("[name='_16_dob_0']", dob);
    }
}
