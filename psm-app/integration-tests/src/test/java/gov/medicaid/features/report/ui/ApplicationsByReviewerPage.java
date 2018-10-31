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

@DefaultUrl("http://localhost:8080/cms/admin/reports/applications-by-reviewer")
public class ApplicationsByReviewerPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Applications by Reviewer");
    }

    public void clickViewReportButton() {
        click($(".viewApplicationsByReviewerButton"));
    }

    public void clearDates() {
        $("#startDate").clear();
        $("#endDate").clear();
    }

    public void submitSearch(String d1, String d2) {
        clearDates();
        $("#startDate").sendKeys(d1);
        $("#endDate").sendKeys(d2);
        clickViewReportButton();
    }

    public void checkHasResults() {
        assertThat($("#wrapper").containsElements(".tableData")).isTrue();
    }

    public void checkHasNoResults() {
        assertThat($("#wrapper .noResults").getText()).contains("No results found");
    }

    public void clickOnApplication(int applicationId) {
        Optional<WebElement> link =
            getDriver().findElements(By.cssSelector("#wrapper .tableData .generalTable tr td a")).stream()
                .filter(a -> a.getText().equals("" + applicationId))
            .findFirst();

        assertThat(link.isPresent()).isTrue();
        link.get().click();
    }
}
