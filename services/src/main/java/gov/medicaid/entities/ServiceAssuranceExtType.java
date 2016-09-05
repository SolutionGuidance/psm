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
public class ServiceAssuranceExtType extends LookupEntity {

    /**
     * Represents the service assurance code.
     */
    private String serviceAssuranceCode;

    /**
     * Empty constructor.
     */
    public ServiceAssuranceExtType() {
    }

    /**
     * Gets the service assurance code.
     * 
     * @return serviceAssuranceCode
     */
    public String getServiceAssuranceCode() {
        return serviceAssuranceCode;
    }

    /**
     * Sets the service assurance code.
     * 
     * @param serviceAssuranceCode
     *            serviceAssuranceCode
     */
    public void setServiceAssuranceCode(String serviceAssuranceCode) {
        this.serviceAssuranceCode = serviceAssuranceCode;
    }

}
