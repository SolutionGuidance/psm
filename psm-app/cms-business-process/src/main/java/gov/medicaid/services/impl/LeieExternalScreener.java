package gov.medicaid.services.impl;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.ServerValidationModeEnum;
import ca.uhn.fhir.rest.gclient.StringClientParam;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.process.enrollment.Exclusion;
import org.hl7.fhir.dstu3.model.Bundle;

import javax.persistence.EntityManager;
import java.util.logging.Logger;

import static java.util.logging.Level.WARNING;

public class LeieExternalScreener {
    private final Logger logger = Logger.getLogger(getClass().getName());

    private final String baseUri;
    private final EntityManager entityManager;
    private final FhirContext fhirContext;

    public LeieExternalScreener(
            String baseUri,
            EntityManager entityManager
    ) {
        this.baseUri = baseUri;
        this.entityManager = entityManager;
        fhirContext = FhirContext.forDstu3();
        fhirContext.registerCustomType(Exclusion.class);
        fhirContext.getRestfulClientFactory().setServerValidationMode(
                ServerValidationModeEnum.NEVER
        );
    }

    public AutomaticScreening.Result screen(Long enrollmentId, String npi) {
        logger.info(String.format(
            "Running LEIE screening for enrollment " +
                "with enrollment_id %d and NPI %s.",
            enrollmentId,
            npi
        ));

        Enrollment enrollment = getEnrollment(enrollmentId);
        LeieAutomaticScreening screening = new LeieAutomaticScreening();
        screening.setNpiSearchTerm(npi);

        try {
            Bundle providerSearchResults = searchLeieForProvider(npi);
            if (providerIsExcluded(providerSearchResults)) {
                setResultExcluded(screening, providerSearchResults);
            } else {
                setResultNotExcluded(screening);
            }
        } catch (RuntimeException e) {
            logger.log(WARNING, "Error checking provider against LEIE", e);
            screening.setResult(AutomaticScreening.Result.ERROR);
        }

        enrollment.addAutomaticScreening(screening);
        entityManager.merge(enrollment);

        return screening.getResult();
    }

    private Enrollment getEnrollment(Long enrollmentId) {
        return entityManager.find(Enrollment.class, enrollmentId);
    }

    private boolean providerIsExcluded(Bundle providerSearchResults) {
        return providerSearchResults.getTotal() > 0;
    }

    private void setResultExcluded(
            LeieAutomaticScreening screening,
            Bundle providerSearchResults
    ) {
        logger.info(String.format(
            "LEIE screening for enrollment with enrollment_id %d " +
                "found %d matches; marking screening as failed.",
            screening.getEnrollment().getTicketId(),
            providerSearchResults.getEntry().size()
        ));
        screening.setResult(AutomaticScreening.Result.FAIL);

        for (Bundle.BundleEntryComponent e : providerSearchResults.getEntry()) {
            Exclusion exclusion = (Exclusion) e.getResource();

            screening.addMatch(exclusion.toMatch());
        }
    }

    private void setResultNotExcluded(
            LeieAutomaticScreening screening
    ) {
        logger.info(String.format(
            "LEIE screening for enrollment with enrollment_id %d " +
                "found no matches; marking screening as passed.",
            screening.getEnrollment().getTicketId()
        ));

        screening.setResult(AutomaticScreening.Result.PASS);
    }

    private Bundle searchLeieForProvider(String npi) {
        IGenericClient client = fhirContext.newRestfulGenericClient(baseUri);
        client.setEncoding(EncodingEnum.JSON);
        return client
                .search()
                .forResource("Exclusion")
                .where(new StringClientParam("npi").matches().value(npi))
                .returnBundle(org.hl7.fhir.dstu3.model.Bundle.class)
                .execute();
    }
}
