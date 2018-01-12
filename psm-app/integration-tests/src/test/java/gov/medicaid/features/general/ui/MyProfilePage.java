package gov.medicaid.features.general.ui;

import net.thucydides.core.pages.PageObject;

import static org.assertj.core.api.Assertions.assertThat;

public class MyProfilePage extends PageObject {
    
    public void checkChangePassword() {
        String changeLinkText = $("#change_password_link").getText();
        assertThat(changeLinkText).contains("Change Password");
    }
}
