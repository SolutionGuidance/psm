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
 * Projection results from search of enrolled providers.
 */
public class ProviderLookup {

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
     * Practice name.
     */
    private String name;

    /**
     * ProviderType.
     */
    private String providerType;

    /**
     * Contact person name.
     */
    private String contactName;

    /**
     * Contact person phone.
     */
    private String phone1;

    /**
     * Contact person phone.
     */
    private String phone2;

    /**
     * Contact person phone.
     */
    private String phone3;

    /**
     * Contact person phone.
     */
    private String phone4;

    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param npi assigned to the field with the same name
     * @param name assigned to the field with the same name
     */
    public ProviderLookup(long profileId, String npi, String name, String providerType) {
        super();
        this.profileId = profileId;
        this.npi = npi;
        this.name = name;
        this.providerType = providerType;
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
     * Gets the value of the field <code>profileIdHash</code>.
     * @return the profileIdHash
     */
    public String getProfileIdHash() {
        return profileIdHash;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>profileIdHash</code>.
     * @param profileIdHash the profileIdHash to set
     */
    public void setProfileIdHash(String profileIdHash) {
        this.profileIdHash = profileIdHash;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Gets the value of the field <code>contactName</code>.
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * Gets the value of the field <code>phone1</code>.
     * @return the phone1
     */
    public String getPhone1() {
        return phone1;
    }

    /**
     * Gets the value of the field <code>phone2</code>.
     * @return the phone2
     */
    public String getPhone2() {
        return phone2;
    }

    /**
     * Gets the value of the field <code>phone3</code>.
     * @return the phone3
     */
    public String getPhone3() {
        return phone3;
    }

    /**
     * Gets the value of the field <code>phone4</code>.
     * @return the phone4
     */
    public String getPhone4() {
        return phone4;
    }

    /**
     * Sets the value of the field <code>contactName</code>.
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * Sets the value of the field <code>phone1</code>.
     * @param phone1 the phone1 to set
     */
    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    /**
     * Sets the value of the field <code>phone2</code>.
     * @param phone2 the phone2 to set
     */
    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    /**
     * Sets the value of the field <code>phone3</code>.
     * @param phone3 the phone3 to set
     */
    public void setPhone3(String phone3) {
        this.phone3 = phone3;
    }

    /**
     * Sets the value of the field <code>phone4</code>.
     * @param phone4 the phone4 to set
     */
    public void setPhone4(String phone4) {
        this.phone4 = phone4;
    }
}
