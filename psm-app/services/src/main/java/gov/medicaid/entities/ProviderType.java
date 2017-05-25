/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.entities;

import gov.medicaid.domain.model.ApplicantType;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Represents a provider type.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@javax.persistence.Entity
@Table(name = "provider_types")
public class ProviderType extends LookupEntity {

    /**
     * Individual or organization.
     */
    @Column(
            name = "applicant_type",
            nullable = false
    )
    @Enumerated(EnumType.STRING)
    private ApplicantType applicantType = ApplicantType.INDIVIDUAL;

    /**
     * Flag to delete or not.
     */
    @Transient
    private boolean canDelete;

   /**
     * Default empty constructor.
     */
    public ProviderType() {
    }

   /**
     * Gets the value of the field <code>applicantType</code>.
     * @return the applicantType
     */
    public ApplicantType getApplicantType() {
        return applicantType;
    }

    /**
     * Sets the value of the field <code>applicantType</code>.
     * @param applicantType the applicantType to set
     */
    public void setApplicantType(ApplicantType applicantType) {
        this.applicantType = applicantType;
    }

	public boolean isCanDelete() {
		return canDelete;
	}

	public void setCanDelete(boolean canDelete) {
		this.canDelete = canDelete;
	}

}
