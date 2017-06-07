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
package gov.medicaid.entities;


/**
 * Represents a help search criteria.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class HelpSearchCriteria extends SearchCriteria {

    /**
     * Term.
     */
    private String term;

    /**
     * Default empty constructor.
     */
    public HelpSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>term</code>.
     *
     * @return the term
     */
    public String getTerm() {
        return term;
    }

    /**
     * Sets the value of the field <code>term</code>.
     *
     * @param term the term to set
     */
    public void setTerm(String term) {
        this.term = term;
    }
}
