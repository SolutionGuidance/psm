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
 * Represents the contact information.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ContactInformation extends IdentifiableEntity {

    /**
     * The phone number.
     */
    private String phoneNumber;

    /**
     * The fax number.
     */
    private String faxNumber;

    /**
     * The email.
     */
    private String email;

    /**
     * The address.
     */
    private Address address;

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     *
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }

    /**
     * Sets the value of the field <code>phoneNumber</code>.
     *
     * @param phoneNumber the phoneNumber to set
     */
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /**
     * Gets the value of the field <code>faxNumber</code>.
     *
     * @return the faxNumber
     */
    public String getFaxNumber() {
        return faxNumber;
    }

    /**
     * Sets the value of the field <code>faxNumber</code>.
     *
     * @param faxNumber the faxNumber to set
     */
    public void setFaxNumber(String faxNumber) {
        this.faxNumber = faxNumber;
    }

    /**
     * Gets the value of the field <code>email</code>.
     *
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the value of the field <code>email</code>.
     *
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the value of the field <code>address</code>.
     *
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Sets the value of the field <code>address</code>.
     *
     * @param address the address to set
     */
    public void setAddress(Address address) {
        this.address = address;
    }
}
