package gov.medicaid.features.service_admin.ui;

import gov.medicaid.features.PsmPage;

import net.thucydides.core.webelements.Checkbox;

import static org.assertj.core.api.Assertions.assertThat;

public class ApplicationReviewPage extends PsmPage {
    public String getApplicationId() {
        assertThat(getDriver().getCurrentUrl().matches(".*id=\\d*")).isTrue();
        return getDriver().getCurrentUrl().replaceFirst(".*id=", "");
    }

    public void approve() {
        new Checkbox($("[name=nonExclusionVerified]")).setChecked(true);
        new Checkbox($("[name=notInDmfVerified]")).setChecked(true);
        $(".approveBtn").click();
    }

    public void reject() {
        $(".rejectBtn").click();
    }
}
