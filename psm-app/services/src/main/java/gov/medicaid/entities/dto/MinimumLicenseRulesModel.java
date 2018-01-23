/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.entities.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Front end model for each tab.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class MinimumLicenseRulesModel {

    /**
     * Forms to be displayed in this tab.
     */
    private List<String> requiredLicenses = new ArrayList<String>();

    /**
     * Forms to be displayed in this tab.
     */
    private List<String> optionalLicenses = new ArrayList<String>();

    /**
     * Forms to be displayed in this tab.
     */
    private List<String> allLicenses = new ArrayList<String>();

    /**
     * Empty constructor.
     */
    public MinimumLicenseRulesModel() {
    }

    /**
     * Gets the value of the field <code>requiredLicenses</code>.
     * @return the requiredLicenses
     */
    public List<String> getRequiredLicenses() {
        return requiredLicenses;
    }

    /**
     * Sets the value of the field <code>requiredLicenses</code>.
     * @param requiredLicenses the requiredLicenses to set
     */
    public void setRequiredLicenses(List<String> requiredLicenses) {
        this.requiredLicenses = requiredLicenses;
    }

    /**
     * Gets the value of the field <code>optionalLicenses</code>.
     * @return the optionalLicenses
     */
    public List<String> getOptionalLicenses() {
        return optionalLicenses;
    }

    /**
     * Sets the value of the field <code>optionalLicenses</code>.
     * @param optionalLicenses the optionalLicenses to set
     */
    public void setOptionalLicenses(List<String> optionalLicenses) {
        this.optionalLicenses = optionalLicenses;
    }

    /**
     * Gets the value of the field <code>allLicenses</code>.
     * @return the allLicenses
     */
    public List<String> getAllLicenses() {
        return allLicenses;
    }

    /**
     * Sets the value of the field <code>allLicenses</code>.
     * @param allLicenses the allLicenses to set
     */
    public void setAllLicenses(List<String> allLicenses) {
        this.allLicenses = allLicenses;
    }
}
