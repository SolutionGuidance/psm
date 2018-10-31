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

package gov.medicaid.process.application;

import ca.uhn.fhir.model.api.annotation.Child;
import ca.uhn.fhir.model.api.annotation.ResourceDef;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.entities.LeieAutomaticScreeningMatch;
import org.apache.commons.lang3.tuple.Pair;
import org.hl7.fhir.dstu3.model.DateType;
import org.hl7.fhir.dstu3.model.IntegerType;
import org.hl7.fhir.dstu3.model.PrimitiveType;
import org.hl7.fhir.dstu3.model.Resource;
import org.hl7.fhir.dstu3.model.ResourceType;
import org.hl7.fhir.dstu3.model.StringType;
import org.hl7.fhir.instance.model.api.IPrimitiveType;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Model an entry in the Office of Inspector General's (OIG) List of Excluded
 * Individuals/Entities (LEIE) in terms of the HAPI-FHIR library to enable it to
 * talk to the LEIE API, defined elsewhere in this repository.
 *
 * @see <a href="https://oig.hhs.gov/exclusions/">OIG Exclusions Program</a>
 * @see <a href="http://hapifhir.io/doc_custom_structures.html">HAPI-FHIR Custom Structures</a>
 */
@SuppressWarnings("unused") // HAPI-FHIR reflectively calls getters & setters
@ResourceDef(name = "Exclusion")
public class Exclusion extends Resource {
    @Child(name = "address")
    private StringType address;
    @Child(name = "busname")
    private StringType businessName;
    @Child(name = "city")
    private StringType city;
    @Child(name = "dob")
    private DateType dateOfBirth;
    @Child(name = "excldate")
    private DateType exclusionDate;
    @Child(name = "excltype")
    private StringType exclusionType;
    @Child(name = "firstname")
    private StringType firstName;
    @Child(name = "general")
    private StringType general;
    @Child(name = "lastname")
    private StringType lastName;
    @Child(name = "midname")
    private StringType middleName;
    @Child(name = "npi")
    private IntegerType npi;
    @Child(name = "reindate")
    private DateType reinDate;
    @Child(name = "specialty")
    private StringType specialty;
    @Child(name = "state")
    private StringType state;
    @Child(name = "upin")
    private StringType upin;
    @Child(name = "waiverdate")
    private DateType waiverDate;
    @Child(name = "waiverstate")
    private StringType waiverState;
    @Child(name = "zip")
    private StringType zip;

    public StringType getAddress() {
        return address;
    }

    public void setAddress(StringType address) {
        this.address = address;
    }

    public StringType getBusinessName() {
        return businessName;
    }

    public void setBusinessName(StringType businessName) {
        this.businessName = businessName;
    }

    public StringType getCity() {
        return city;
    }

    public void setCity(StringType city) {
        this.city = city;
    }

