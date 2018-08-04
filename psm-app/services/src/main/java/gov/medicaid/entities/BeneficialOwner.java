/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Base class for beneficial owners of organizations.
 */
@javax.persistence.Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "beneficial_owner")
public abstract class BeneficialOwner implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "beneficial_owner_id")
    private long id;

    /**
     * Type of beneficial owner.
     */
    @ManyToOne
    @JoinColumn(name = "ben_type_cd")
    private BeneficialOwnerType type;

    /**
     * If type is other, specify description.
     */
    @Column(name = "oth_type_desc")
    private String typeDescription;

    /**
     * If type is owner, specify ownership percent.
     */
    @Column(name = "own_interest_pct")
    private BigDecimal ownershipInterest;

    /**
     * Beneficial owner address.
     */
    @ManyToOne
    @JoinColumn(name = "address_id")
    private Address address;

    /**
     * Indicates this owner has interest in other provider.
     */
    @Column(name = "oth_provider_interest_ind")
    private String otherProviderInterestInd;

    /**
     * Other provider name.
     */
    @Column(name = "oth_provider_name")
    private String otherProviderLegalName;

    /**
     * Other provider ownership interest.
     */
    @Column(name = "oth_provider_own_pct")
    private BigDecimal otherProviderOwnershipInterest;

    /**
     * Other provider address.
     */
    @ManyToOne
    @JoinColumn(name = "oth_provider_address_id")
    private Address otherProviderAddress;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public BeneficialOwnerType getType() {
        return type;
    }

    public void setType(BeneficialOwnerType type) {
        this.type = type;
    }

    public String getTypeDescription() {
        return typeDescription;
    }

    public void setTypeDescription(String typeDescription) {
        this.typeDescription = typeDescription;
    }

    public BigDecimal getOwnershipInterest() {
        return ownershipInterest;
    }

    public void setOwnershipInterest(BigDecimal ownershipInterest) {
        this.ownershipInterest = ownershipInterest;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getOtherProviderInterestInd() {
        return otherProviderInterestInd;
    }

    public void setOtherProviderInterestInd(String otherProviderInterestInd) {
        this.otherProviderInterestInd = otherProviderInterestInd;
    }

    public String getOtherProviderLegalName() {
        return otherProviderLegalName;
    }

    public void setOtherProviderLegalName(String otherProviderLegalName) {
        this.otherProviderLegalName = otherProviderLegalName;
    }

    public BigDecimal getOtherProviderOwnershipInterest() {
        return otherProviderOwnershipInterest;
    }

    public void setOtherProviderOwnershipInterest(BigDecimal otherProviderOwnershipInterest) {
        this.otherProviderOwnershipInterest = otherProviderOwnershipInterest;
    }

    public Address getOtherProviderAddress() {
        return otherProviderAddress;
    }

    public void setOtherProviderAddress(Address otherProviderAddress) {
        this.otherProviderAddress = otherProviderAddress;
    }
}
