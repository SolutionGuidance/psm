package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.service_admin.ui.ProviderTypePage;

import net.thucydides.core.annotations.Step;

public class ProviderTypeSteps {
    ProviderTypePage providerTypePage;

    @Step
    public void setProviderTypeDescription(String desc) {
        providerTypePage.updateDescriptionInput(desc);
    }

    @Step
    public void submitProviderType() {
        providerTypePage.submitSave();
    }

    @Step
    public void confirmOnViewPage(String desc) {
        providerTypePage.assertViewing(desc);
    }

    @Step
    public void viewProviderType(String desc) {
        providerTypePage.view(desc);
    }

    @Step
    public void editProviderType(String desc) {
        providerTypePage.edit(desc);
    }

    @Step
    public void addProviderTypeAgreementsAndLicenses() {
        providerTypePage.addAgreementsAndLicenses();
    }

    @Step
    public void confirmNoProviderTypeInList(String desc) {
        providerTypePage.noProviderTypeInList(desc);
    }

    @Step
    public void deleteProviderType(String desc) {
        providerTypePage.delete(desc);
    }
}
