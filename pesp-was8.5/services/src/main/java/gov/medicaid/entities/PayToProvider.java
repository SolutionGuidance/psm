/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a pay-to provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class PayToProvider extends IdentifiableEntity {

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
     * The pay-to provider type.
     */
    private PayToProviderType type;

    /**
     * The target profile id.
     */
    private long targetProfileId;
    
    private String contactName;
    
    private String name;
    
    private String phone;
    
    private String npi;

    /**
     * Empty constructor.
     */
    public PayToProvider() {
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
     * @param effectiveDate the effectiveDate to set
     */
    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public PayToProviderType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(PayToProviderType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>targetProfileId</code>.
     *
     * @return the targetProfileId
     */
    public long getTargetProfileId() {
        return targetProfileId;
    }

    /**
     * Sets the value of the field <code>targetProfileId</code>.
     *
     * @param targetProfileId the targetProfileId to set
     */
    public void setTargetProfileId(long targetProfileId) {
        this.targetProfileId = targetProfileId;
    }

    /**
     * Gets the value of the field <code>contactName</code>.
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * Sets the value of the field <code>contactName</code>.
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>phone</code>.
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * Sets the value of the field <code>phone</code>.
     * @param phone the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }
}
