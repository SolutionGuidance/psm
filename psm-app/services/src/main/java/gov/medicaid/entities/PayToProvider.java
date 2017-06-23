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
 * Represents a pay-to provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
import javax.persistence.*;
import java.io.Serializable;

@javax.persistence.Entity
@Table(name = "pay_to_providers")
public class PayToProvider implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "pay_to_providers_id")
    private long id;

    /**
     * The owning profile id.
     */
    @Column(name = "profile_id")
    private long profileId;

    /**
     * The owning ticket id.
     */
    @Column(name = "ticket_id")
    private long ticketId;

    /**
     * The effective date.
     */
    @Column(name = "effective_date")
    private Date effectiveDate;

    /**
     * The pay-to provider type.
     */
    @ManyToOne
    @JoinColumn(name = "pay_to_type_code")
    private PayToProviderType type;

    /**
     * The target profile id.
     */
    @Column(name = "target_profile_id")
    private long targetProfileId;

    @Column(name = "contact_name")
    private String contactName;

    @Column
    private String name;

    @Column
    private String phone;

    @Column
    private String npi;

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

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public PayToProviderType getType() {
        return type;
    }

    public void setType(PayToProviderType type) {
        this.type = type;
    }

    public long getTargetProfileId() {
        return targetProfileId;
    }

    public void setTargetProfileId(long targetProfileId) {
        this.targetProfileId = targetProfileId;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNpi() {
        return npi;
    }

    public void setNpi(String npi) {
        this.npi = npi;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
