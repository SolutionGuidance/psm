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

package gov.medicaid.features.application.ui;

import gov.medicaid.features.PsmPage;

import net.serenitybdd.core.annotations.findby.By;

import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class ApplicationListPage extends PsmPage {

    public void checkApplicationsInTable() {
        assertThat(
            getDriver()
            .findElements(By.cssSelector(".generalTable tr"))
            .size())
        .isGreaterThan(1);
    }

    public void filterByNpi(String npi) {
        // For providers
        if ($("#listByStatusNpi").isPresent()) {
            $("#listByStatusNpi").sendKeys(npi);
            $("#filterForm").submit();
        } else { // For admins
            $("#applicationSearchFilterNpiInput").sendKeys(npi);
            $("#showSearchApplicationsResultBtn").click();
        }
    }

    public void advanceToReview(String npi) {
        WebElement applicationRow = getTableRowForNpi(npi);
        assertThat(applicationRow).isNotNull();
        applicationRow.findElement(By.cssSelector(".reviewLink")).click();
    }

    public WebElement getTableRowForProviderType(String providerType) {
        WebElement td = $("//td[contains(text(),'" + providerType + "')]");
        WebElement row = td.findElement(By.xpath(".."));
        return row;
    }

    public WebElement getTableRowForNpi(String npi) {
        WebElement td = $("//td[contains(text(),'" + npi + "')]");
        WebElement row = td.findElement(By.xpath(".."));
        return row;
    }

    public void clickActionForNpi(String npi, String action) {
        Optional<WebElement> row =
            getDriver()
                .findElements(By.cssSelector(".generalTable tr"))
                .stream()
                .filter(tr ->
                    tr.findElements(By.xpath("td[contains(text(),'" + npi + "')]")).size() > 0 &&
                    tr.findElements(By.cssSelector(action)).size() > 0)
                .findFirst();

        assertThat(row).isPresent();
        assertThat(row.get().findElement(By.cssSelector(action)).isDisplayed()).isTrue();

        row.get().findElement(By.cssSelector(action)).click();
    }
}
