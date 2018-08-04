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

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


/**
 * View model for the provider.
 */
public class ViewModel {

    /**
     * The current tab.
     */
    private String currentTab = null;

    /**
     * Default display type.
     */
    private boolean individual = true;

    /**
     * The tabs to be displayed.
     */
    private List<String> tabNames = (List<String>) new LinkedList<String>();

    /**
     * The model for each tab.
     */
    private Map<String, UITabModel> tabModels = new HashMap<String, UITabModel>();

    /**
     * Empty constructor.
     */
    public ViewModel() {

    }

    /**
     * Gets the value of the field <code>currentTab</code>.
     *
     * @return the currentTab
     */
    public String getCurrentTab() {
        return currentTab;
    }

    /**
     * Sets the value of the field <code>currentTab</code>.
     *
     * @param currentTab the currentTab to set
     */
    public void setCurrentTab(String currentTab) {
        this.currentTab = currentTab;
    }

    /**
     * Gets the value of the field <code>tabModels</code>.
     *
     * @return the tabModels
     */
    public Map<String, UITabModel> getTabModels() {
        return tabModels;
    }

    /**
     * Gets the value of the field <code>tabNames</code>.
     *
     * @return the tabNames
     */
    public List<String> getTabNames() {
        return tabNames;
    }

    /**
     * Adds a new tab.
     * @param pageName the tab name
     * @param model the tab model
     */
    public void addTabModel(String pageName, UITabModel model) {
        tabNames.add(pageName);
        tabModels.put(pageName, model);
    }

    /**
     * Retrieves the current forms.
     * @return the current tab forms
     */
    public List<String> getCurrentFormNames() {
        return tabModels.get(currentTab).getFormNames();
    }

    /**
     * Gets the value of the field <code>individual</code>.
     * @return the individual
     */
    public boolean isIndividual() {
        return individual;
    }

    /**
     * Sets the value of the field <code>individual</code>.
     * @param individual the individual to set
     */
    public void setIndividual(boolean individual) {
        this.individual = individual;
    }
}
