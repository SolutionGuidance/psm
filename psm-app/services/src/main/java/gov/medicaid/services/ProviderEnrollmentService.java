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

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Enrollment;
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

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Interface for enrollment related activities.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface ProviderEnrollmentService {

    /**
     * This method is used to delete a ticket draft. Note that only tickets in draft status can be removed.
     * 
     * @param user
     *            the user performing the operation
     * @param ticketId
     *            the ticket id to be removed
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void removeDraftTicket(CMSUser user, long ticketId) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed and resulted in a rejected change.
     * 
     * @param user
     *            the user who rejected the request
     * @param profileId
     *            the profile to be suspended
     * @param reason
     *            the reason for rejecting the request
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void suspendProvider(CMSUser user, long profileId, String reason) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed and resulted in a rejected change.
     * 
     * @param user
     *            the user who rejected the request
     * @param ticketId
     *            the ticket id that was rejected
     * @param reason
     *            the reason for rejecting the request
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void rejectTicket(CMSUser user, long ticketId, String reason) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed and resulted in an approved change, the
     * ticket is approved AS-IS (e.g. renewal) and there are no changes from the approver.
     * 
     * @param user
     *            the user who approved the request
     * @param ticketId
     *            the ticket id that was approved
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void approveTicket(CMSUser user, long ticketId) throws PortalServiceException;

    /**
     * This is the service method to be called after the process has completed and resulted in an approved change, but
     * the approver made some manual changes to the data so it has to be saved first.
     * 
     * @param user
     *            the user who approved the request
     * @param ticket
     *            the ticket that will be approved (after saving it)
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void approveTicketWithChanges(CMSUser user, Enrollment ticket) throws PortalServiceException;

    /**
     * This is the method to be called to stream the attachment contents to the given output stream directly from the
     * database.
     * 
     * @param user
     *            the current user
     * @param attachmentId
     *            the attachment id to be streamed.
     * @param output
     *            the stream to write the contents to
     * @throws IOException
     *             for any I/O errors while streaming the attachment contents
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void streamContent(CMSUser user, long attachmentId, OutputStream output) throws IOException, PortalServiceException;

    /**
     * This method gets all the providers that meet the search criteria. If none available, the search result will be
     * empty.
     * 
     * @param user
     *            the user performing the action
     * @param criteria
     *            - the search criteria
     * @return - the applicable providers
     * 
     * @throws IllegalArgumentException
     *             if any argument is null, or the page size and page number settings are invalid
     * @throws PortalServiceException
     *             for any errors encountered
     */
    SearchResult<UserRequest> searchTickets(CMSUser user, ProviderSearchCriteria criteria)
            throws PortalServiceException;

    /**
     * This method gets all the providers owned by the given user. If none available, the search result will be empty.
     * 
     * @param user
     *            the user performing the action
     * @return - the applicable providers
     * @throws PortalServiceException
     *             for any errors encountered
     */
    List<ProfileHeader> findMyProfiles(CMSUser user) throws PortalServiceException;

    /**
     * Saves the given ticket as draft.
     * 
     * @param user
     *            the user saving the ticket.
     * @param ticket
     *            the ticket to be saved
     * @return the ticket id for the draft created
     * @throws PortalServiceException
     *             for any errors encountered
     */
    long saveAsDraft(CMSUser user, Enrollment ticket) throws PortalServiceException;

    /**
     * Retrieves the ticket details (full).
     * 
     * @param user
     *            the user getting the ticket.
     * @param processInstanceId
     *            the process instance id to get the details for
     * @return the complete ticket and provider profile
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Enrollment getTicketByProcessInstanceId(CMSUser user, long processInstanceId) throws PortalServiceException;

    /**
     * Retrieves the ticket details (full).
     * 
     * @param user
     *            the user getting the ticket.
     * @param ticketId
     *            the ticket to get the details for
     * @return the complete ticket and provider profile
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Enrollment getTicketDetails(CMSUser user, long ticketId) throws PortalServiceException;

    /**
     * Retrieves the provider details (full).
     * 
     * @param user
     *            the user getting the provider.
     * @param profileId
     *            the profile id to get the details for
     * @return the complete provider profile
     * @throws PortalServiceException
     *             for any errors encountered
     */
    ProviderProfile getProviderDetails(CMSUser user, long profileId) throws PortalServiceException;

    /**
     * Search for practice.
     * 
     * @param user
     *            the user performing the search
     * @param criteria
     *            the criteria filter
     * @return the matching practice results
     * @throws PortalServiceException
     *             for any errors encountered
     */
    SearchResult<PracticeLookup> searchPractice(CMSUser user, PracticeSearchCriteria criteria)
            throws PortalServiceException;

    /**
     * Creates a renewal ticket from the given profile id.
     * 
     * @param user
     *            the user performing the action
     * @param profileId
     *            the profile to be renewed
     * @return the generated ticket
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Enrollment renewProfile(CMSUser user, long profileId) throws PortalServiceException;

    /**
     * Creates an update ticket from the given profile id.
     * 
     * @param user
     *            the user performing the action
     * @param profileId
     *            the profile to be updated
     * @return the generated ticket
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Enrollment editProfile(CMSUser user, long profileId) throws PortalServiceException;

    /**
     * Uploads an attachment to the database.
     * 
     * @param user
     *            the user performing the action
     * @param attachment
     *            the attachment to be uploaded
     * @return the attachment id generated
     * @throws PortalServiceException
     *             for any errors encountered
     */
    long uploadAttachment(CMSUser user, Document attachment) throws PortalServiceException;

    /**
     * Creates a note on a request, the note will remain on the request until it is approved.
     * 
     * @param user
     *            the user performing the action
     * @param ticketId
     *            the request identifier
     * @param text
     *            the note text
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void addNoteToTicket(CMSUser user, long ticketId, String text) throws PortalServiceException;

    /**
     * Creates a note on a profile, the note will also be visible on all active requests.
     * 
     * @param user
     *            the user performing the action
     * @param profileId
     *            the request identifier
     * @param text
     *            the note text
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void addNoteToProfile(CMSUser user, long profileId, String text) throws PortalServiceException;

    /**
     * Used by data onboarding service to fully import a mapped profile.
     * 
     * @param user
     *            the user performing the operation
     * @param sourceSystem
     *            the source of the imported profile
     * @param providerProfile
     *            the profile to be created
     * @return the internal profile id for the imported profile
     * @throws PortalServiceException
     *             for any errors encountered
     */
    long importProfile(CMSUser user, SystemId sourceSystem, ProviderProfile providerProfile)
            throws PortalServiceException;

    /**
     * Retrieves the attachments with the given id.
     * 
     * @param user
     *            the current user
     * @param attachmentId
     *            the attachment to get
     * @return the matching attachment
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Document findAttachment(CMSUser user, long attachmentId) throws PortalServiceException;

    /**
     * Checks the validity status of the ticket.
     * 
     * @param ticketId
     *            the ticket id to check
     * @param profileId
     *            the profile to check
     * @return the validity status of the ticket
     * @throws PortalServiceException
     *             for any errors encountered
     */
    Validity getSubmissionValidity(long ticketId, long profileId) throws PortalServiceException;

    /**
     * Retrieves all the notes for the given ticket.
     * 
     * @param ticketId
     *            the ticket id
     * @return the notes for the ticket of for the referenced profile
     * @throws PortalServiceException
     *             for any errors encountered
     */
    List<Note> findNotes(long ticketId) throws PortalServiceException;

    /**
     * Retrieves public data for enrolled providers by NPI.
     * 
     * @param npi
     *            the npi to search for
     * @return the public lookup data
     * @throws PortalServiceException
     *             for any errors encountered
     */
    List<ProviderLookup> lookupProvider(String npi) throws PortalServiceException;

    /**
     * Direct save (no logical checks) Used by business processes.
     * 
     * @param enrollment
     *            the enrollment to be saved
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void saveEnrollmentDetails(Enrollment enrollment) throws PortalServiceException;

    /**
     * Renews the profiles directly, without making any data changes.
     * 
     * @param currentUser
     *            the current user
     * @param profileIds
     *            the profiles to renew
     * @return
     */
    Long[] renewalProfiles(CMSUser currentUser, Set<Long> profileIds) throws PortalServiceException;

    /**
     * Gets the COS associated with a profile.
     * 
     * @param user
     *            CMS user
     * @param profileId
     *            profile id.
     * @return the list of services
     * 
     * @throws PortalServiceException
     *             for any errors encountered
     */
    List<ProviderCategoryOfService> getProviderCategoryOfServices(CMSUser user, long profileId)
            throws PortalServiceException;

    /**
     * Adds COS to the profile.
     * 
     * @param user
     *            the user performing the action
     * @param categoryOfService
     *            the entity to persist
     * @param prevCatServiceId
     *            if last COS needs an update in end date this will be provided
     * @param prevCatEndDate
     *            last COS end date
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void addCOSToProfile(CMSUser user, ProviderCategoryOfService categoryOfService, long prevCatServiceId,
            Date prevCatEndDate) throws PortalServiceException;

    /**
     * Adds COS to the ticket.
     * 
     * @param user
     *            the user performing the action
     * @param categoryOfService
     *            the entity to persist
     * @param prevCatServiceId
     *            if last COS needs an update in end date this will be provided
     * @param prevCatEndDate
     *            last COS end date
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void addCOSToTicket(CMSUser user, ProviderCategoryOfService categoryOfService, long prevCatServiceId,
            Date prevCatEndDate) throws PortalServiceException;

    /**
     * Deletes the COS by profile.
     * 
     * @param user
     *            the user performing the action
     * @param profileId
     *            the profile id
     * @param id
     *            the cos id
     * 
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void deleteCOSByProfile(CMSUser user, long profileId, long id) throws PortalServiceException;

    /**
     * Gets the COS associated with a ticket.
     * 
     * @param user
     *            CMS user
     * @param ticketId
     *            ticket id.
     * @return the list of services
     * 
     * @throws PortalServiceException
     *             for any errors encountered
     */
    List<ProviderCategoryOfService> getPendingCategoryOfServices(CMSUser user, long ticketId)
            throws PortalServiceException;

    /**
     * Deletes the COS by ticket.
     * 
     * @param user
     *            the user performing the action
     * @param ticketId
     *            the ticket id
     * @param id
     *            the cos id
     * 
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void deleteCOSByTicket(CMSUser user, long ticketId, long id) throws PortalServiceException;

    /**
     * Returns true if the first parameter can be considered an employer of the second.
     *
     * @param externalUserId the employer to be checked
     * @param profileNPI the employee to be checked
     * @return true if there is an affiliation between the two arguments that gives the first access to the latter
     * @throws PortalServiceException for any errors encountered
     */
	boolean hasGroupAffiliation(String externalUserId, String profileNPI) throws PortalServiceException;

	/**
	 * Returns true if there is a profile found in the database with the given NPI
	 * @param profileNPI the NPI to be checked
	 * @return true if a record matches
	 * @throws PortalServiceException for any errors encountered
	 */
	boolean existsProfile(String profileNPI) throws PortalServiceException;

    /**
     * Callback from legacy system for setting the legacy ID.
     * 
     * @param profileId the profile id
     * @param legacyId the legacy id
     * @throws PortalServiceException for any errors encountered 
     */
    void updateLegacyId(long profileId, String legacyId) throws PortalServiceException;
}