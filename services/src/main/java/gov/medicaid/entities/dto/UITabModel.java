/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Front end model for each tab.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
