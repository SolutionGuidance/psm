/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.LookupEntity;

/**
 * This represents the source statistics.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class SourceStats extends LookupEntity {

    /**
     * The number of successfully completed requests.
     */
    private long successRequests;

    /**
     * The number of HTTP Page Not Found responses received.
     */
    private long pageNotFoundRequests;

    /**
     * The number of HTTP Page Modified responses received.
     */
    private long pageChangedRequests;

    /**
     * The number of HTTP Error responses received.
     */
    private long serverErrorRequests;

    /**
     * Calculated reliability.
     */
    private double reliability;

    /**
     * Default empty constructor.
     */
    public SourceStats() {
    }

    /**
     * Gets the value of the field <code>successRequests</code>.
     *
     * @return the successRequests
     */
    public long getSuccessRequests() {
        return successRequests;
    }

    /**
     * Sets the value of the field <code>successRequests</code>.
     *
     * @param successRequests the successRequests to set
     */
    public void setSuccessRequests(long successRequests) {
        this.successRequests = successRequests;
    }

    /**
     * Gets the value of the field <code>pageNotFoundRequests</code>.
     *
     * @return the pageNotFoundRequests
     */
    public long getPageNotFoundRequests() {
        return pageNotFoundRequests;
    }

    /**
     * Sets the value of the field <code>pageNotFoundRequests</code>.
     *
     * @param pageNotFoundRequests the pageNotFoundRequests to set
     */
    public void setPageNotFoundRequests(long pageNotFoundRequests) {
        this.pageNotFoundRequests = pageNotFoundRequests;
    }

    /**
     * Gets the value of the field <code>pageChangedRequests</code>.
     *
     * @return the pageChangedRequests
     */
    public long getPageChangedRequests() {
        return pageChangedRequests;
    }

    /**
     * Sets the value of the field <code>pageChangedRequests</code>.
     *
     * @param pageChangedRequests the pageChangedRequests to set
     */
    public void setPageChangedRequests(long pageChangedRequests) {
        this.pageChangedRequests = pageChangedRequests;
    }

    /**
     * Gets the value of the field <code>serverErrorRequests</code>.
     *
     * @return the serverErrorRequests
     */
    public long getServerErrorRequests() {
        return serverErrorRequests;
    }

    /**
     * Sets the value of the field <code>serverErrorRequests</code>.
     *
     * @param serverErrorRequests the serverErrorRequests to set
     */
    public void setServerErrorRequests(long serverErrorRequests) {
        this.serverErrorRequests = serverErrorRequests;
    }

    /**
     * Gets the value of the field <code>reliability</code>.
     *
     * @return the reliability
     */
    public double getReliability() {
        return reliability;
    }

    /**
     * Sets the value of the field <code>reliability</code>.
     *
     * @param reliability the reliability to set
     */
    public void setReliability(double reliability) {
        this.reliability = reliability;
    }
}
