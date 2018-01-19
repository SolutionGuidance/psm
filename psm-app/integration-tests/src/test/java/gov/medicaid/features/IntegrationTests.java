package gov.medicaid.features;

import cucumber.api.CucumberOptions;
import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebElement;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


/**
 * Integration test glue for serenity
 * This test runs all of the features.
 */

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(features = "src/test/resources/features")
public class IntegrationTests {
    public static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("MM/dd/yyyy");

    public static final String ACCESSIBILITY_SNIFFER = "(function() {\n" +
            "    var _p = '//squizlabs.github.io/HTML_CodeSniffer/build/';\n" +
            "    var _i = function(s, cb) {\n" +
            "        var sc = document.createElement('script');\n" +
            "        sc.onload = function() {\n" +
            "            sc.onload = null;\n" +
            "            sc.onreadystatechange = null;\n" +
            "            cb.call(this);\n" +
            "        };\n" +
            "        sc.onreadystatechange = function() {\n" +
            "            if (/^(complete|loaded)$/.test(this.readyState) === true) {\n" +
            "                sc.onreadystatechange = null;\n" +
            "                sc.onload();\n" +
            "            }\n" +
            "        };\n" +
            "        sc.src = s;\n" +
            "        if (document.head) {\n" +
            "            document.head.appendChild(sc);\n" +
            "        } else {\n" +
            "            document.getElementsByTagName('head')[0].appendChild(sc);\n" +
            "        }\n" +
            "    };\n" +
            "    var options = {\n" +
            "        path: _p\n" +
            "    };\n" +
            "    _i(_p + 'HTMLCS.js', function() {\n" +
            "        HTMLCSAuditor.run('WCAG2AA', null, options);\n" +
            "    });\n" +
            "})();";

    public static String format(LocalDate date) {
        return date.format(DATE_FORMATTER);
    }

    public static void click(PageObject pageObject, WebElement target) {
        pageObject.evaluateJavascript("arguments[0].scrollIntoView()", target);
        pageObject.clickOn(target);
    }

    public static void accessibilitySniffer(PageObject pageObject) {
        pageObject.evaluateJavascript(ACCESSIBILITY_SNIFFER);

    }
}
