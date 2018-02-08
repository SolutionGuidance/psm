package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/provider/profile/reset")
public class UpdatePasswordPage extends PsmPage {
    public void checkUpdatePassword() {
        assertThat(getTitle()).isEqualTo("Update Password");
    }
}
