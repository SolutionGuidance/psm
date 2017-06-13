/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Represents the Assured Statements from Chemical Dependency Program providers.
 *
 * @author cyberjag
 * @version 1.0
 */

@javax.persistence.Entity
@Table(name = "assured_services")
public class AssuredService implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "assured_service_id")
    private long id;

    @Column(name = "profile_id")
    private long profileId;

    @Column(name="ticket_id")
    private long ticketId;

    @Column(name = "effective_date")
    private Date effectiveDate;

    @ManyToOne
    @JoinColumn(name = "service_assurance_code")
    private ServiceAssuranceType type;

    @OneToMany
    @JoinColumn(name = "service_assurance_code", referencedColumnName = "service_assurance_code")
    private List<ServiceAssuranceExtType> extendedTypes;

    /**
     * Represents the status.
     *
     * 1 - Initiate New, 2 - Continue Current, 3 - Terminate
     */
    private int status;


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

    public ServiceAssuranceType getType() {
        return type;
    }

    public void setType(ServiceAssuranceType type) {
        this.type = type;
    }

    public List<ServiceAssuranceExtType> getExtendedTypes() {
        return extendedTypes;
    }

    public void setExtendedTypes(List<ServiceAssuranceExtType> extendedTypes) {
        this.extendedTypes = extendedTypes;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
