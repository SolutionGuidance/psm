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

@DefaultUrl("http://localhost:8080/cms/admin/reports/time-to-review")
public class TimeToReviewPage extends PsmPage {
    public void checkOnPage() {
        String headerText = $("#wrapper h1.text").getText();
        assertThat(headerText).contains("Time to Review");
    }

    private Optional<WebElement> findRowForMonth(String month) {
        return getDriver().findElements(By.cssSelector("#wrapper .tableData .generalTable tr")).stream()
            .filter(tr ->
                tr.findElements(By.cssSelector("td")).size() > 0 &&
                tr.findElements(By.cssSelector("td")).get(0).getText().equals(month))
            .findFirst();
    }

    public void checkHasRowFor(String month) {
        assertThat(findRowForMonth(month).isPresent()).isTrue();
    }

    public void checkRowHasNumber(String month, String number) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(1).getText().equals(number)
        ).isTrue();
    }

    public void checkRowHasMean(String month, String mean) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(2).getText().equals(mean)
        ).isTrue();
    }

    public void checkRowHasMedian(String month, String median) {
        Optional<WebElement> tr = findRowForMonth(month);
        assertThat(
            tr.isPresent() &&
            tr.get().findElements(By.cssSelector("td")).get(3).getText().equals(median)
        ).isTrue();
    }
}
