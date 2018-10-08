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

package gov.medicaid.features.report.ui;

import gov.medicaid.features.PsmPage;

import net.thucydides.core.annotations.DefaultUrl;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms/admin/reports/provider-types")
public class ProviderTypesPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Provider Types");
    }

    private Optional<WebElement> findDivForMonth(String month) {
        return getDriver().findElements(By.cssSelector("#wrapper .tableData")).stream()
            .filter(div ->
                div.findElements(By.cssSelector(".tableTitle h2")).size() > 0 &&
                div.findElements(By.cssSelector(".tableTitle h2")).get(0).getText().equals(month))
            .findFirst();
    }

    private Optional<WebElement> findRowForProviderType(WebElement monthDiv, String providerTypeDesc) {
        return monthDiv.findElements(By.cssSelector("tr")).stream()
            .filter(tr ->
                tr.findElements(By.cssSelector("td")).size() > 0 &&
                tr.findElements(By.cssSelector("td")).get(0).getText().equals(providerTypeDesc))
            .findFirst();
    }

    private Optional<WebElement> findProviderTypeOption(String providerTypeDesc) {
        return getDriver().findElements(By.cssSelector("option")).stream()
            .filter(option -> option.getText().equals(providerTypeDesc))
            .findFirst();
    }

    public void checkApplicationsForMonth(
        int numApplications,
        String providerTypeDesc,
        String month
    ) {
        Optional<WebElement> monthElem = findDivForMonth(month);
        assertThat(monthElem.isPresent()).isTrue();
        Optional<WebElement> rowForProviderType = findRowForProviderType(monthElem.get(), providerTypeDesc);
        assertThat(rowForProviderType.isPresent()).isTrue();
        assertThat(rowForProviderType.get().findElements(By.cssSelector("td")).get(1).getText()).isEqualTo("" + numApplications);
    }

    public void checkHasNoResultsForMonth(String month) {
        Optional<WebElement> monthElem = findDivForMonth(month);
        assertThat(monthElem.isPresent()).isTrue();
        assertThat(monthElem.get().getText()).contains("No results found");
    }

    public void selectProviderType(String providerTypeDesc) {
        Optional<WebElement> option = findProviderTypeOption(providerTypeDesc);
        assertThat(option.isPresent()).isTrue();
        option.get().click();
    }

    public void checkProviderTypeSelected(String providerTypeDesc) {
        Optional<WebElement> option = findProviderTypeOption(providerTypeDesc);
        assertThat(option.isPresent()).isTrue();
        assertThat(option.get().isSelected()).isTrue();
    }
}
