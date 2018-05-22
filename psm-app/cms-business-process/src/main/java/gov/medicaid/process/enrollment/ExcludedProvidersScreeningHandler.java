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

package gov.medicaid.process.enrollment;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.ServerValidationModeEnum;
import ca.uhn.fhir.rest.gclient.StringClientParam;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.LeieAutomaticScreening;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;
import org.hl7.fhir.dstu3.model.Bundle;

import javax.persistence.EntityManager;
import java.util.logging.Logger;

import static java.util.logging.Level.WARNING;

/**
 * This checks the excluded providers from the OIG LEIE.
 */
public class ExcludedProvidersScreeningHandler extends GenericHandler {
    private final Logger logger = Logger.getLogger(getClass().getName());

    private String baseUri;
    private final EntityManager entityManager;
    private FhirContext fhirContext;

    public ExcludedProvidersScreeningHandler(
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

    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Checking provider exclusion.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");
        Enrollment enrollment = getEnrollment(processModel.getEnrollment());

        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);

        LeieAutomaticScreening screening = new LeieAutomaticScreening();
        screening.setNpiSearchTerm(provider.getNPI());

        try {
            Bundle providerSearchResults = searchLeieForProvider(provider.getNPI());
            if (providerIsExcluded(providerSearchResults)) {
                setResultExcluded(screening, processModel, providerSearchResults);
            } else {
                setResultNotExcluded(screening, processModel);
            }
        } catch (RuntimeException e) {
            logger.log(WARNING, "Error checking provider against LEIE", e);
            setResultError(screening, processModel);
        }

        enrollment.addAutomaticScreening(screening);
        entityManager.merge(enrollment);
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }

    private Enrollment getEnrollment(EnrollmentType enrollmentType) {
        long enrollmentId = Long.parseLong(enrollmentType.getObjectId());
        return entityManager.find(Enrollment.class, enrollmentId);
    }

    private void setResultExcluded(
            LeieAutomaticScreening screening,
            EnrollmentProcess processModel,
            Bundle providerSearchResults
    ) {
        screening.setResult(AutomaticScreening.Result.FAIL);

        setNonExclusionVerificationStatus(processModel, "N");

        ExternalSourcesScreeningResultType results = new ExternalSourcesScreeningResultType();
        SearchResultType searchResults = new SearchResultType();
        for (Bundle.BundleEntryComponent e : providerSearchResults.getEntry()) {
            Exclusion exclusion = (Exclusion) e.getResource();

            screening.addMatch(exclusion.toMatch());

            SearchResultItemType searchResultItem = new SearchResultItemType();
            searchResultItem.setColumnData(exclusion.toPropertyList());

            searchResults.getSearchResultItem().add(searchResultItem);
        }

        results.setSearchResults(searchResults);
        results.setStatus(XMLUtility.newStatus("SUCCESS"));

        attachScreeningResultToProcess(processModel, results);
    }

    private void setResultNotExcluded(
            LeieAutomaticScreening screening,
            EnrollmentProcess processModel
    ) {
        screening.setResult(AutomaticScreening.Result.PASS);

        setNonExclusionVerificationStatus(processModel, "Y");

        ExternalSourcesScreeningResultType results =
                new ExternalSourcesScreeningResultType();
        results.setSearchResults(new SearchResultType());
        results.setStatus(XMLUtility.newStatus("SUCCESS"));
        attachScreeningResultToProcess(processModel, results);
    }

    private void setNonExclusionVerificationStatus(
            EnrollmentProcess processModel,
            String status
    ) {
        VerificationStatusType verificationStatus =
                XMLUtility.nsGetVerificationStatus(processModel);
        verificationStatus.setNonExclusion(status);
    }

    private void setResultError(
            LeieAutomaticScreening screening,
            EnrollmentProcess processModel
    ) {
        screening.setResult(AutomaticScreening.Result.ERROR);

        ExternalSourcesScreeningResultType results =
                new ExternalSourcesScreeningResultType();
        results.setStatus(XMLUtility.newStatus("ERROR"));
        attachScreeningResultToProcess(processModel, results);
    }

    private void attachScreeningResultToProcess(
            EnrollmentProcess processModel,
            ExternalSourcesScreeningResultType results
    ) {
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResultType.setExclusionVerificationResult(
                results.getSearchResults()
        );
        screeningResultType.setScreeningType("EXCLUDED PROVIDERS");
        screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));
        XMLUtility.nsGetScreeningResults(processModel)
                .getScreeningResult()
                .add(screeningResultType);
    }

    private boolean providerIsExcluded(Bundle providerSearchResults) {
        return providerSearchResults.getTotal() > 0;
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
