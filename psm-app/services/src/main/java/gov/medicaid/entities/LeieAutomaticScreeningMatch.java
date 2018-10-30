/*
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
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.time.LocalDate;

@Entity
@Table(name = "leie_automatic_screening_matches")
public class LeieAutomaticScreeningMatch {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "leie_automatic_screening_match_id")
    private long id;

    @ManyToOne
    @JoinColumn(
            name = "leie_automatic_screening_id",
            nullable = false
    )
    private LeieAutomaticScreening leieAutomaticScreening;

    @Column(
            name = "resource_url",
            nullable = false
    )
    private String resourceUrl;

    private String npi;

    private String upin;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "middle_name")
    private String middleName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "business_name")
    private String businessName;

    private String address;

    private String city;

    private String state;

    @Column(name = "zip_code")
    private String zipCode;

    @Column(name = "born_at")
    private LocalDate dateOfBirth;

    @Column(name = "excluded_at")
    private LocalDate excludedAt;

    @Column(name = "exclusion_type")
    private String exclusionType;

    private String general;

    private String speciality;

    @Column(name = "reinstated_at")
    private LocalDate reinstantedAt;

    @Column(name = "waived_at")
    private LocalDate waivedAt;

    @Column(name = "waiver_state")
    private String waiverState;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LeieAutomaticScreening getLeieAutomaticScreening() {
        return leieAutomaticScreening;
    }

    public void setLeieAutomaticScreening(LeieAutomaticScreening leieAutomaticScreening) {
        this.leieAutomaticScreening = leieAutomaticScreening;
    }

    public String getResourceUrl() {
        return resourceUrl;
    }

    public void setResourceUrl(String resourceUrl) {
        this.resourceUrl = resourceUrl;
    }

    public String getNpi() {
        return npi;
    }

    public void setNpi(String npi) {
        this.npi = npi;
    }

    public String getUpin() {
        return upin;
    }

    public void setUpin(String upin) {
        this.upin = upin;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public LocalDate getExcludedAt() {
        return excludedAt;
    }

    public void setExcludedAt(LocalDate excludedAt) {
        this.excludedAt = excludedAt;
    }

    public String getExclusionType() {
        return exclusionType;
    }

    public void setExclusionType(String exclusionType) {
        this.exclusionType = exclusionType;
    }

    public String getGeneral() {
        return general;
    }

    public void setGeneral(String general) {
        this.general = general;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public LocalDate getReinstantedAt() {
        return reinstantedAt;
    }

    public void setReinstantedAt(LocalDate reinstantedAt) {
        this.reinstantedAt = reinstantedAt;
    }

    public LocalDate getWaivedAt() {
        return waivedAt;
    }

    public void setWaivedAt(LocalDate waivedAt) {
        this.waivedAt = waivedAt;
    }

    public String getWaiverState() {
        return waiverState;
    }

    public void setWaiverState(String waiverState) {
        this.waiverState = waiverState;
    }
}
