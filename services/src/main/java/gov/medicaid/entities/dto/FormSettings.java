/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities.dto;

import java.util.HashMap;
import java.util.Map;

/**
 * Form settings.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FormSettings {

    /**
     * Settings specific to this instance.
     */
    private Map<String, Object> settings = new HashMap<String, Object>();

    /**
     * Empty constructor.
     */
    public FormSettings() {
    }

    /**
     * Gets the value of the field <code>settings</code>.
     * @return the settings
     */
    public Map<String, Object> getSettings() {
        return settings;
    }

    /**
     * Adds new settings.
     * @param key the setting key
     * @param value the setting value
     */
    public void addSetting(String key, Object value) {
        settings.put(key, value);
    }

}
