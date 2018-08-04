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

import gov.medicaid.binders.BinderUtils;

import java.util.Date;

/**
 * Projection results from search of enrolled practices.
 */
public class PracticeLookup {

    /**
     * Profile id.
     */
    private long profileId;

    /**
     * The profile id hash.
     */
    private String profileIdHash;

    /**
     * NPI.
     */
    private String npi;

    /**
     * Agency id.
     */
    private String agencyId;

    /**
     * Practice name.
     */
    private String name;

    /**
     * Practice address line.
     */
    private String addressLine1;

    /**
     * Practice address line.
     */
    private String addressLine2;

    /**
     * Practice address city.
     */
    private String city;

    /**
     * Practice address state.
     */
    private String state;

    /**
     * Practice address zip.
     */
    private String zip;

    /**
     * Practice address county.
     */
    private String county;

    /**
     * The phone number.
     */
    private String phoneNumber;

    /**
     * The split phone number.
     */
    private String[] phone;

    /**
     * The fax number.
     */
    private String faxNumber;

    /**
     * The split fax number.
     */
    private String fax[];

    /**
     * Background study id.
     */
    private String bgsId;

    /**
     * Clearance date.
     */
    private Date clearanceDate;

    /**
     * The contact name.
     */
    private String contactName;

    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param npi assigned to the field with the same name
     * @param name assigned to the field with the same name
     * @param addressLine1 assigned to the field with the same name
     * @param addressLine2 assigned to the field with the same name
     * @param city assigned to the field with the same name
     * @param state assigned to the field with the same name
     * @param zip assigned to the field with the same name
     * @param county assigned to the field with the same name
     * @param phoneNumber assigned to the field with the same name
     * @param faxNumber assigned to the field with the same name
     * @param bgsId assigned to the field with the same name
     * @param clearanceDate assigned to the field with the same name
     * @param agencyId assigned to the field with the same name
     */
    public PracticeLookup(long profileId, String npi, String name, String addressLine1, String addressLine2,
        String city, String state, String zip, String county, String phoneNumber, String faxNumber, String bgsId,
        Date clearanceDate, String agencyId) {
        super();
        this.profileId = profileId;
        this.npi = npi;
        this.name = name;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.city = city;
        this.state = state;
        this.zip = zip;
        this.county = county;
        this.phoneNumber = phoneNumber;
        this.bgsId = bgsId;
        this.clearanceDate = clearanceDate;
        this.agencyId = agencyId;
        this.phone = BinderUtils.splitPhone(phoneNumber);
        this.faxNumber = faxNumber;
        this.fax = BinderUtils.splitPhone(faxNumber);
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     *
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
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
     * Gets the value of the field <code>addressLine1</code>.
     *
     * @return the addressLine1
     */
    public String getAddressLine1() {
        return addressLine1;
    }

    /**
     * Gets the value of the field <code>addressLine2</code>.
     *
     * @return the addressLine2
     */
    public String getAddressLine2() {
        return addressLine2;
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
     * Gets the value of the field <code>state</code>.
     *
     * @return the state
     */
    public String getState() {
        return state;
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
     * Gets the value of the field <code>county</code>.
     *
     * @return the county
     */
    public String getCounty() {
        return county;
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
     * Gets the value of the field <code>profileIdHash</code>.
     * @return the profileIdHash
     */
    public String getProfileIdHash() {
        return profileIdHash;
    }

    /**
     * Sets the value of the field <code>profileIdHash</code>.
     * @param profileIdHash the profileIdHash to set
     */
    public void setProfileIdHash(String profileIdHash) {
        this.profileIdHash = profileIdHash;
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }

    /**
     * Gets the value of the field <code>faxNumber</code>.
     * @return the faxNumber
     */
    public String getFaxNumber() {
        return faxNumber;
    }

    /**
     * Gets the value of the field <code>phone</code>.
     * @return the phone
     */
    public String[] getPhone() {
        return phone;
    }

    /**
     * Gets the value of the field <code>fax</code>.
     * @return the fax
     */
    public String[] getFax() {
        return fax;
    }

    /**
     * Gets the value of the field <code>bgsId</code>.
     * @return the bgsId
     */
    public String getBgsId() {
        return bgsId;
    }

    /**
     * Gets the value of the field <code>clearanceDate</code>.
     * @return the clearanceDate
     */
    public Date getClearanceDate() {
        return clearanceDate;
    }

    /**
     * Gets the value of the field <code>clearanceDate</code> as a formatted string.
     * @return the clearanceDate
     */
    public String getClearanceAsString() {
        return BinderUtils.formatDate(clearanceDate);
    }

    /**
     * Gets the value of the field <code>contactName</code>.
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * Sets the value of the field <code>contactName</code>.
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * Gets the value of the field <code>agencyId</code>.
     * @return the agencyId
     */
    public String getAgencyId() {
        return agencyId;
    }
}
