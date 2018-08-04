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

package gov.medicaid.controllers.validators;

import org.springframework.beans.propertyeditors.CustomDateEditor;

import java.text.SimpleDateFormat;

/**
 * This is a strict binder for MM/dd/yyyy date fields.
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
