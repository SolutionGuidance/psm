/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.validators;

import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;

/**
 * This is a strict binder for MM/dd/yyyy date fields.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class StrictCustomDateEditor extends CustomDateEditor {

    /**
     * Creates a new instance.
     */
    public StrictCustomDateEditor() {
        super(new SimpleDateFormat("MM/dd/yyyy"), true);
    }

    /**
     * Checks that the SDF did not adjust the value based on overflows.
     * @param text the text entered by the user
     * @throws IllegalArgumentException if the parsed text is not the same as the entered text
     */
    @Override
    public void setAsText(String text) {
        super.setAsText(text);
        if (text != null && text.trim().length() > 0) {
            if (!text.equals(getAsText())) {
                throw new IllegalArgumentException("Value must be in the format MM/dd/yyyy.");
            }
        }
    }
}
