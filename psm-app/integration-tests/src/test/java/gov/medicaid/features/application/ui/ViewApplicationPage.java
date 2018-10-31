package gov.medicaid.features.application.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.annotations.findby.By;
import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.annotations.NamedUrl;
import net.thucydides.core.annotations.NamedUrls;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
@NamedUrls ({
    @NamedUrl(name = "view.application", url = "/provider/application/view?id={1}")
})
public class ViewApplicationPage extends PsmPage {
    public void verifyState(String state) {
        assertThat(
            getDriver()
                .findElement(By.cssSelector(".applicationStatus"))
                .getText()
        ).isEqualTo(state);
    }
}
