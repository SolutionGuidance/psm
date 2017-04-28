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
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.domain.model.ProviderType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;

import java.util.logging.Logger;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This is a mock for retrieving enrollment history SSN.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class EnrollmentHistoryHandler extends GenericHandler {

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(EnrollmentHistoryHandler.class.getName());

    /**
     * Mock validations.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Getting Enrollment History");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");
        // TODO - replace with real service
        ScreeningResultsType results = XMLUtility.nsGetScreeningResults(processModel);
        ScreeningResultType history = new ScreeningResultType();
        history.setScreeningType("ENROLLMENT HISTORY");
        SearchResultType result = new SearchResultType();
        history.setSearchResult(result);
        results.getScreeningResult().add(history);
        if (processModel.getEnrollment().getSubmittedBy().equals("SET AS REGISTERED CHORIPRACTOR")) {
            SearchResultItemType match = new SearchResultItemType();
            PropertyListType row = new PropertyListType();
            NameValuePairType type = new NameValuePairType();
            type.setName("ProviderType");
            type.setValue(ProviderType.CHIROPRACTOR.value());
            row.getNameValuePair().add(type);
            NameValuePairType status = new NameValuePairType();
            status.setName("Status");
            status.setValue("Active");
            row.getNameValuePair().add(status);
            match.setColumnData(row);
            result.getSearchResultItem().add(match);
        }

        manager.completeWorkItem(item.getId(), item.getParameters());
    }
}