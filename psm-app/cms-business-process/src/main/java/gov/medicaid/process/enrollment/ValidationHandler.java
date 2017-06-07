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

import java.util.logging.Logger;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This is a mock handler for front-end validation.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ValidationHandler extends GenericHandler {

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(ValidationHandler.class.getName());

    /**
     * Mock validations.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Validating the provider.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        if (processModel.getEnrollment().getRequestType() == null) {
            XMLUtility.nsGetValidationResult(processModel).setStatus(XMLUtility.newStatus("FAILURE"));
        }

        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}