package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;

import static org.assertj.core.api.Assertions.assertThat;

public class UpdatePasswordPage extends PsmPage {
    public void checkUpdatePassword() {
        assertThat(getTitle()).isEqualTo("Update Password");
    }
}
