/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

    /**
     * Used to avoid race conditions with the input mask library that lead to
     * erroneous input, particularly with non-formatted String dates,
     * e.g. "01012018" results in "01/01/0182" instead of "01/01/2018".
     */
    public void sendKeysIndividually(String selector, String input) {
        for (int i = 0; i < input.length(); i++) {
            $(selector).sendKeys(input.substring(i, i + 1));
        }
    }

    public void click(WebElement target) {
        evaluateJavascript("arguments[0].scrollIntoView()", target);
        clickOn(target);
    }

    public void click$(String selector) {
        click($(selector));
    }

    public void checkAccessibility() {
        WebDriver driver = getDriver();

        Optional<URL> axeCoreUrl = getAxeCoreUrl(driver);

        axeCoreUrl.ifPresent(url -> {
            JSONObject responseJSON = new AXE.Builder(driver, url)
                    .options("{ runOnly: { type: \"tag\", values: [\"wcag2a\", \"wcag2aa\"] } }")
                    .analyze();

            JSONArray violations = responseJSON.getJSONArray("violations");

            if (violations.length() > 0) {
                System.err.println(violations.toString(2));
            }

            assertThat(violations.length()).isEqualTo(0);
        });
    }

    public void hasNoServerError() {
        if ($("#wrapper h1").isPresent()) {
            String headerText = $("#wrapper h1").getText();
            assertThat(headerText).isNotEqualTo("Error");
        }
    }

    public void switchToWindowOrFail(String title) {
        for (String handle : getDriver().getWindowHandles()) {
            getDriver().switchTo().window(handle);
            if (getTitle().equals(title)) {
                return;
            }
        }

        throw new RuntimeException("Switching windows failed, title was: " + getTitle());
    }

    public void checkForFormError(String errorClass, String errorText) {
        assertThat($(".errorInfo > ." + errorClass).getText())
            .contains(errorText);
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
