/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.entities.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Front end model for each tab.
 */
public class UITabModel {

    /**
     * Forms to be displayed in this tab.
     */
    private List<String> formNames = new ArrayList<String>();

    /**
     * Form settings for each form (if needed).
     */
    private Map<String, FormSettings> formSettings = new HashMap<String, FormSettings>();

    /**
     * Empty constructor.
     */
    public UITabModel() {
    }

    /**
     * Gets the value of the field <code>formNames</code>.
     *
     * @return the formNames
     */
    public List<String> getFormNames() {
        return formNames;
    }

    /**
     * Gets the value of the field <code>formSettings</code>.
     *
     * @return the formSettings
     */
    public Map<String, FormSettings> getFormSettings() {
        return formSettings;
    }

    /**
     * Adds a new form.
     * @param formName the form name
     * @param settings the form settings
     */
    public void addForm(String formName, FormSettings settings) {
        this.formNames.add(formName);
        this.formSettings.put(formName, settings);
    }
}
