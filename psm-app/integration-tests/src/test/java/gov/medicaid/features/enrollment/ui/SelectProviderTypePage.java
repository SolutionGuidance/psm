package gov.medicaid.features.enrollment.ui;

public class SelectProviderTypePage extends EnrollmentPage {
    public void selectProviderType(String aProviderType) {
        $("[name=_01_providerType]").selectByVisibleText(aProviderType);
    }
}
