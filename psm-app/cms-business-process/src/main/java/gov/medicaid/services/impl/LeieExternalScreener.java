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

package gov.medicaid.services.impl;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.ServerValidationModeEnum;
import ca.uhn.fhir.rest.gclient.StringClientParam;

import gov.medicaid.entities.Application;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.process.application.Exclusion;

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

    public AutomaticScreening.Result screen(Long applicationId, String npi) {
        logger.info(String.format(
            "Running LEIE screening for application " +
                "with application_id %d and NPI %s.",
            applicationId,
            npi
        ));

        Application application = getApplication(applicationId);
        LeieAutomaticScreening screening = new LeieAutomaticScreening();
        screening.setNpiSearchTerm(npi);
        application.addAutomaticScreening(screening);

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

        entityManager.merge(application);

        return screening.getResult();
    }

    private Application getApplication(Long applicationId) {
        return entityManager.find(Application.class, applicationId);
    }

    private boolean providerIsExcluded(Bundle providerSearchResults) {
        return providerSearchResults.getTotal() > 0;
    }

    private void setResultExcluded(
            LeieAutomaticScreening screening,
            Bundle providerSearchResults
    ) {
        logger.info(String.format(
            "LEIE screening for application with application_id %d " +
                "found %d matches; marking screening as failed.",
            screening.getApplication().getApplicationId(),
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
            "LEIE screening for application with application_id %d " +
                "found no matches; marking screening as passed.",
            screening.getApplication().getApplicationId()
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
