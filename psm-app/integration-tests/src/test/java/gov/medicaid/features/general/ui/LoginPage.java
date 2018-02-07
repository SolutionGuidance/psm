package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
public class LoginPage extends PsmPage {

    public void enterProviderCredentials() {
        $("#username").sendKeys("p1");
        $("#password").sendKeys("p1");
    }

    public void login() {
        click($("#btnLogin"));
    }

    public void checkUserLoggedIn(String username) {
        String welcomeText = $("#header > div > div.userSection").getText();
        assertThat(welcomeText).contains("Welcome, " + username);
    }

    public void checkUserLoggedOut() {
        assertThat(getTitle()).contains("Login");
    }
}
