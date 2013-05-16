/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities.dto;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


/**
 * View model for the provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
