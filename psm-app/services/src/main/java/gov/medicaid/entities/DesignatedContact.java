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
 * Represents a designated contact.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DesignatedContact extends IdentifiableEntity {

    /**
     * The owner profile.
     */
    private long profileId;

    /**
     * The owner ticket.
     */
    private long ticketId;

    /**
     * The contact type.
     */
    private DesignatedContactType type;

    /**
     * Use the same contact details as the provider profile.
     */
    private String sameAsProvider;

    /**
     * Designee hire date.
     */
    private Date hireDate;

    /**
     * The designated person.
     */
    private Person person;

    /**
     * Empty constructor.
     */
    public DesignatedContact() {
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
     * Sets the value of the field <code>profileId</code>.
     *
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     *
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     *
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public DesignatedContactType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(DesignatedContactType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>person</code>.
     *
     * @return the person
     */
    public Person getPerson() {
        return person;
    }

    /**
     * Sets the value of the field <code>person</code>.
     *
     * @param person the person to set
     */
    public void setPerson(Person person) {
        this.person = person;
    }

    /**
     * Gets the value of the field <code>sameAsProvider</code>.
     *
     * @return the sameAsProvider
     */
    public String getSameAsProvider() {
        return sameAsProvider;
    }

    /**
     * Sets the value of the field <code>sameAsProvider</code>.
     *
     * @param sameAsProvider the sameAsProvider to set
     */
    public void setSameAsProvider(String sameAsProvider) {
        this.sameAsProvider = sameAsProvider;
    }

    /**
     * Gets the value of the field <code>hireDate</code>.
     * @return the hireDate
     */
    public Date getHireDate() {
        return hireDate;
    }

    /**
     * Sets the value of the field <code>hireDate</code>.
     * @param hireDate the hireDate to set
     */
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
}
