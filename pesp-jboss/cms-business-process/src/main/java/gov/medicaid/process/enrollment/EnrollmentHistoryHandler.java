/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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