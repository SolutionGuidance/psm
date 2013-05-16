/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents an event.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class Event extends IdentifiableEntity {

    /**
     * The ticket id.
     */
    private long ticketId;

    /** The NPI. */
    private String npi;

    /** The status. */
    private String status;

    /**
     * Creator.
     */
    private String createdBy;

    /**
     * Timestamp.
     */
    private Date createdOn;

    /**
     * Default empty constructor.
     */
    public Event() {
    }

    /**
     * Get the Npi.
     *
     * @return the Npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Set the Npi.
     *
     * @param npi to be set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }

    /**
     * Get the status.
     *
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Set the status.
     *
     * @param status the status to be set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     * @return the createdBy
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     * @param createdBy the createdBy to set
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>createdOn</code>.
     * @return the createdOn
     */
    public Date getCreatedOn() {
        return createdOn;
    }

    /**
     * Sets the value of the field <code>createdOn</code>.
     * @param createdOn the createdOn to set
     */
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }
}