    public DateType getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(DateType dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public DateType getExclusionDate() {
        return exclusionDate;
    }

    public void setExclusionDate(DateType exclusionDate) {
        this.exclusionDate = exclusionDate;
    }

    public StringType getExclusionType() {
        return exclusionType;
    }

    public void setExclusionType(StringType exclusionType) {
        this.exclusionType = exclusionType;
    }

    public StringType getFirstName() {
        return firstName;
    }

    public void setFirstName(StringType firstName) {
        this.firstName = firstName;
    }

    public StringType getGeneral() {
        return general;
    }

    public void setGeneral(StringType general) {
        this.general = general;
    }

    public StringType getLastName() {
        return lastName;
    }

    public void setLastName(StringType lastName) {
        this.lastName = lastName;
    }

    public StringType getMiddleName() {
        return middleName;
    }

    public void setMiddleName(StringType middleName) {
        this.middleName = middleName;
    }

    public IntegerType getNpi() {
        return npi;
    }

    public void setNpi(IntegerType npi) {
        this.npi = npi;
    }

    public DateType getReinDate() {
        return reinDate;
    }

    public void setReinDate(DateType reinDate) {
        this.reinDate = reinDate;
    }

    public StringType getSpecialty() {
        return specialty;
    }

    public void setSpecialty(StringType specialty) {
        this.specialty = specialty;
    }

    public StringType getState() {
        return state;
    }

    public void setState(StringType state) {
        this.state = state;
    }

    public StringType getUpin() {
        return upin;
    }

    public void setUpin(StringType upin) {
        this.upin = upin;
    }

    public DateType getWaiverDate() {
        return waiverDate;
    }

    public void setWaiverDate(DateType waiverDate) {
        this.waiverDate = waiverDate;
    }

    public StringType getWaiverState() {
        return waiverState;
    }

    public void setWaiverState(StringType waiverState) {
        this.waiverState = waiverState;
    }

    public StringType getZip() {
        return zip;
    }

    public void setZip(StringType zip) {
        this.zip = zip;
    }

    @Override
    public Resource copy() {
        return null;
    }

    @Override
    public ResourceType getResourceType() {
        return null;
    }

    PropertyListType toPropertyList() {
        PropertyListType propertyListType = new PropertyListType();
        List<Pair<String, IPrimitiveType>> properties = Arrays.asList(
                Pair.of("NPI", npi),
                Pair.of("UPIN", upin),
                Pair.of("First Name", firstName),
                Pair.of("Middle Name", middleName),
                Pair.of("Last Name", lastName),
                Pair.of("Business Name", businessName),
                Pair.of("Address", address),
                Pair.of("City", city),
                Pair.of("State", state),
                Pair.of("Zip Code", zip),
                Pair.of("Date of Birth", dateOfBirth),
                Pair.of("Exclusion Date", exclusionDate),
                Pair.of("Exclusion Type", exclusionType),
                Pair.of("General", general),
                Pair.of("Speciality", specialty),
                Pair.of("Reinstatement Date", reinDate),
                Pair.of("Waiver Date", waiverDate),
                Pair.of("Waiver State", waiverState)
        );
        propertyListType.getNameValuePair().addAll(
                properties.stream()
                        .filter(pair -> pair.getRight() != null)
                        .map(pair -> Pair.of(
                                pair.getLeft(),
                                pair.getRight().getValueAsString()
                        ))
                        .filter(pair -> pair.getRight() != null)
                        .filter(pair -> !pair.getRight().equals(""))
                        .map(pair -> toNameValuePair(
                                pair.getLeft(),
                                pair.getRight()
                        ))
                        .collect(Collectors.toList())
        );
        return propertyListType;
    }

    public LeieAutomaticScreeningMatch toMatch() {
        LeieAutomaticScreeningMatch match = new LeieAutomaticScreeningMatch();
        match.setResourceUrl(getId());
        match.setNpi(fromPrimitiveType(npi));
        match.setUpin(fromPrimitiveType(upin));
        match.setFirstName(fromPrimitiveType(firstName));
        match.setMiddleName(fromPrimitiveType(middleName));
        match.setLastName(fromPrimitiveType(lastName));
        match.setBusinessName(fromPrimitiveType(businessName));
        match.setAddress(fromPrimitiveType(address));
        match.setCity(fromPrimitiveType(city));
        match.setZipCode(fromPrimitiveType(zip));
        match.setDateOfBirth(fromDstuDateType(dateOfBirth));
        match.setExcludedAt(fromDstuDateType(exclusionDate));
        match.setExclusionType(fromPrimitiveType(exclusionType));
        match.setGeneral(fromPrimitiveType(general));
        match.setSpeciality(fromPrimitiveType(specialty));
        match.setReinstantedAt(fromDstuDateType(reinDate));
        match.setWaivedAt(fromDstuDateType(waiverDate));
        match.setWaiverState(fromPrimitiveType(waiverState));
        return match;
    }

    private static <T> String fromPrimitiveType(PrimitiveType<T> primitiveType) {
        if (primitiveType == null || primitiveType.isEmpty()) {
            return null;
        } else {
            return primitiveType.getValueAsString();
        }
    }

    private static LocalDate fromDstuDateType(DateType date) {
        if (date == null || date.isEmpty()) {
            return null;
        } else {
            // The FHIR DateType month value is 0-indexed, but Java's
            // LocalDate assumes it's 1-indexed and will throw an error
            // for January (month 0) unless we standardize.
            Integer javaMonth = date.getMonth() + 1;
            return LocalDate.of(
                    date.getYear(),
                    javaMonth,
                    date.getDay()
            );
        }
    }

    private NameValuePairType toNameValuePair(String name, String value) {
        NameValuePairType nameValuePairType = new NameValuePairType();
        nameValuePairType.setName(name);
        nameValuePairType.setValue(value);
        return nameValuePairType;
    }
}
