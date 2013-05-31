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

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.AgencyInformationType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;
import gov.medicaid.verification.BackgroundStudyClient;

import java.io.IOException;
import java.util.List;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This verifies that the background study ID is valid and that it is not denied.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class VerifyBackgroundStudyHandler extends GenericHandler {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("VerifyBackgroundStudyHandler");

    /**
     * Checks the NETStudy service for the background study id entered for agencies.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        log.log(Level.INFO, "Verifying Background study results...");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");
        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        AgencyInformationType agency = provider.getAgencyInformation();
        if (agency == null || Util.isBlank(agency.getBackgroundStudyId())) {
            // no need to process if there is no input
            manager.completeWorkItem(item.getId(), item.getParameters());
            return;
        }

        ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResults.getScreeningResult().add(screeningResultType);

        ExternalSourcesScreeningResultType results = null;
        BackgroundStudyClient client = new BackgroundStudyClient();
        try {
            results = client.verify(provider);
            SearchResultType matchResults = results.getSearchResults();
            VerificationStatusType status = XMLUtility.nsGetVerificationStatus(processModel);
            if (matchResults != null && !matchResults.getSearchResultItem().isEmpty()) {
                SearchResultItemType result = matchResults.getSearchResultItem().iterator().next(); // max 1 output
                List<NameValuePairType> cols = result.getColumnData().getNameValuePair();
                for (NameValuePairType col : cols) {
                    if (col.getName().equals("Denied Status")) {
                        if ("false".equalsIgnoreCase(col.getValue().trim())) {
                            status.setNetStudy("N");
                        } else {
                            status.setNetStudy("Y");
                        }
                        break;
                    }
                }
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
        screeningResultType.setScreeningType("NET STUDY ID VERIFICATION");
        screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));
        manager.completeWorkItem(item.getId(), item.getParameters());
    }
}