/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.domain.rules.inference.ProviderNameMatcher;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.verification.PECOSSearchClient;

import java.io.IOException;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This verifies that the NPI is present in the PECOS records.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class VerifyPECOSRecordHandler extends GenericHandler {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("VerifySSNHandler");

    /**
     * Checks the PECOS service for the NPI of the provider.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        log.log(Level.INFO, "Verifying NPI in PECOS...");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");
        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        ApplicantInformationType applicant = provider.getApplicantInformation();
        if (applicant == null || applicant.getPersonalInformation() == null) {
            // PECOS is for individuals only
            manager.completeWorkItem(item.getId(), item.getParameters());
            return;
        }

        ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResults.getScreeningResult().add(screeningResultType);

        ExternalSourcesScreeningResultType results = null;
        PECOSSearchClient client = new PECOSSearchClient();
        try {
            results = client.verify(provider);
            SearchResultType matchResults = results.getSearchResults();
            VerificationStatusType status = XMLUtility.nsGetVerificationStatus(processModel);
            if (matchResults != null && !matchResults.getSearchResultItem().isEmpty()) {
                ProviderNameMatcher matcher = new ProviderNameMatcher(false, true);
                MatchStatus matchStatus = matcher.match(provider, null, results);
                if (matchStatus == MatchStatus.EXACT_MATCH) {
                    status.setPECOS("Y");
                } else {
                    status.setPECOS("N");
                }
            } else {
                status.setPECOS("N");
            }
            screeningResultType.setSearchResult(matchResults);
        } catch (JAXBException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (IOException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (TransformerException e) {
            log.log(Level.ERROR, e);
            results = new ExternalSourcesScreeningResultType();
            results.setStatus(XMLUtility.newStatus("ERROR"));
        }

        screeningResultType.setSearchResult(results.getSearchResults());
        screeningResultType.setScreeningType("NPI PECOS VERIFICATION");
        screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));
        manager.completeWorkItem(item.getId(), item.getParameters());
    }
}