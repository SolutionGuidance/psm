package gov.medicaid.api.transformers;

import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.HumanName;
import org.hl7.fhir.dstu3.model.Identifier;
import org.hl7.fhir.dstu3.model.Practitioner;

import java.util.function.Function;

public class EntityToFhir implements Function<Entity, DomainResource> {
    /**
     * @see <a href="https://www.hl7.org/oid/index.cfm?Comp_OID=2.16.840.1.113883.4.4">
     * EIN OID in HL7 OID registry</a>
     */
    static final String EIN_OID = "2.16.840.1.113883.4.4";

    @Override
    public DomainResource apply(Entity entity) {
        if (entity instanceof Person) {
            return personToPractitioner((Person) entity);
        } else if (entity instanceof Organization) {
            return organizationToFhirOrganization((Organization) entity);
        } else {
            throw new IllegalArgumentException(
                    "Unrecognized Entity subclass: " +
                            entity.getClass().getCanonicalName()
            );
        }
    }

    private Practitioner personToPractitioner(Person person) {
        Practitioner practitioner = new Practitioner();
        practitioner.setId("#" + Long.toString(person.getId()));
        practitioner.addIdentifier(ssn(person));
        practitioner.addIdentifier(npi(person));
        practitioner.addName(name(person));
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
