/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the Assurance Statements lookup for Chemical Dependency Program.
 * 
 * @author cyberjag
 * @version 1.0
 */
public class ServiceAssuranceType extends LookupEntity {
    /**
     * Represents the IN/OUT Patient indicator.
     */
    private String patientInd;

    /**
     * Empty constructor.
     */
    public ServiceAssuranceType() {
    }

    /**
     * Gets the patientInd.
     * 
     * @return the patientInd
     */
    public String getPatientInd() {
        return patientInd;
    }

    /**
     * Sets the patiend indicator.
     * 
     * @param patientInd
     *            the patientInd
     */
    public void setPatientInd(String patientInd) {
        this.patientInd = patientInd;
    }
}
