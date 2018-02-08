package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;

import static org.assertj.core.api.Assertions.assertThat;

public class MyProfilePage extends PsmPage {

    public void checkChangePassword() {
        String changeLinkText = $("#change_password_link").getText();
        assertThat(changeLinkText).contains("Change Password");
    }

    public void clickChangePassword() {
        click($("#change_password_link"));
    }
}
