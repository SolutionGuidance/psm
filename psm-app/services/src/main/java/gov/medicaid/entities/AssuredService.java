/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents the Assured Statements from Chemical Dependency Program providers.
 *
 * @author cyberjag
 * @version 1.0
 */
public class AssuredService extends IdentifiableEntity {

    /**
     * The owning profile id.
     */
    private long profileId;

    /**
     * The owning ticket id.
     */
    private long ticketId;

    /**
     * The effective date.
     */
    private Date effectiveDate;

    /**
     * The service assurance type.
     */
    private ServiceAssuranceType type;

    /**
     * Represents the selected service assurance statements.
     */
    private List<ServiceAssuranceExtType> extendedTypes;

    /**
     * Represents the status.
     *
     * 1 - Initiate New, 2 - Continue Current, 3 - Terminate
     */
    private int status;

    /**
     * Empty constructor.
     */
    public AssuredService() {
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
     * @param profileId
     *            the profileId to set
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
     * @param ticketId
     *            the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * Gets the value of the field <code>effectiveDate</code>.
     *
     * @return the effectiveDate
     */
    public Date getEffectiveDate() {
        return effectiveDate;
    }

    /**
     * Sets the value of the field <code>effectiveDate</code>.
     *
     * @param effectiveDate
     *            the effectiveDate to set
     */
    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    /**
     * Gets the <code>type</code>.
     *
     * @return the type
     */
    public ServiceAssuranceType getType() {
        return type;
    }

    /**
     * Sets the <code>type</code>.
     *
     * @param type
     *            the type to set
     */
    public void setType(ServiceAssuranceType type) {
        this.type = type;
    }

    /**
     * Gets the <code>extendedTypes</code>.
     *
     * @return the extendedTypes
     */
    public List<ServiceAssuranceExtType> getExtendedTypes() {
        return extendedTypes;
    }

    /**
     * Sets the <code>extendedTypes</code>.
     *
     * @param extendedTypes
     *            the extendedTypes to set
     */
    public void setExtendedTypes(List<ServiceAssuranceExtType> extendedTypes) {
        this.extendedTypes = extendedTypes;
    }

    /**
     * Gets the <code>status</code>.
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * Sets the <code>status</code>.
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

}
