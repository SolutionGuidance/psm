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

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.verification.OIGExclusionSearchClient;
import gov.medicaid.verification.OIGExclusionServiceMatcher;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;
import java.io.IOException;

/**
 * This checks the excluded providers from the OIG website.
 */
public class ExcludedProvidersScreeningHandler extends GenericHandler {
    private Log log = LogUtil.getLog("ExcludedProvidersScreeningHandler");

    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        log.log(Level.INFO, "Checking provider exclusion.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType screeningResultType = new ScreeningResultType();
        screeningResults.getScreeningResult().add(screeningResultType);

        ExternalSourcesScreeningResultType results = null;
        try {
            OIGExclusionSearchClient client = new OIGExclusionSearchClient();
            results = client.verify(XMLUtility.nsGetProvider(processModel));

            VerificationStatusType verificationStatus = XMLUtility.nsGetVerificationStatus(processModel);
            if (!results.getSearchResults().getSearchResultItem().isEmpty()) {
                OIGExclusionServiceMatcher matcher = new OIGExclusionServiceMatcher();
                MatchStatus status = matcher.match(provider, null, results);
                if (status == MatchStatus.PARTIAL_MATCH || status == MatchStatus.EXACT_MATCH) {
                    verificationStatus.setNonExclusion("N");
                } else {
                    verificationStatus.setNonExclusion("Y");
                }
            } else {
                verificationStatus.setNonExclusion("Y");
            }
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

        screeningResultType.setExclusionVerificationResult(results.getSearchResults());
        screeningResultType.setScreeningType("EXCLUDED PROVIDERS");
        screeningResultType.setStatus(XMLUtility.newStatus("SUCCESS"));

        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}
