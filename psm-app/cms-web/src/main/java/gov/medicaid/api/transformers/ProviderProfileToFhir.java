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

package gov.medicaid.api.transformers;

import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.ViewStatics;

import org.hl7.fhir.dstu3.model.Address;
import org.hl7.fhir.dstu3.model.ContactPoint;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.HumanName;
import org.hl7.fhir.dstu3.model.Identifier;
import org.hl7.fhir.dstu3.model.Practitioner;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.function.Function;

public class ProviderProfileToFhir implements Function<ProviderProfile, DomainResource> {
    /**
     * @see <a href="https://www.hl7.org/oid/index.cfm?Comp_OID=2.16.840.1.113883.4.4">
     * EIN OID in HL7 OID registry</a>
     */
    static final String EIN_OID = "2.16.840.1.113883.4.4";

    @Override
    public DomainResource apply(ProviderProfile profile) {
        Entity entity = profile.getEntity();
        if (entity instanceof Person) {
            return profileToPractitioner(profile);
        } else if (entity instanceof Organization) {
            return organizationToFhirOrganization((Organization) entity);
        } else {
            throw new IllegalArgumentException(
                    "Unrecognized Entity subclass: " +
                            entity.getClass().getCanonicalName()
            );
        }
    }

    private Practitioner profileToPractitioner(ProviderProfile profile) {
        Person person = (Person) profile.getEntity();
        Practitioner practitioner = new Practitioner();
        practitioner.setId("#" + Long.toString(person.getId()));
        practitioner.addIdentifier(ssn(person));
        practitioner.addIdentifier(npi(person));
        practitioner.addName(name(person));
        practitioner.setBirthDate(person.getDob());
        practitioner.setAddress(addresses(profile));
        practitioner.setTelecom(numbers(profile));
        return practitioner;
    }

    private org.hl7.fhir.dstu3.model.Organization organizationToFhirOrganization(
            Organization organization
    ) {
        org.hl7.fhir.dstu3.model.Organization fhirOrg =
                new org.hl7.fhir.dstu3.model.Organization();
        fhirOrg.setId("#" + Long.toString(organization.getId()));
        fhirOrg.addIdentifier(npi(organization));
        fhirOrg.addIdentifier(ein(organization));
        fhirOrg.setName(organization.getName());
        return fhirOrg;
    }

    private HumanName name(Person person) {
        HumanName humanName = new HumanName()
                .addPrefix(person.getPrefix())
                .setFamily(person.getLastName())
                .addSuffix(person.getSuffix());
        if (null != person.getFirstName()) {
            humanName.addGiven(person.getFirstName());
        }
        if (null != person.getMiddleName()) {
            humanName.addGiven(person.getMiddleName());
        }

        return humanName;
    }

    private Identifier ssn(Person person) {
        return createIdentifier(
                "http://hl7.org/fhir/sid/us-ssn",
                person.getSsn()
        );
    }

    private Identifier npi(Entity entity) {
        return createIdentifier(
                "http://hl7.org/fhir/sid/us-npi",
                entity.getNpi()
        );
    }

    private List<Address> addresses(ProviderProfile profile) {
        List<Address> addresses = new ArrayList<>();
        EntityAddressToFhirAddress addressTranslator = new EntityAddressToFhirAddress();

        List<Affiliation> practitionerAffiliations = profile.getAffiliations();
        if (practitionerAffiliations == null) {
            return Collections.emptyList();
        }

        for (Affiliation affiliation : practitionerAffiliations) {
            if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())) {
                Address affiliationAddress = addressTranslator.apply(affiliation.getEntity().getContactInformation().getAddress());
                addresses.add(affiliationAddress);
            }
        }

        return addresses;
    }

    private List<ContactPoint> numbers(ProviderProfile profile) {
        List<ContactPoint> numbers = new ArrayList<>();
        EntityNumberToContactPoint numberTranslator = new EntityNumberToContactPoint();

        List<Affiliation> practitionerAffiliations = profile.getAffiliations();
        if (practitionerAffiliations == null) {
            return Collections.emptyList();
        }

        for (Affiliation affiliation : practitionerAffiliations) {
            if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())) {
                ContactPoint affiliationNumber = numberTranslator.apply(affiliation.getEntity().getContactInformation().getPhoneNumber());
                affiliationNumber.setUse(ContactPoint.ContactPointUse.WORK);
                if ("Y".equals(affiliation.getPrimaryInd())) {
                    affiliationNumber.setRank(1);
                }
                numbers.add(affiliationNumber);
            }
        }

        return numbers;
    }

    private Identifier ein(Organization organization) {
        return createIdentifier(EIN_OID, organization.getFein());
    }

    private Identifier createIdentifier(String system, String value) {
        if (value == null) {
            return null;
        } else {
            return new Identifier()
                    .setSystem(system)
                    .setValue(value);
        }
    }
}
