package gov.medicaid.features.general.ui;


import net.thucydides.core.pages.PageObject;
import net.thucydides.core.annotations.DefaultUrl;
import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
public class LoginPage extends PageObject {

    public void enterProviderCredentials() {
        $("#username").sendKeys("p1");
        $("#password").sendKeys("p1");
    }

    public void login() {
        $("#btnLogin").click();
    }

    public void checkUserLoggedIn(String username) {
        String welcomeText = $("#header > div > div.userSection").getText();
        assertThat(welcomeText.contains("Welcome, " + username));
    }
}
