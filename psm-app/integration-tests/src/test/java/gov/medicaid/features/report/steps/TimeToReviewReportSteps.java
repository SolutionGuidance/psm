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

package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.TimeToReviewPage;

import net.thucydides.core.annotations.Step;

public class TimeToReviewReportSteps {
    private TimeToReviewPage timeToReviewPage;

    @Step
    public void checkOnTimeToReviewPage() {
        timeToReviewPage.checkOnPage();
    }

    @Step
    public void checkTimeToReviewPageHasNARowFor(String month) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasMean(month, "N/A");
        timeToReviewPage.checkRowHasMedian(month, "N/A");
    }

    @Step
    public void checkTimeToReviewPageHasRowWithApplications(String month, String numApplications) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasNumber(month, numApplications);
    }

    @Step
    public void downloadTimeToReviewReportCsv() {
        timeToReviewPage.click$(".downloadTimeToReview");
    }
}
