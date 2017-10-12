/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.verification.NPILookupClient;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * This verifies that the NPI provided is avaliable on lookup site.
 * 
 * @author cyberjag
 * @version 1.0
 */
public class NPILookupHandler extends GenericHandler {
    private static final Logger LOGGER =
            Logger.getLogger(NPILookupHandler.class.getName());

    /**
     * Checks the NPI Lookup Service.
     * 
     * @param item
     *            the work item to abort
     * @param manager
     *            the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        LOGGER.info("Verifying NPI...");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");
        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        ApplicantInformationType applicant = provider.getApplicantInformation();
        if (applicant == null || applicant.getPersonalInformation() == null) {
            if (applicant.getOrganizationInformation().getNPI() == null
                    || applicant.getOrganizationInformation().getNPI().trim().length() == 0) {
                // cannot process without NPI
                manager.completeWorkItem(item.getId(), item.getParameters());
                return;
            }
        }

        ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResults.getScreeningResult().add(screeningResultType);

        ExternalSourcesScreeningResultType results = null;
        NPILookupClient client = new NPILookupClient();
        try {
            results = client.verify(provider);
            VerificationStatusType status = XMLUtility.nsGetVerificationStatus(processModel);
            if (results.getSearchResults() != null && !results.getSearchResults().getSearchResultItem().isEmpty()) {
                status.setNPILookup("Y");
            } else {
                status.setNPILookup("N");
            }
            screeningResultType.setSearchResult(results.getSearchResults());
        } catch (JAXBException e) {
            LOGGER.severe(e.toString());
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (IOException e) {
            LOGGER.severe(e.toString());
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (TransformerException e) {
            LOGGER.severe(e.toString());
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        }

        screeningResultType.setSearchResult(results.getSearchResults());
        screeningResultType.setScreeningType("NPI LOOKUP");
        screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));
        manager.completeWorkItem(item.getId(), item.getParameters());
    }
}