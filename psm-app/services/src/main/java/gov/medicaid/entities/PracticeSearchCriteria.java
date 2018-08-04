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
 * Represents a practice search criteria.
 */
public class PracticeSearchCriteria extends SearchCriteria {

    /**
     * The profile id.
     */
    private long profileId;

    /**
     * Practice name.
     */
    private String name;

    /**
     * Practice NPI.
     */
    private String npi;

    /**
     * Practice city.
     */
    private String city;

    /**
     * Practice state.
     */
    private String state;

    /**
     * Practice zip.
     */
    private String zip;

    /**
     * Flag indicating this is a search for agencies.
     */
    private boolean agency;

    /**
     * Empty constructor.
     */
    public PracticeSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     *
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }

    /**
     * Gets the value of the field <code>city</code>.
     *
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     *
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the value of the field <code>state</code>.
     *
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the value of the field <code>state</code>.
     *
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the value of the field <code>zip</code>.
     *
     * @return the zip
     */
    public String getZip() {
        return zip;
    }

    /**
     * Sets the value of the field <code>zip</code>.
     *
     * @param zip the zip to set
     */
    public void setZip(String zip) {
        this.zip = zip;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>agency</code>.
     * @return the agency
     */
    public boolean isAgency() {
        return agency;
    }

    /**
     * Sets the value of the field <code>agency</code>.
     * @param agency the agency to set
     */
    public void setAgency(boolean agency) {
        this.agency = agency;
    }
}
