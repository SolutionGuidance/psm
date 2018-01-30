package gov.medicaid.features;

import com.deque.axe.AXE;
import cucumber.api.CucumberOptions;
import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;


/**
 * Integration test glue for serenity
 * This test runs all of the features.
 */

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(features = "src/test/resources/features")
public class IntegrationTests {
    public static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("MM/dd/yyyy");

    public static String format(LocalDate date) {
        return date.format(DATE_FORMATTER);
    }

    public static void click(PageObject pageObject, WebElement target) {
        pageObject.evaluateJavascript("arguments[0].scrollIntoView()", target);
        pageObject.clickOn(target);
    }

    public static void testAccessibility(PageObject pageObject) {
        WebDriver driver = pageObject.getDriver();

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
