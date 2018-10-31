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

package gov.medicaid.services;

import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.entities.CMSUser;

import org.jbpm.task.query.TaskSummary;

import java.util.List;

/**
 * Defines the interface for application.
 */
public interface BusinessProcessService {

    /**
     * Submits the given application.
     *
     * @param user     the user performing the action
     * @param applicationId the application id to be submitted
     * @throws PortalServiceException for any errors encountered
     */
    void submitApplication(CMSUser user, long applicationId) throws PortalServiceException;

    /**
     * Retrieves the available tasks for the given user and roles.
     *
     * @param username the user to get the tasks for
     * @param roles    the roles of the user
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    List<TaskSummary> getAvailableTasks(
            String username,
            List<String> roles
    ) throws Exception;

    /**
     * Retrieves the current state of the process execution.
     *
     * @param taskId the task id to get the current details for
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    ApplicationProcess getTaskModel(long taskId) throws Exception;

    /**
     * Completes the given task.
     *
     * @param taskId   the task to be completed
     * @param username the user performing the task
     * @param roles    the roles of the user
     * @param reject   flag if the results are rejected
     * @param updates  the changes
     * @param comment  the change comments
     * @throws Exception for any errors encountered
     */
    void completeReview(
            long taskId,
            String username,
            List<String> roles,
            ProviderInformationType updates,
            boolean reject,
            String comment
    ) throws Exception;

    /**
     * Updates a pending process.
     *
     * @param application   the update request
     * @param user     the user performing the update
     * @param userRole the role of the user
     * @throws Exception for any errors encountered
     */
    void updateRequest(
            ApplicationType applicationType,
            CMSUser user
    ) throws Exception;
}
