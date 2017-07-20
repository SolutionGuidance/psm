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
package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.entities.CMSUser;

import java.util.List;

import org.jbpm.task.query.TaskSummary;

/**
 * Defines the interface for enrollment.
 */
public interface BusinessProcessService {

    /**
     * Submits the given ticket.
     *
     * @param user     the user performing the action
     * @param ticketId the ticket id to be submitted
     * @throws PortalServiceException for any errors encountered
     */
    void submitTicket(CMSUser user, long ticketId) throws PortalServiceException;

    /**
     * Starts a new enrollment process.
     *
     * @param enrollment the enrollment requested
     * @return the process instance id
     * @throws Exception for any errors encountered
     */
    long enroll(EnrollmentType enrollment) throws Exception;

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
    EnrollmentProcess getTaskModel(long taskId) throws Exception;

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
            final long taskId,
            String username,
            List<String> roles,
            final ProviderInformationType updates,
            boolean reject,
            String comment
    ) throws Exception;

    /**
     * Starts the renewal process.
     *
     * @param ticket         the renewal request
     * @param currentProfile the current profile for this provider
     * @return the process instance id.
     * @throws Exception for any errors encountered
     */
    long renew(
            EnrollmentType ticket,
            EnrollmentType currentProfile
    ) throws Exception;

    /**
     * Starts the update process.
     *
     * @param ticket         the update request
     * @param currentProfile the current profile for this provider
     * @return the process instance id.
     * @throws Exception for any errors encountered
     */
    long update(
            EnrollmentType ticket,
            EnrollmentType currentProfile
    ) throws Exception;

    /**
     * Updates a pending process.
     *
     * @param ticket   the update request
     * @param user     the user performing the update
     * @param userRole the role of the user
     * @throws Exception for any errors encountered
     */
    void updateRequest(
            EnrollmentType ticket,
            String user,
            String userRole
    ) throws Exception;
}
