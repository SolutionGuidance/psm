package gov.medicaid.features;

import com.deque.axe.AXE;
import net.thucydides.core.pages.PageObject;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class PsmPage extends PageObject {

    public static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("MM/dd/yyyy");

    public static String format(LocalDate date) {
        return date.format(DATE_FORMATTER);
    }

    public void click(WebElement target) {
        evaluateJavascript("arguments[0].scrollIntoView()", target);
        clickOn(target);
    }

    public void checkAccessibility() {
        WebDriver driver = getDriver();

        Optional<URL> axeCoreUrl = getAxeCoreUrl(driver);

        axeCoreUrl.ifPresent(url -> {
            JSONObject responseJSON = new AXE.Builder(driver, url)
                    .options("{ runOnly: { type: \"tag\", values: [\"wcag2a\", \"wcag2aa\"] } }")
                    .analyze();

            JSONArray violations = responseJSON.getJSONArray("violations");

            assertThat(violations.length()).isEqualTo(0);
        });
    }

    private static Optional<URL> getAxeCoreUrl(WebDriver driver) {
        return Optional
                .ofNullable(driver.getCurrentUrl())
                .map(currentUrl -> {
                    try {
                        URL baseUrl = new URL(currentUrl);
                        return new URL(baseUrl, "/cms/js/axe.min.js");
                    } catch (MalformedURLException e) {
                        return null;
                    }
                });
    }
}
