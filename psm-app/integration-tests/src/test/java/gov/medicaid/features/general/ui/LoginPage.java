package gov.medicaid.features.general.ui;

import net.thucydides.core.pages.PageObject;
import net.thucydides.core.annotations.DefaultUrl;

import static gov.medicaid.features.IntegrationTests.click;
import static gov.medicaid.features.IntegrationTests.accessibilitySniffer;
import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
public class LoginPage extends PageObject {

    public void checkAccessibility() {
        accessibilitySniffer(this);

        // We need to wait for the widget to load/update before accessing it.
        // TODO: This is a bad way to wait for the widget to refresh.
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        $("#HTMLCS-settings-use-standard-select").selectByVisibleText("WCAG2AA");

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        String errorCount = $("#HTMLCS-settings-issue-count > .HTMLCS-error > .HTMLCS-tile-text strong").getText();

        assertThat(errorCount).isEqualTo("0");
    }

    public void enterProviderCredentials() {
        $("#username").sendKeys("p1");
        $("#password").sendKeys("p1");
    }

    public void login() {
        click(this, $("#btnLogin"));
    }

    public void checkUserLoggedIn(String username) {
        String welcomeText = $("#header > div > div.userSection").getText();
        assertThat(welcomeText).contains("Welcome, " + username);
    }

    public void checkUserLoggedOut() {
        assertThat(getTitle()).contains("Login");
    }
}
