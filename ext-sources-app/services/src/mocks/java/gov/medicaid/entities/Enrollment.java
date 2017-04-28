/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents an enrollment.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Enrollment extends AuditableEntity {

    /**
     * Status.
     */
    private EnrollmentStatus status;

    /**
     * Start date.
     */
    private Date startDate;

    /**
     * Expiration date.
     */
    private Date expireDate;

    /**
     * Renewal flag.
     */
    private boolean isRenewal;

    /**
     * User.
     */
    private User user;

    /**
     * Appeal.
     */
    private Appeal appeal;

    /**
     * Denial reason.
     */
    private String denialReason;

    /**
     * Default empty constructor.
     */
    public Enrollment() {
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public EnrollmentStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(EnrollmentStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>startDate</code>.
     *
     * @return the startDate
     */
    public Date getStartDate() {
        return startDate;
    }

    /**
     * Sets the value of the field <code>startDate</code>.
     *
     * @param startDate the startDate to set
     */
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    /**
     * Gets the value of the field <code>expireDate</code>.
     *
     * @return the expireDate
     */
    public Date getExpireDate() {
        return expireDate;
    }

    /**
     * Sets the value of the field <code>expireDate</code>.
     *
     * @param expireDate the expireDate to set
     */
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    /**
     * Gets the value of the field <code>isRenewal</code>.
     *
     * @return the isRenewal
     */
    public boolean isRenewal() {
        return isRenewal;
    }

    /**
     * Sets the value of the field <code>isRenewal</code>.
     *
     * @param isRenewal the isRenewal to set
     */
    public void setRenewal(boolean isRenewal) {
        this.isRenewal = isRenewal;
    }

    /**
     * Gets the value of the field <code>user</code>.
     *
     * @return the user
     */
    public User getUser() {
        return user;
    }

    /**
     * Sets the value of the field <code>user</code>.
     *
     * @param user the user to set
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * Gets the value of the field <code>appeal</code>.
     *
     * @return the appeal
     */
    public Appeal getAppeal() {
        return appeal;
    }

    /**
     * Sets the value of the field <code>appeal</code>.
     *
     * @param appeal the appeal to set
     */
    public void setAppeal(Appeal appeal) {
        this.appeal = appeal;
    }

    /**
     * Gets the value of the field <code>denialReason</code>.
     *
     * @return the denialReason
     */
    public String getDenialReason() {
        return denialReason;
    }

    /**
     * Sets the value of the field <code>denialReason</code>.
     *
     * @param denialReason the denialReason to set
     */
    public void setDenialReason(String denialReason) {
        this.denialReason = denialReason;
    }
}
