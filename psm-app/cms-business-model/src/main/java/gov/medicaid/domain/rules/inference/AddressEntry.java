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

package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.AddressType;

/**
 * This class is used by the rules to perform validation on an address within a context, since an address may appear in
 * different levels of a profile.
 */
public class AddressEntry {

    /**
     * The address to be checked.
     */
    private final AddressType address;

    /**
     * Practice, Billing, Reimbursement, etc.
     */
    private String type;

    /**
     * The path to this address.
     */
    private String path;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnCity;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnState;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnCounty;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnZip;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnLine1;

    /**
     * Prevents multiple errors tagged on the same address field.
     */
    private String errorOnLine2;

    /**
     * Creates a new instance using the given entity.
     *
     * @param type the phone number type
     * @param path the path to the field
     * @param address the value
     */
    public AddressEntry(String type, String path, AddressType address) {
        this.type = type;
        this.path = path;
        this.address = address;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>path</code>.
     *
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * Sets the value of the field <code>path</code>.
     *
     * @param path the path to set
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Gets the value of the field <code>address</code>.
     *
     * @return the address
     */
    public AddressType getAddress() {
        return address;
    }

    /**
     * Gets the value of the field <code>errorOnCity</code>.
     * @return the errorOnCity
     */
    public String getErrorOnCity() {
        return errorOnCity;
    }

    /**
     * Sets the value of the field <code>errorOnCity</code>.
     * @param errorOnCity the errorOnCity to set
     */
    public void setErrorOnCity(String errorOnCity) {
        this.errorOnCity = errorOnCity;
    }

    /**
     * Gets the value of the field <code>errorOnState</code>.
     * @return the errorOnState
     */
    public String getErrorOnState() {
        return errorOnState;
    }

    /**
     * Sets the value of the field <code>errorOnState</code>.
     * @param errorOnState the errorOnState to set
     */
    public void setErrorOnState(String errorOnState) {
        this.errorOnState = errorOnState;
    }

    /**
     * Gets the value of the field <code>errorOnZip</code>.
     * @return the errorOnZip
     */
    public String getErrorOnZip() {
        return errorOnZip;
    }

    /**
     * Sets the value of the field <code>errorOnZip</code>.
     * @param errorOnZip the errorOnZip to set
     */
    public void setErrorOnZip(String errorOnZip) {
        this.errorOnZip = errorOnZip;
    }

    /**
     * Gets the value of the field <code>errorOnLine1</code>.
     * @return the errorOnLine1
     */
    public String getErrorOnLine1() {
        return errorOnLine1;
    }

    /**
     * Sets the value of the field <code>errorOnLine1</code>.
     * @param errorOnLine1 the errorOnLine1 to set
     */
    public void setErrorOnLine1(String errorOnLine1) {
        this.errorOnLine1 = errorOnLine1;
    }

    /**
     * Gets the value of the field <code>errorOnLine2</code>.
     * @return the errorOnLine2
     */
    public String getErrorOnLine2() {
        return errorOnLine2;
    }

    /**
     * Sets the value of the field <code>errorOnLine2</code>.
     * @param errorOnLine2 the errorOnLine2 to set
     */
    public void setErrorOnLine2(String errorOnLine2) {
        this.errorOnLine2 = errorOnLine2;
    }

    /**
     * Gets the value of the field <code>errorOnCounty</code>.
     * @return the errorOnCounty
     */
    public String getErrorOnCounty() {
        return errorOnCounty;
    }

    /**
     * Sets the value of the field <code>errorOnCounty</code>.
     * @param errorOnCounty the errorOnCounty to set
     */
    public void setErrorOnCounty(String errorOnCounty) {
        this.errorOnCounty = errorOnCounty;
    }
}
