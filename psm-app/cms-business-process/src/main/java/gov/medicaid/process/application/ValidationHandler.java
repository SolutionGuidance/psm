/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.process.application;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import java.util.logging.Logger;

/**
 * This is a mock handler for front-end validation.
 */
public class ValidationHandler extends GenericHandler {
    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Mock validations.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Validating the provider.");
        ApplicationProcess processModel = (ApplicationProcess) item.getParameter("model");

        if (processModel.getApplication().getRequestType() == null) {
            XMLUtility.nsGetValidationResult(processModel).setStatus(XMLUtility.newStatus("FAILURE"));
        }

        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}
