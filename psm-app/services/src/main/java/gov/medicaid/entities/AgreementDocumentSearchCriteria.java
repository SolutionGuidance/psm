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

package gov.medicaid.entities;

/**
 * This represents the search criteria for agreement document.
 */
public class AgreementDocumentSearchCriteria extends SearchCriteria {

    /** The title. */
    private String title;

    /** The type. */
    private AgreementDocumentType type;

    /**
     * Empty constructor.
     */
    public AgreementDocumentSearchCriteria() {
    }

    /**
     * Getter of the title.
     *
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Setter of the title.
     *
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Getter of the type.
     *
     * @return the type
     */
    public AgreementDocumentType getType() {
        return type;
    }

    /**
     * Setter of the type.
     *
     * @param type the type to set
     */
    public void setType(AgreementDocumentType type) {
        this.type = type;
    }
}
