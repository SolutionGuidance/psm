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

import java.util.Date;

/**
 * Represents a person.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Person extends Entity {

    /**
     * SSN.
     */
    private String ssn;

    /**
     * SSN Verification status.
     */
    private String ssnVerifiedInd;

    /**
     * Date of birth.
     */
    private Date dob;

    /**
     * Degree.
     */
    private Degree degree;

    /**
     * Award date.
     */
    private Date degreeAwardDate;

    /**
     * Prefix.
     */
    private String prefix;

    /**
     * Suffix.
     */
    private String suffix;

    /**
     * The first name.
     */
    private String firstName;

    /**
     * The last name.
     */
    private String lastName;

    /**
     * The middle name.
     */
    private String middleName;

    /**
     * Empty constructor.
     */
    public Person() {
    }

    /**
     * Gets the value of the field <code>ssn</code>.
     *
     * @return the ssn
     */
    public String getSsn() {
        return ssn;
    }

    /**
     * Sets the value of the field <code>ssn</code>.
     *
     * @param ssn the ssn to set
     */
    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    /**
     * Gets the value of the field <code>dob</code>.
     *
     * @return the dob
     */
    public Date getDob() {
        return dob;
    }

    /**
     * Sets the value of the field <code>dob</code>.
     *
     * @param dob the dob to set
     */
    public void setDob(Date dob) {
        this.dob = dob;
    }

    /**
     * Gets the value of the field <code>degree</code>.
     *
     * @return the degree
     */
    public Degree getDegree() {
        return degree;
    }

    /**
     * Sets the value of the field <code>degree</code>.
     *
     * @param degree the degree to set
     */
    public void setDegree(Degree degree) {
        this.degree = degree;
    }

    /**
     * Gets the value of the field <code>degreeAwardDate</code>.
     *
     * @return the degreeAwardDate
     */
    public Date getDegreeAwardDate() {
        return degreeAwardDate;
    }

    /**
     * Sets the value of the field <code>degreeAwardDate</code>.
     *
     * @param degreeAwardDate the degreeAwardDate to set
     */
    public void setDegreeAwardDate(Date degreeAwardDate) {
        this.degreeAwardDate = degreeAwardDate;
    }

    /**
     * Gets the value of the field <code>prefix</code>.
     *
     * @return the prefix
     */
    public String getPrefix() {
        return prefix;
    }

    /**
     * Sets the value of the field <code>prefix</code>.
     *
     * @param prefix the prefix to set
     */
    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    /**
     * Gets the value of the field <code>suffix</code>.
     *
     * @return the suffix
     */
    public String getSuffix() {
        return suffix;
    }

    /**
     * Sets the value of the field <code>suffix</code>.
     *
     * @param suffix the suffix to set
     */
    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    /**
     * Gets the value of the field <code>firstName</code>.
     *
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the value of the field <code>firstName</code>.
     *
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the value of the field <code>lastName</code>.
     *
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the value of the field <code>lastName</code>.
     *
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the value of the field <code>middleName</code>.
     *
     * @return the middleName
     */
    public String getMiddleName() {
        return middleName;
    }

    /**
     * Sets the value of the field <code>middleName</code>.
     *
     * @param middleName the middleName to set
     */
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    /**
     * Gets the value of the field <code>ssnVerifiedInd</code>.
     * @return the ssnVerifiedInd
     */
    public String getSsnVerifiedInd() {
        return ssnVerifiedInd;
    }

    /**
     * Sets the value of the field <code>ssnVerifiedInd</code>.
     * @param ssnVerifiedInd the ssnVerifiedInd to set
     */
    public void setSsnVerifiedInd(String ssnVerifiedInd) {
        this.ssnVerifiedInd = ssnVerifiedInd;
    }
}
