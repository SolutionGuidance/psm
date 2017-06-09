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

public class DesignatedContact extends IdentifiableEntity {

    /**
     * The owner profile.
     */
    private long profileId;

    /**
     * The owner ticket.
     */
    private long ticketId;

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

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    public DesignatedContactType getType() {
        return type;
    }

    public void setType(DesignatedContactType type) {
        this.type = type;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public String getSameAsProvider() {
        return sameAsProvider;
    }

    public void setSameAsProvider(String sameAsProvider) {
        this.sameAsProvider = sameAsProvider;
    }

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
}
