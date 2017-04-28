/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;
import java.util.List;

/**
 * This entity holds data of SAMSearch web service response.
 *
 * @author flexme
 * @version 1.0
 */
public class SAMResponse implements Serializable {
    /**
     * Represents the name.
     */
    private String name;
    /**
     * Represents the classification.
     */
    private String classification;
    /**
     * Represents the exclusion type.
     */
    private String exclusionType;
    /**
     * Represents the actions.
     */
    private List<SAMAction> actions;
    /**
     * Represents the addresses.
     */
    private List<SAMAddress> addresses;
    /**
     * Represents the agencies.
     */
    private List<SAMAgency> agencies;
    /**
     * Represents the descriptions.
     */
    private List<String> descriptions;
    /**
     * Represents the references.
     */
    private List<SAMReference> references;

    /**
     * Empty constructor.
     */
    public SAMResponse() {
    }

    /**
     * Gets the name.
     *
     * @return the name.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name.
     *
     * @param name the name.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the classification.
     *
     * @return the classification.
     */
    public String getClassification() {
        return classification;
    }

    /**
     * Sets the classification.
     *
     * @param classification the classification.
     */
    public void setClassification(String classification) {
        this.classification = classification;
    }

    /**
     * Gets the exclustion type.
     *
     * @return the exclustion type.
     */
    public String getExclusionType() {
        return exclusionType;
    }

    /**
     * Sets the exclustion type.
     *
     * @param exclusionType the exclustion type.
     */
    public void setExclusionType(String exclusionType) {
        this.exclusionType = exclusionType;
    }

    /**
     * Gets the actions.
     *
     * @return the actions.
     */
    public List<SAMAction> getActions() {
        return actions;
    }

    /**
     * Sets the actions.
     *
     * @param actions the actions.
     */
    public void setActions(List<SAMAction> actions) {
        this.actions = actions;
    }

    /**
     * Gets the addresses.
     *
     * @return the addresses.
     */
    public List<SAMAddress> getAddresses() {
        return addresses;
    }

    /**
     * Sets the addresses.
     *
     * @param addresses the addresses.
     */
    public void setAddresses(List<SAMAddress> addresses) {
        this.addresses = addresses;
    }

    /**
     * Gets the agencies.
     *
     * @return the agencies.
     */
    public List<SAMAgency> getAgencies() {
        return agencies;
    }

    /**
     * Sets the agencies.
     * @param agencies the agencies.
     */
    public void setAgencies(List<SAMAgency> agencies) {
        this.agencies = agencies;
    }

    /**
     * Gets the descriptions.
     *
     * @return the descriptions.
     */
    public List<String> getDescriptions() {
        return descriptions;
    }

    /**
     * Sets the descriptions.
     *
     * @param descriptions the descriptions.
     */
    public void setDescriptions(List<String> descriptions) {
        this.descriptions = descriptions;
    }

    /**
     * Gets the references.
     *
     * @return the references.
     */
    public List<SAMReference> getReferences() {
        return references;
    }

    /**
     * Sets the references.
     *
     * @param references the references.
     */
    public void setReferences(List<SAMReference> references) {
        this.references = references;
    }
}
