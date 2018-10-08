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

public class ProviderStatementPage extends PsmPage {
    public void checkNoCriminalConviction() {
        click($("[name=_08_criminalConvictionInd][value='N']"));
    }

    public void checkNoCivilPenalty() {
        click($("[name=_08_civilPenaltyInd][value='N']"));
    }

    public void checkNoPreviousExclusion() {
        click($("[name=_08_previousExclusionInd][value='N']"));
    }

    public void checkYesCriminalConviction() {
        click($("[name=_08_criminalConvictionInd][value='Y']"));
    }

    public void checkYesCivilPenalty() {
        click($("[name=_08_civilPenaltyInd][value='Y']"));
    }

    public void checkYesPreviousExclusion() {
        click($("[name=_08_previousExclusionInd][value='Y']"));
    }

    public void enterProviderName(String providerName) {
        $("[name=_08_name], [name=_19_name]").type(providerName);
    }

    public void enterProviderTitle(String providerTitle) {
        $("[name=_08_title], [name=_19_title]").type(providerTitle);
    }

    public void acceptAllAgreements() {
        getDriver().findElements(By.cssSelector(".checkbox")).forEach(WebElement::click);
    }

    public void clickSubmitButton() {
        click($(".buttonBox > .purpleBtn"));
    }
}
