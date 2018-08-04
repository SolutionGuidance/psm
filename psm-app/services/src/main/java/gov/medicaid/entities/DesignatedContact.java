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

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@javax.persistence.Entity
@Table(name = "designated_contacts")
public class DesignatedContact implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "designated_contact_id")
    private long id;

    /**
     * The owner profile.
     */
    @Column(name = "profile_id")
    private long profileId;

    @Enumerated(EnumType.STRING)
    @Column(name = "designated_contact_type")
    private DesignatedContactType type;

    /**
     * Use the same contact details as the provider profile.
     */
    @Column(name = "same_as_provider")
    private String sameAsProvider;

    /**
     * Designee hire date.
     */
    @Column(name = "hired_at")
    private Date hireDate;

    /**
     * The designated person.
     */
    @ManyToOne
    @JoinColumn(name = "person_id")
    private Person person;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
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
