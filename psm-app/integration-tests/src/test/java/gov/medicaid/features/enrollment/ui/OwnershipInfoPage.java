package gov.medicaid.features.enrollment.ui;

/**
 * Created by ben on 8/22/17.
 */
public class OwnershipInfoPage extends EnrollmentPage {
    public void selectEntityType(String entityType) {
        $("#entityType").selectByVisibleText(entityType);
    }

    public void addIndividualOwnership() {
        click($("#addIndividualOwnership"));
    }

    public void addBusinessOwnership() {
        click($("#addBusinessOwnership"));
    }

    public void selectOwnershipType(String ownershipType) {
        $(".ownershipType").selectByVisibleText(ownershipType);
    }

    public void setOwnershipFirstName(String first) {
        $("[name='_17_iboFirstName_0']").sendKeys(first);
    }

    public void setOwnershipMiddleName(String middle) {
        $("[name='_17_iboMiddleName_0']").sendKeys(middle);
    }

    public void setOwnershipLastName(String last) {
        $("[name='_17_iboLastName_0']").sendKeys(last);
    }

    public void setOwnershipSoSec(String sosec) {
        $("[name='_17_iboSSN_0']").sendKeys(sosec);
    }

    public void setOwnershipAddr1(String addr1) {
        $("[name='_17_iboAddressLine1_0']").sendKeys(addr1);
    }

    public void setOwnershipDOB(String dob) {
        $("[name='_17_iboDOB_0']").type(dob);
    }

    public void setOwnershipHireDate(String hireDate) {
        $("[name='_17_iboHireDate_0']").type(hireDate);
    }

    public void setOwnershipCity(String city) {
        $("[name='_17_iboCity_0']").sendKeys(city);
    }

    public void selectOwnershipState(String state) {
        $("[name='_17_iboState_0']").selectByVisibleText(state);
    }

    public void setOwnershipZip(String zip) {
        $("[name='_17_iboZip_0']").sendKeys(zip);
    }

    public void selectOwnershipCounty(String county) {
        $("[name='_17_iboCounty_0']").selectByVisibleText(county);
    }

    public void clickDisclosure() {
        click($("[name='_17_iboOtherInterestInd_0']"));
    }

    public void setControlOwnershipOtherLegalName(String legalName) {
        $("[name='_17_iboOtherInterestName_0']").sendKeys(legalName);
    }

    public void setControlOwnershipPctInterest(double pctInterest) {
        $("[name='_17_iboOtherInterestPct_0']").sendKeys(String.valueOf(pctInterest));
    }

    public void setControlOwnershipAddr1(String addr1) {
        $("[name='_17_iboOtherAddressLine1_0']").sendKeys(addr1);
    }

    public void setControlOwnershipCity(String city) {
        $("[name='_17_iboOtherCity_0']").sendKeys(city);
    }

    public void setControlOwnershipZip(String zip) {
        $("[name='_17_iboOtherZip_0']").sendKeys(zip);
    }

    public void selectControlOwnershipState(String state) {
        $("[name='_17_iboOtherState_0']").selectByVisibleText(state);
    }

    public void selectControlOwnershipCounty(String county) {
        $("[name='_17_iboOtherCounty0']").selectByVisibleText(county);
    }

    public void setNoToAllDisclosures() {
        String disclosureFields[] = {
                "_18_empCriminalConvictionInd",
                "_18_empCivilPenaltyInd",
                "_18_empPreviousExclusionInd",
                "_18_criminalConvictionInd",
                "_18_civilPenaltyInd",
                "_18_previousExclusionInd"
        };

        for (int i = 0; i < disclosureFields.length; i++) {
            setNoForRadioButton(disclosureFields[i]);
        }

    }

}
