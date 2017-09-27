/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.verification.SAMExclusionSearchClient;
import gov.medicaid.verification.SAMExclusionServiceMatcher;

import java.io.IOException;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This checks the excluded providers from the SAM website.
 * 
 * @author cyberjag
 * @version 1.0
 */
public class SAMExcludedProvidersScreeningHandler extends GenericHandler {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("SAMExcludedProvidersScreeningHandler");

    /**
     * SAM exclusion screening.
     * 
     * @param item
     *            the work item to abort
     * @param manager
     *            the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        log.log(Level.INFO, "Checking SAM provider exclusion.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResults.getScreeningResult().add(screeningResultType);

        ExternalSourcesScreeningResultType results = null;
        try {
            SAMExclusionSearchClient client = new SAMExclusionSearchClient();
            results = client.verify(XMLUtility.nsGetProvider(processModel));

            VerificationStatusType verificationStatus = XMLUtility.nsGetVerificationStatus(processModel);
            if (!results.getSearchResults().getSearchResultItem().isEmpty()) {
                SAMExclusionServiceMatcher matcher = new SAMExclusionServiceMatcher();
                MatchStatus status = matcher.match(provider, null, results);
                if (status == MatchStatus.EXACT_MATCH) {
                    // the provider is present in the exclusion list
                    verificationStatus.setSAMNonExclusion("N");
                } else {
                    verificationStatus.setSAMNonExclusion("Y");
                }
            } else {
                verificationStatus.setSAMNonExclusion("Y");
            }
            screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));
            screeningResultType.setSAMExclusionVerificationResult(results.getSearchResults());
        } catch (TransformerException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (JAXBException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (IOException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        }
        screeningResultType.setScreeningType("SAM EXCLUDED PROVIDERS");
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}