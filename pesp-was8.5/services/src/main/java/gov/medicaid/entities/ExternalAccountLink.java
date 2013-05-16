/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a link to an external user.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ExternalAccountLink extends IdentifiableEntity {

    /**
     * The user id.
     */
    private String userId;

    /**
     * The external system id.
     */
    private SystemId systemId;

    /**
     * The external user id.
     */
    private String externalUserId;

    /**
     * Empty constructor.
     */
    public ExternalAccountLink() {

    }

    /**
     * Gets the value of the field <code>userId</code>.
     *
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Sets the value of the field <code>userId</code>.
     *
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * Gets the value of the field <code>externalUserId</code>.
     *
     * @return the externalUserId
     */
    public String getExternalUserId() {
        return externalUserId;
    }

    /**
     * Sets the value of the field <code>externalUserId</code>.
     *
     * @param externalUserId the externalUserId to set
     */
    public void setExternalUserId(String externalUserId) {
        this.externalUserId = externalUserId;
    }

    /**
     * Gets the value of the field <code>systemId</code>.
     *
     * @return the systemId
     */
    public SystemId getSystemId() {
        return systemId;
    }

    /**
     * Sets the value of the field <code>systemId</code>.
     *
     * @param systemId the systemId to set
     */
    public void setSystemId(SystemId systemId) {
        this.systemId = systemId;
    }
}
