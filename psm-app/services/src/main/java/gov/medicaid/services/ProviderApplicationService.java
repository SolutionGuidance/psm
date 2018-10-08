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

import gov.medicaid.entities.Application;
import gov.medicaid.entities.ApplicationSearchCriteria;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Note;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProfileHeader;
import gov.medicaid.entities.ProviderCategoryOfService;
import gov.medicaid.entities.ProviderLookup;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.Validity;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;

/**
 * Interface for application related activities.
 */
public interface ProviderApplicationService {

    /**
     * This method is used to delete a application draft. Note that only applications in
     * draft status can be removed.
     *
     * @param user     the user performing the operation
     * @param applicationId the application id to be removed
     * @throws PortalServiceException for any errors encountered
     */
    void removeDraftApplication(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed
     * and resulted in a rejected change.
     *
     * @param user     the user who rejected the request
     * @param applicationId the application id that was rejected
     * @param reason   the reason for rejecting the request
     * @throws PortalServiceException for any errors encountered
     */
    void rejectApplication(
            CMSUser user,
            long applicationId,
            String reason
    ) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed
     * and resulted in an approved change, the application is approved AS-IS
     * (e.g. renewal) and there are no changes from the approver.
     *
     * @param user     the user who approved the request
     * @param applicationId the application id that was approved
     * @throws PortalServiceException for any errors encountered
     */
    void approveApplication(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed
     * and resulted in an approved change, but the approver made some manual
     * changes to the data so we don't reload from database first.
     *
     * @param user   the user who approved the request
     * @param application the application that will be approved (after saving it)
     * @throws PortalServiceException for any errors encountered
     */
    void approveApplicationWithChanges(
            CMSUser user,
            Application application
    ) throws PortalServiceException;

    /**
     * This is the method to be called to stream the attachment contents to the
     * given output stream directly from the database.
     *
     * @param user         the current user
     * @param attachmentId the attachment id to be streamed.
     * @param response     the response object to write the contents to
     * @throws IOException            for any I/O errors while streaming the
     *                                attachment contents
     * @throws PortalServiceException for any errors encountered
     */
    void streamContent(
            CMSUser user,
            long attachmentId,
            HttpServletResponse response
    ) throws IOException, PortalServiceException;

    /**
     * This method gets all the providers that meet the search criteria. If none
     * available, the search result will be empty.
     *
     * @param user     the user performing the action
     * @param criteria the search criteria
     * @return the applicable providers
     * @throws IllegalArgumentException if any argument is null, or the page
     *                                  size and page number settings are
     *                                  invalid
     */
    SearchResult<UserRequest> searchApplications(
            CMSUser user,
            ProviderSearchCriteria criteria
    );

    /**
     * This method gets all the applications that meet the search criteria. If none
     * available, the search result will be empty.
     *
     * @param criteria the search criteria
     * @return the applications
     * @throws IllegalArgumentException if any argument is null, or the page
     *                                  size and page number settings are
     *                                  invalid
     */
    SearchResult<Application> searchApplications(
            ApplicationSearchCriteria criteria
    );

    /**
     * This method gets all the applications that are draft status at end of
     * month, and that meet the search criteria. If none available, the
     * search result will be empty.
     *
     * @param criteria the search criteria
     * @return the applications
     * @throws IllegalArgumentException if any argument is null, or the page
     *                                  size and page number settings are
     *                                  invalid
     */
    SearchResult<Application> getDraftAtEomApplications(
            ApplicationSearchCriteria criteria
    );

    /**
     * This method gets all the providers owned by the given user. If none
     * available, the search result will be empty.
     *
     * @param user the user performing the action
     * @return the applicable providers
     */
    List<ProfileHeader> findMyProfiles(
            CMSUser user
    );

    /**
     * Saves the given application as draft.
     *
     * @param user   the user saving the application.
     * @param application the application to be saved
     * @return the application id for the draft created
     * @throws PortalServiceException for any errors encountered
     */
    long saveAsDraft(
            CMSUser user,
            Application application
    ) throws PortalServiceException;

    /**
     * Retrieves the application details (full).
     *
     * @param user              the user getting the application.
     * @param processInstanceId the process instance id to get the details for
     * @return the complete application and provider profile
     * @throws PortalServiceException for any errors encountered
     */
    Application getApplicationByProcessInstanceId(
            CMSUser user,
            long processInstanceId
    ) throws PortalServiceException;

    /**
     * Look up an application by its ID, checking that the given user
     * has permission to access the application.
     *
     * @param user         the requesting user; used for authorization
     * @param applicationId the ID of the application
     * @return the application, if found; empty, if not found.
     * @throws PortalServiceException if not authorized
     */
    Optional<Application> getApplication(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * Look up an application by its ID, including the associated
     * automatic screening results, and checking that the given user has
     * permission to access the application.
     *
     * @param user            the requesting user; used for authorization
     * @param applicationId    the ID of the application
     * @return the application, if found; empty, if not found.
     * @throws PortalServiceException if not authorized
     */
    Optional<Application> getApplicationWithScreenings(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * Retrieves the application details (full). Deprecated in favor of getApplication.
     *
     * @param user     the user getting the application.
     * @param applicationId the application to get the details for
     * @return the complete application and provider profile, or null if not found
     * @throws PortalServiceException for any errors encountered
     * @see ProviderApplicationService#getApplication(CMSUser, long)
     * @deprecated This can return null, and lead to a NullPointerException.
     */
    @Deprecated
    Application getApplicationDetails(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * Retrieves the provider details (full).
     *
     * @param user      the user getting the provider.
     * @param profileId the profile id to get the details for
     * @return the complete provider profile
     * @throws PortalServiceException for any errors encountered
     */
    ProviderProfile getProviderDetails(
            CMSUser user,
            long profileId
    ) throws PortalServiceException;

    /**
     * Search for practice.
     *
     * @param user     the user performing the search
     * @param criteria the criteria filter
     * @return the matching practice results
     */
    SearchResult<PracticeLookup> searchPractice(
            CMSUser user,
            PracticeSearchCriteria criteria
    );

    /**
     * Creates a renewal application from the given profile id.
     *
     * @param user      the user performing the action
     * @param profileId the profile to be renewed
     * @return the generated application
     * @throws PortalServiceException for any errors encountered
     */
    Application renewProfile(
            CMSUser user,
            long profileId
    ) throws PortalServiceException;

    /**
     * Creates an update application from the given profile id.
     *
     * @param user      the user performing the action
     * @param profileId the profile to be updated
     * @return the generated application
     * @throws PortalServiceException for any errors encountered
     */
    Application editProfile(
            CMSUser user,
            long profileId
    ) throws PortalServiceException;

    /**
     * Uploads an attachment to the database.
     *
     * @param user       the user performing the action
     * @param attachment the attachment to be uploaded
     * @return the attachment id generated
     * @throws PortalServiceException for any errors encountered
     */
    long uploadAttachment(
            CMSUser user,
            Document attachment
    ) throws PortalServiceException;

    /**
     * Creates a note on a request, the note will remain on the request until it
     * is approved.
     *
     * @param user     the user performing the action
     * @param applicationId the request identifier
     * @param text     the note text
     * @throws PortalServiceException for any errors encountered
     */
    void addNoteToApplication(
            CMSUser user,
            long applicationId,
            String text
    ) throws PortalServiceException;

    /**
     * Used by data onboarding service to fully import a mapped profile.
     *
     * @param user            the user performing the operation
     * @param sourceSystem    the source of the imported profile
     * @param providerProfile the profile to be created
     * @return the internal profile id for the imported profile
     */
    long importProfile(
            CMSUser user,
            SystemId sourceSystem,
            ProviderProfile providerProfile
    );

    /**
     * Retrieves the attachments with the given id.
     *
     * @param user         the current user
     * @param attachmentId the attachment to get
     * @return the matching attachment
     * @throws PortalServiceException for any errors encountered
     */
    Document findAttachment(
            CMSUser user,
            long attachmentId
    ) throws PortalServiceException;

    /**
     * Checks the validity status of the application.
     *
     * @param applicationId  the application id to check
     * @param profileId the profile to check
     * @return the validity status of the application
     * @throws PortalServiceException for any errors encountered
     */
    Validity getSubmissionValidity(
            long applicationId,
            long profileId
    ) throws PortalServiceException;

    /**
     * Retrieves all the notes for the given application.
     *
     * @param applicationId the application id
     * @return the notes for the application of for the referenced profile
     */
    List<Note> findNotes(long applicationId);

    /**
     * Retrieves public data for enrolled providers by NPI.
     *
     * @param npi the npi to search for
     * @return the public lookup data
     */
    List<ProviderLookup> lookupProvider(
            String npi
    );

    /**
     * Direct save (no logical checks) Used by business processes.
     *
     * @param application the application to be saved
     * @throws PortalServiceException for any errors encountered
     * @return a new application with the details
     */
    Application saveApplicationDetails(
            Application application
    ) throws PortalServiceException;

    /**
     * Renews the profiles directly, without making any data changes.
     *
     * @param currentUser the current user
     * @param profileIds  the profiles to renew
     * @return
     */
    Long[] renewalProfiles(
            CMSUser currentUser,
            Set<Long> profileIds
    );

    /**
     * Adds COS to the ticket.
     *
     * @param user              the user performing the action
     * @param categoryOfService the entity to persist
     * @param prevCatServiceId  if last COS needs an update in end date this
     *                          will be provided
     * @param prevCatEndDate    last COS end date
     * @throws PortalServiceException for any errors encountered
     */
    void addCOSToApplication(
            CMSUser user,
            ProviderCategoryOfService categoryOfService,
            long prevCatServiceId,
            Date prevCatEndDate
    ) throws PortalServiceException;

    /**
     * Deletes the COS by profile.
     *
     * @param user      the user performing the action
     * @param profileId the profile id
     * @param id        the cos id
     * @throws PortalServiceException for any errors encountered
     */
    void deleteCOSByProfile(
            CMSUser user,
            long profileId,
            long id
    ) throws PortalServiceException;

    /**
     * Gets the COS associated with a application.
     *
     * @param user     CMS user
     * @param applicationId application id.
     * @return the list of services
     * @throws PortalServiceException for any errors encountered
     */
    List<ProviderCategoryOfService> getPendingCategoryOfServices(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException;

    /**
     * Deletes the COS by application.
     *
     * @param user     the user performing the action
     * @param applicationId the application id
     * @param id       the cos id
     * @throws PortalServiceException for any errors encountered
     */
    void deleteCOSByApplication(
            CMSUser user,
            long applicationId,
            long id
    ) throws PortalServiceException;

    /**
     * Returns true if the first parameter can be considered an employer of the
     * second.
     *
     * @param externalUserId the employer to be checked
     * @param profileNPI     the employee to be checked
     * @return true if there is an affiliation between the two arguments that
     * gives the first access to the latter
     */
    boolean hasGroupAffiliation(
            String externalUserId,
            String profileNPI
    );

    /**
     * Returns true if there is a profile found in the database with the given
     * NPI.
     *
     * @param profileNPI the NPI to be checked
     * @return true if a record matches
     */
    boolean existsProfile(String profileNPI);

    /**
     * Retrieves the related entity for the given profile key.
     *
     * @param profileId the profile id of the provider
     * @param applicationId  the request application id
     * @return the related entity to the profile
     */
    Entity findEntityByProviderKey(
            long profileId
    );

    /**
     * Retrieves the related attachments for the given profile key.
     *
     * @param profileId the profile id of the provider
     * @return the related attachments to the profile
     */
    List<Document> findAttachments(long profileId);

    /**
     * Retrieves the provider details.
     *
     * @param profileId     the profile to search for
     * @param fetchChildren if true, the entire object tree is retrieved
     * @return the application details
     */
    ProviderProfile getProviderDetails(
            long profileId,
            boolean fetchChildren);
}
