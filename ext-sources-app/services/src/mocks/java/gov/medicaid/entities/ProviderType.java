/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.List;

/**
 * Represents a provider type.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ProviderType extends IdentifiableEntity {

    /**
     * Type name.
     */
    private String name;

    /**
     * Private office flag.
     */
    private boolean hasPrivateOffice;

    /**
     * Employed or contracted flag.
     */
    private boolean employedAndOrContracted;

    /**
     * Additional practice flag.
     */
    private boolean hasAdditionalPractice;

    /**
     * Payment required.
     */
    private boolean paymentRequired;

    /**
     * Required fields.
     */
    private List<RequiredField> requiredFields;

    /**
     * The agreements.
     */
    private List<AgreementDocument> agreements;

    /**
     * The addendums.
     */
    private List<AgreementDocument> addendums;

    /**
     * Default empty constructor.
     */
    public ProviderType() {
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>hasPrivateOffice</code>.
     *
     * @return the hasPrivateOffice
     */
    public boolean isHasPrivateOffice() {
        return hasPrivateOffice;
    }

    /**
     * Sets the value of the field <code>hasPrivateOffice</code>.
     *
     * @param hasPrivateOffice the hasPrivateOffice to set
     */
    public void setHasPrivateOffice(boolean hasPrivateOffice) {
        this.hasPrivateOffice = hasPrivateOffice;
    }

    /**
     * Gets the value of the field <code>employedAndOrContracted</code>.
     *
     * @return the employedAndOrContracted
     */
    public boolean isEmployedAndOrContracted() {
        return employedAndOrContracted;
    }

    /**
     * Sets the value of the field <code>employedAndOrContracted</code>.
     *
     * @param employedAndOrContracted the employedAndOrContracted to set
     */
    public void setEmployedAndOrContracted(boolean employedAndOrContracted) {
        this.employedAndOrContracted = employedAndOrContracted;
    }

    /**
     * Gets the value of the field <code>hasAdditionalPractice</code>.
     *
     * @return the hasAdditionalPractice
     */
    public boolean isHasAdditionalPractice() {
        return hasAdditionalPractice;
    }

    /**
     * Sets the value of the field <code>hasAdditionalPractice</code>.
     *
     * @param hasAdditionalPractice the hasAdditionalPractice to set
     */
    public void setHasAdditionalPractice(boolean hasAdditionalPractice) {
        this.hasAdditionalPractice = hasAdditionalPractice;
    }

    /**
     * Gets the value of the field <code>paymentRequired</code>.
     *
     * @return the paymentRequired
     */
    public boolean isPaymentRequired() {
        return paymentRequired;
    }

    /**
     * Sets the value of the field <code>paymentRequired</code>.
     *
     * @param paymentRequired the paymentRequired to set
     */
    public void setPaymentRequired(boolean paymentRequired) {
        this.paymentRequired = paymentRequired;
    }

    /**
     * Gets the value of the field <code>requiredFields</code>.
     *
     * @return the requiredFields
     */
    public List<RequiredField> getRequiredFields() {
        return requiredFields;
    }

    /**
     * Sets the value of the field <code>requiredFields</code>.
     *
     * @param requiredFields the requiredFields to set
     */
    public void setRequiredFields(List<RequiredField> requiredFields) {
        this.requiredFields = requiredFields;
    }

	/**
	 * Getter of the agreements.
	 *
	 * @return the agreements
	 */
	public List<AgreementDocument> getAgreements() {
		return agreements;
	}

	/**
	 * Setter of the agreements.
	 *
	 * @param agreements the agreements to set
	 */
	public void setAgreements(List<AgreementDocument> agreements) {
		this.agreements = agreements;
	}

	/**
	 * Getter of the addendums.
	 *
	 * @return the addendums
	 */
	public List<AgreementDocument> getAddendums() {
		return addendums;
	}

	/**
	 * Setter of the addendums.
	 *
	 * @param addendums the addendums to set
	 */
	public void setAddendums(List<AgreementDocument> addendums) {
		this.addendums = addendums;
	}
}
