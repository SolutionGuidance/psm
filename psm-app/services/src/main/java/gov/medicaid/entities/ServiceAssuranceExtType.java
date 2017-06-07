/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Represents the Assurance Statements lookup for Chemical Dependency Program.
 *
 * Note that the Chemical Dependency Program is MN-specific.
 */
@javax.persistence.Entity
@Table(name = "service_assurance_ext_types")
public class ServiceAssuranceExtType extends LookupEntity {

    @Id
    @Column(name = "code")
    private String serviceAssuranceCode;

    public ServiceAssuranceExtType() {
    }

    public String getServiceAssuranceCode() {
        return serviceAssuranceCode;
    }

    public void setServiceAssuranceCode(String serviceAssuranceCode) {
        this.serviceAssuranceCode = serviceAssuranceCode;
    }

}
