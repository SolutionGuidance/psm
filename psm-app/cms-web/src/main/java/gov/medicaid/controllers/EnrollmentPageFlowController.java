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

package gov.medicaid.controllers;

import gov.medicaid.binders.BinderException;
import gov.medicaid.binders.BinderUtils;
import gov.medicaid.binders.FormBinder;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.controllers.dto.StatusDTO;
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.SubmitTicketRequest;
import gov.medicaid.domain.model.SubmitTicketResponse;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Note;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProviderLookup;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.StateType;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.security.CMSPrincipal;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.EnrollmentWebService;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.Util;
import gov.medicaid.services.util.XMLAdapter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import javax.servlet.ServletRequestWrapper;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

/**
 * Handles requests for enrollment pages.
 *
 * @endpoint "/provider/enrollment/*"
 */
@Controller
@RequestMapping("/provider/enrollment/*")
@SessionAttributes("enrollment")
public class EnrollmentPageFlowController extends BaseController {

    /**
     * Empty list of errors.
     */
    private static final List<FormError> NO_ERRORS = Collections.emptyList();

    private final EnrollmentWebService enrollmentWebService;
    private final PresentationService presentationService;
    private final ProviderEnrollmentService enrollmentService;
    private final NotificationService notificationService;
    private final ExportService exportService;
    private final LookupService lookupService;

    /**
     * Registry of binders.
     */
    private final Map<String, FormBinder> binderRegistry;

    /**
     * Registry of forms.
     */
    private final Map<String, String> formViewRegistry;

    /**
     * Registry of form displays.
     */
    private final Map<String, String> summaryViewRegistry;

    /**
     * Hash key for hidden input security.
     */
    private final String serverHashKey;

    public EnrollmentPageFlowController(
        EnrollmentWebService enrollmentWebService,
        PresentationService presentationService,
        ProviderEnrollmentService enrollmentService,
        NotificationService notificationService,
        ExportService exportService,
        LookupService lookupService
    ) {
        this.enrollmentWebService = enrollmentWebService;
        this.presentationService = presentationService;
        this.enrollmentService = enrollmentService;
        this.notificationService = notificationService;
        this.exportService = exportService;
        this.lookupService = lookupService;

        CMSConfigurator config = new CMSConfigurator();
        binderRegistry = config.getBinderRegistry();
        formViewRegistry = config.getNewEnrollmentViewRegistry();
        summaryViewRegistry = config.getSummaryViewRegistry();
        serverHashKey = config.getServerHashKey();
    }

    /**
     * Downloads an attachment.
     *
     * @param attachmentId the attachment to download
     * @param response     the response to write to
     * @throws IOException            for read/write errors
     * @throws PortalServiceException for any other errors
     * @endpoint "/provider/enrollment/attachment"
     * @verb GET
     */
    @RequestMapping(value = "/attachment", method = RequestMethod.GET)
    public void download(
            @RequestParam("id") long attachmentId,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        CMSUser user = ControllerHelper.getCurrentUser();
        enrollmentService.streamContent(user, attachmentId, response);
    }

    /**
     * Starts the enrollment process.
     *
     * @param model the request model
     * @return the enrollment start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/start"
     * @verb GET
     */
    @RequestMapping(value = "/start", method = RequestMethod.GET)
    public String startEnrollment(Model model) throws PortalServiceException {
        EnrollmentType enrollmentType = new EnrollmentType();
        enrollmentType.setRequestType(RequestType.ENROLLMENT);
        model.addAttribute("enrollment", enrollmentType);
        return "redirect:/provider/enrollment/steps/type";
    }

    /**
     * Starts the renewal process.
     *
     * @param profileId the profile to renew
     * @param model     the request model
     * @return the enrollment start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/renew"
     * @verb GET
     */
    @RequestMapping(value = "/renew", method = RequestMethod.GET)
    public ModelAndView startRenewal(
            @RequestParam("profileId") long profileId,
            Model model
    ) throws PortalServiceException {
        Enrollment ticket = enrollmentService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollmentType = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollmentType);
        return showPage(null, enrollmentType);
    }

    /**
     * Starts the renewal process using an old ticket.
     *
     * @param enrollmentId the profile to renew
     * @param model    the request model
     * @return the enrollment start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/renewTicket"
     * @verb GET
     */
    @RequestMapping(value = "/renewTicket", method = RequestMethod.GET)
    public ModelAndView startRenewalUsingTicket(
            @RequestParam("id") long enrollmentId,
            Model model
    ) throws PortalServiceException {
        Enrollment oldTicket = enrollmentService.getTicketDetails(ControllerHelper.getCurrentUser(), enrollmentId);
        long profileId = oldTicket.getProfileReferenceId();
        Enrollment ticket = enrollmentService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollmentType = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollmentType);
        return showPage(null, enrollmentType);
    }

    /**
     * Starts the renewal process using an old ticket.
     *
     * @param enrollmentId the profile(s) to renew
     * @return the enrollment start page.
     * @endpoint "/provider/enrollment/bulkRenewTickets"
     * @verb POST
     */
    @RequestMapping(value = "/bulkRenewTickets", method = RequestMethod.POST)
    @ResponseBody
    public StatusDTO bulkRenewTickets(
            @RequestParam("ids") long[] enrollmentIds
    ) {
        Set<Long> profileIds = new HashSet<>();
        StatusDTO results = new StatusDTO();
        try {
            CMSUser user = ControllerHelper.getCurrentUser();
            List<String> supersededList = new ArrayList<>();
            List<String> successfulList = new ArrayList<>();
            List<String> failedList = new ArrayList<>();
            List<String> invalidTickets = new ArrayList<>();
            List<String> invalidDataTickets = new ArrayList<>();

            for (long enrollmentId : enrollmentIds) {
                Enrollment oldTicket = enrollmentService.getTicketDetails(user, enrollmentId);
                if (oldTicket.getStatus() != null
                        && oldTicket.getStatus().getDescription().equals(ViewStatics.APPROVED_STATUS)) {
                    long profileId = oldTicket.getProfileReferenceId();
                    if (profileId > 0) {
                        profileIds.add(profileId);
                    } else {
                        invalidDataTickets.add("" + enrollmentId);
                    }
                } else {
                    invalidTickets.add("" + enrollmentId);
                }
            }

            Long[] tickets = enrollmentService.renewalProfiles(user, profileIds);

            for (Long enrollmentId : tickets) {
                Enrollment ticket = enrollmentService.getTicketDetails(user, enrollmentId);
                EnrollmentType enrollmentType = XMLAdapter.toXML(ticket);
                if (enrollmentId.intValue() == 0) {
                    invalidDataTickets.add("" + enrollmentId);
                } else {
                    try {
                        SubmitTicketRequest serviceRequest = new SubmitTicketRequest();
                        CMSPrincipal principal = ControllerHelper.getPrincipal();
                        serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
                        serviceRequest.setUsername(principal.getUsername());
                        serviceRequest.setNpi(principal.getUser().getProxyForNPI());
                        serviceRequest.setEnrollment(enrollmentType);
                        SubmitTicketResponse serviceResponse = enrollmentWebService.submitEnrollment(serviceRequest);

                        if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                            if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                                supersededList.add("" + enrollmentId);
                            } else {
                                failedList.add("" + enrollmentId);
                            }
                        } else {
                            successfulList.add("" + enrollmentId);
                        }
                    } catch (Exception e) {
                        failedList.add(enrollmentType.getProviderInformation().getNPI());
                        if (!successfulList.contains(enrollmentId)) {
                            enrollmentService.removeDraftTicket(user, enrollmentId);
                        }
                    }
                }
            }
            results.setSuccess(true);

            StringBuilder sb = new StringBuilder();
            if (!successfulList.isEmpty()) {
                sb.append("Renewal for the following applications have have been submitted: "
                        + successfulList.toString());
            }

            if (!supersededList.isEmpty()) {
                sb.append("\n");
                sb.append("Renewal requests already exist for following applications: " + supersededList.toString());
            }

            if (!failedList.isEmpty()) {
                sb.append("\n");
                sb.append("Renewal failed for the following applications: " + failedList.toString());
            }

            if (!invalidTickets.isEmpty()) {
                sb.append("\n");
                sb.append("The following request IDs are not yet approved and cannot be renewed: "
                        + invalidTickets.toString());
            }

            if (!invalidDataTickets.isEmpty()) {
                sb.append("\n");
                sb.append(invalidDataTickets.size() + " other request(s) failed due to invalid data.");
            }
            results.setMessage(sb.toString());
        } catch (PortalServiceException e) {
            e.printStackTrace();
            results.setSuccess(false);
            results.setMessage("One or more profiles could not be loaded.");
        }
        return results;
    }

    /**
     * Starts the update process.
     *
     * @param profileId the profile to edit
     * @param model     the request model
     * @return the enrollment start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/edit"
     * @verb GET
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView startEdit(
            @RequestParam("profileId") long profileId,
            Model model
    ) throws PortalServiceException {
        Enrollment ticket = enrollmentService.editProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollmentType = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollmentType);
        return showPage(null, enrollmentType);
    }

    /**
     * Views the given profile.
     *
     * @param profileId the profile to view
     * @param model     the request model
     * @return the enrollment start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/profile"
     * @verb GET
     */
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView viewProfile(
            @RequestParam("id") long profileId,
            Model model
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        EnrollmentType enrollmentType = enrollmentWebService.getProfile(
                principal.getUsername(),
                principal.getAuthenticatedBySystem().name(),
                principal.getUser().getProxyForNPI(),
                profileId
        );

        model.addAttribute("enrollment", enrollmentType);
        return showPage(null, enrollmentType);
    }

    /**
     * Displays the initial provider type selection.
     *
     * @param enrollment the current model
     * @return the provider type selection page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/steps/type"
     * @verb GET
     */
    @RequestMapping(value = "/steps/type", method = RequestMethod.GET)
    public ModelAndView selectProviderType(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType
    ) throws PortalServiceException {
        return showPage(ViewStatics.PROVIDER_TYPE_PAGE, enrollmentType, null);
    }

    /**
     * Handles requests to go back to the previous page.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @return the previous page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "provider/enrollment/steps/prev"
     * @verb POST
     */
    @RequestMapping(value = "/steps/prev", method = RequestMethod.POST)
    public ModelAndView previousPage(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String[] formNames = request.getParameterValues("formNames");
        String pageName = request.getParameter("pageName");
        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        return showPrevPage(pageName, enrollmentType);
    }

    /**
     * Handles requests to go to the next page.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/steps/next"
     * @verb POST
     */
    @RequestMapping(value = "/steps/next", method = RequestMethod.POST)
    public ModelAndView nextPage(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);

        setPersonDefaults(enrollmentType);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(enrollmentType, pageName, formNames);
        if (errors.isEmpty()) {
            return showNextPage(pageName, enrollmentType);
        } else {
            return showPage(pageName, enrollmentType, errors);
        }
    }

    /**
     * Sets the defaults for person applications.
     *
     * @param enrollment the enrollment request.
     */
    private void setPersonDefaults(EnrollmentType enrollmentType) {
        if (enrollmentType.getRequestType() == RequestType.ENROLLMENT) {
            ProviderInformationType provider = enrollmentType.getProviderInformation();
            if (provider != null) {
                if (provider.getApplicantType() == ApplicantType.INDIVIDUAL) {
                    if (provider.getApplicantInformation() == null) {
                        provider.setApplicantInformation(new ApplicantInformationType());
                    }

                    ApplicantInformationType applicant = provider.getApplicantInformation();
                    if (applicant.getPersonalInformation() == null) {
                        IndividualApplicantType individualDefaults = new IndividualApplicantType();
                        CMSPrincipal principal = ControllerHelper.getPrincipal();
                        individualDefaults.setFirstName(principal.getUser().getFirstName());
                        individualDefaults.setLastName(principal.getUser().getLastName());
                        individualDefaults.setMiddleName(principal.getUser().getMiddleName());
                        ContactInformationType contact = new ContactInformationType();
                        contact.setEmailAddress(principal.getUser().getEmail());
                        individualDefaults.setContactInformation(contact);
                        applicant.setPersonalInformation(individualDefaults);
                    }
                }
            }
        }
    }

    /**
     * Handles requests to go to the next page.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/steps/rebind"
     * @verb POST
     */
    @RequestMapping(value = "/steps/rebind", method = RequestMethod.POST)
    public ModelAndView rebind(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        // List<FormError> errors = validate(enrollmentType, pageName, formNames);
        return showPage(pageName, enrollmentType);
    }

    /**
     * Loads the given current page of the enrollment process.
     *
     * @param enrollment the enrollment model
     * @return the current page of the enrollment process
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/page"
     * @verb GET
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ModelAndView showPage(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType
    ) throws PortalServiceException {
        return showPage(enrollmentType.getProgressPage(), enrollmentType);
    }

    /**
     * Handles requests where request parameters indicate the destination page.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @param status     the session status
     * @return the destination page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "provider/enrollment/steps/page"
     * @verb POST
     */
    @RequestMapping(value = "/page", method = RequestMethod.POST)
    public ModelAndView submitStepForm(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        if (null != request.getParameter("previous")) {
            return previousPage(enrollmentType, request);
        } else if (null != request.getParameter("next")) {
            return nextPage(enrollmentType, request);
        } else if (null != request.getParameter("submit") ||
                   null != request.getParameter("submitEnrollment")) {
            return submit(enrollmentType, request, status);
        } else if (null != request.getParameter("save")) {
            return save(enrollmentType, request, status);
        } else if (null != request.getParameter("saveNote")) {
            return saveNote(enrollmentType, request);
        } else if (null != request.getParameter("resubmitWithChanges")) {
            return resubmitWithChanges(enrollmentType, request, status);
        }
        throw new PortalServiceException("Submit action not recognized");
    }

    /**
     * Exports the ticket with the given id.
     *
     * @param enrollmentId the ticket to be exported
     * @param response the servlet response
     * @throws IOException            for read/write errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/exportTicket"
     * @verb GET
     */
    @RequestMapping(value = "/exportTicket", method = RequestMethod.GET)
    public void exportTicket(
            @RequestParam("id") long enrollmentId,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        EnrollmentType enrollmentType = getTicket(enrollmentId);
        export(enrollmentType, response);
    }

    /**
     * Exports the given.
     *
     * @param enrollment the enrollment model
     * @param response   the response to write to
     * @throws IOException            for IO related errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/export"
     * @verb GET
     */
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        ModelAndView mv = showPage(ViewStatics.SUMMARY_INFORMATION, enrollmentType);
        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(ControllerHelper.getCurrentUser(), enrollmentType, mv.getModel(), response.getOutputStream());
    }

    /**
     * Performs practice lookup.
     *
     * @param criteria the lookup criteria
     * @return the lookup JSON
     * @endpoint "/provider/enrollment/lookup"
     * @verb POST
     */
    @RequestMapping(value = "/lookup", method = RequestMethod.POST)
    @ResponseBody
    public SearchResult<PracticeLookup> lookup(
            PracticeSearchCriteria criteria
    ) {
        CMSUser user = ControllerHelper.getCurrentUser();
        SearchResult<PracticeLookup> results = enrollmentService.searchPractice(user, criteria);
        List<PracticeLookup> items = results.getItems();
        if (items != null) {
            for (PracticeLookup item : items) {
                String hash = Util.hash("" + item.getProfileId(), serverHashKey);
                item.setProfileIdHash(hash);
            }
        }
        return results;
    }

    /**
     * Performs provider lookup.
     *
     * @param npi the provider NPI
     * @return the lookup JSON
     * @endpoint "/provider/enrollment/lookupProvider"
     * @verb POST
     */
    @RequestMapping(value = "/lookupProvider", method = RequestMethod.POST)
    @ResponseBody
    public List<ProviderLookup> lookupProvider(
            @RequestParam("npi") String npi
    ) {
        List<ProviderLookup> results = enrollmentService.lookupProvider(npi);
        if (results != null) {
            for (ProviderLookup item : results) {
                String hash = Util.hash("" + item.getProfileId(), serverHashKey);
                item.setProfileIdHash(hash);
            }
        }
        return results;
    }

    /**
     * Performs beneficial owner type lookup.
     *
     * @param entityType The owner type to look up
     * @return the lookup JSON
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/ownerTypes"
     * @verb POST
     */
    @RequestMapping(value = "/ownerTypes", method = RequestMethod.POST)
    @ResponseBody
    public List<BeneficialOwnerType> lookupOwnerTypes(
            @RequestParam("entityType") String entityType
    ) throws PortalServiceException {
        return lookupService.findBeneficialOwnerTypes(entityType);
    }

    /**
     * Loads the given enrollment by id.
     *
     * @param enrollmentId the enrollment ticket id
     * @param model    the view model
     * @return the edit ticket page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/view"
     * @verb GET
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public ModelAndView viewTicket(
            @RequestParam("id") long enrollmentId,
            Model model
    ) throws PortalServiceException {
        EnrollmentType enrollmentType = getTicket(enrollmentId);
        model.addAttribute("enrollment", enrollmentType);
        String page = enrollmentType.getProgressPage();
        if (isSubmitted(enrollmentType.getStatus())) {
            page = null; // go to first page.
        }

        Role role = ControllerHelper.getCurrentUser().getRole();
        if (ViewStatics.ROLE_SERVICE_ADMINISTRATOR.equals(role.getDescription()) &&
                ViewStatics.PENDING_STATUS.equals(enrollmentType.getStatus())) {
            model.addAttribute("showReviewLink", true);
        } else {
            model.addAttribute("showReviewLink", false);
        }

        return showPage(page, enrollmentType);
    }

    /**
     * Loads the given enrollment by id.
     *
     * @param enrollmentId the enrollment ticket id
     * @param model    the view model
     * @return the edit ticket page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/reopen"
     * @verb GET
     */
    @RequestMapping(value = "/reopen", method = RequestMethod.GET)
    public ModelAndView modifySubmittedTicket(
            @RequestParam("id") long enrollmentId,
            Model model
    ) throws PortalServiceException {
        EnrollmentType enrollmentType = getTicket(enrollmentId);
        enrollmentType.setReopenedForEdit("Y");
        model.addAttribute("enrollment", enrollmentType);
        return showPage(null, enrollmentType);
    }

    /**
     * Retrieves the ticket.
     *
     * @param enrollmentId ticket identifier
     * @return the ticket
     * @throws PortalServiceException for any errors encountered
     */
    private EnrollmentType getTicket(
            long enrollmentId
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        return enrollmentWebService.getTicketDetails(
                principal.getUsername(),
                principal.getAuthenticatedBySystem().name(),
                principal.getUser().getProxyForNPI(),
                enrollmentId
        );
    }

    /**
     * Loads the given page enrollment.
     *
     * @param enrollment the enrollment model
     * @param toPageName the page to jump to
     * @return the edit ticket page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/jump"
     * @verb GET
     */
    @RequestMapping(value = "/jump", method = RequestMethod.GET)
    public ModelAndView jump(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            @RequestParam("page") String toPageName
    ) throws PortalServiceException {
        return showPage(toPageName, enrollmentType);
    }

    /**
     * Loads the given page enrollment.
     *
     * @param enrollment the enrollment model
     * @param toPageName the page to jump to
     * @param request    the request
     * @return the edit ticket page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/jump"
     * @verb POST
     */
    @RequestMapping(value = "/jump", method = RequestMethod.POST)
    public ModelAndView jump(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            @RequestParam("page") String toPageName,
            HttpServletRequest request
    ) throws PortalServiceException {
        String fromPage = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(fromPage, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(enrollmentType, fromPage, formNames);
        if (errors.isEmpty()) {
            return showPage(toPageName, enrollmentType);
        } else {
            return showPage(fromPage, enrollmentType, errors);
        }
    }

    /**
     * Saves the current enrollment ticket as draft.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/saveNote"
     * @verb POST
     */
    @RequestMapping(value = "/saveNote", method = RequestMethod.POST)
    public ModelAndView saveNote(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        String text = request.getParameter("noteText");

        List<FormError> errors = new ArrayList<>();
        if (Util.isBlank(text)) {
            FormError error = new FormError();
            error.setFieldId("noteText");
            error.setMessage("Note cannot be empty.");
            errors.add(error);
        } else if (text.length() > 250) {
            FormError error = new FormError();
            error.setFieldId("noteText");
            error.setMessage("Note cannot exceed 250 characters.");
            errors.add(error);
        }

        if (errors.isEmpty()) {
            long enrollmentId = BinderUtils.getAsLong(enrollmentType.getObjectId());
            if (enrollmentId > 0) {
                enrollmentService.addNoteToTicket(principal.getUser(), enrollmentId, text);
            } else {
                long profileId = BinderUtils.getAsLong(enrollmentType.getProviderInformation().getObjectId());
                enrollmentService.addNoteToProfile(principal.getUser(), profileId, text);
            }

            return new ModelAndView("redirect:/provider/enrollment/jump?page=Notes");
        } else {
            return showPage("Notes", enrollmentType, errors);
        }
    }

    /**
     * Saves the current enrollment ticket as draft.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/save"
     * @verb POST
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView save(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = new ArrayList<>();
        // validate when saving the first page
        if (ViewStatics.INDIVIDUAL_PCA_INFORMATION.equals(pageName)
                || ViewStatics.PERSONAL_INFORMATION.equals(pageName) || ViewStatics.ORGANIZATION_INFO.equals(pageName)) {
            errors = validate(enrollmentType, pageName, formNames);
        }

        if (errors.isEmpty()) {
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            long enrollmentId = enrollmentWebService.saveTicket(
                    principal.getUsername(),
                    principal.getAuthenticatedBySystem().name(),
                    principal.getUser().getProxyForNPI(),
                    enrollmentType
            );

            ControllerHelper.flashPopup("saveAsDraftModal");
            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            mv.addObject("id", enrollmentId);
            status.setComplete();
            return mv;
        } else {
            return showPage(pageName, enrollmentType, errors);
        }
    }

    /**
     * Submits the current enrollment.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/submit"
     * @verb POST
     */
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public ModelAndView submit(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(enrollmentType, pageName, formNames);
        if (errors.isEmpty()) {
            SubmitTicketRequest serviceRequest = new SubmitTicketRequest();
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
            serviceRequest.setUsername(principal.getUsername());
            serviceRequest.setNpi(principal.getUser().getProxyForNPI());
            serviceRequest.setEnrollment(enrollmentType);
            SubmitTicketResponse serviceResponse = enrollmentWebService.submitEnrollment(serviceRequest);

            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            status.setComplete();
            if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                    ControllerHelper.popup("supersededTicket");
                    return showPage(enrollmentType.getProgressPage(), enrollmentType);
                } else {
                    mv.addObject("id", serviceResponse.getTicketNumber());
                    return mv;
                }
            } else {
                mv.addObject("id", serviceResponse.getTicketNumber());
                ControllerHelper.flashPopup("submitEnrollmentModal");

                notificationService.sendEnrollmentNotification(enrollmentType, EmailTemplate.PENDING_ENROLLMENT);

                // Issue #215 - add hook for successful submission

                return mv;
            }
        } else {
            return showPage(pageName, enrollmentType, errors);
        }
    }

    /**
     * Submits the current enrollment.
     *
     * @param enrollment the current enrollment model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/enrollment/resubmitWithChanges"
     * @verb POST
     */
    @RequestMapping(value = "/resubmitWithChanges", method = RequestMethod.POST)
    public ModelAndView resubmitWithChanges(
            @ModelAttribute("enrollment") EnrollmentType enrollmentType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollmentType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollmentType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(enrollmentType, pageName, formNames);
        if (errors.isEmpty()) {
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            String resubmissionStatus = enrollmentWebService.resubmitEnrollment(
                    principal.getUsername(),
                    principal.getAuthenticatedBySystem().name(),
                    principal.getUser().getProxyForNPI(),
                    enrollmentType
            );

            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            status.setComplete();
            if (!"SUCCESS".equals(resubmissionStatus)) {
                if (Validity.SUPERSEDED.name().equals(resubmissionStatus)) {
                    ControllerHelper.popup("supersededTicket");
                    return showPage(enrollmentType.getProgressPage(), enrollmentType);
                } else {
                    mv.addObject("id", enrollmentType.getObjectId());
                    return mv;
                }
            } else {
                mv.addObject("id", enrollmentType.getObjectId());
                ControllerHelper.flashPopup("submitEnrollmentModal");

                notificationService.sendEnrollmentNotification(enrollmentType, EmailTemplate.MODIFIED_ENROLLMENT);

                // Issue #215 - add hook for successful resubmission

                return mv;
            }
        } else {
            return showPage(pageName, enrollmentType, errors);
        }
    }

    private ModelAndView addErrorsToPage(
            ModelAndView page,
            List<BinderException> exceptions
    ) {
        for (BinderException binderException : exceptions) {
            ControllerHelper.addError(binderException.getMessage());
            page.addObject(
                    binderException.getParameterKey(),
                    binderException.getParameterValue()
            );
        }
        return page;
    }

    /**
     * Shows the previous page.
     *
     * @param pageName   the current page
     * @param enrollment the current enrollment model
     * @return the view for the previous page
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPrevPage(
            String pageName,
            EnrollmentType enrollmentType
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollmentType);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);
        List<String> pages = viewModel.getTabNames();

        String prevPage = ViewStatics.PROVIDER_TYPE_PAGE;
        for (String page : pages) {
            if (page.equals(pageName)) {
                break;
            }
            prevPage = page;
        }

        enrollmentType.setProgressPage(prevPage);
        return new ModelAndView("redirect:/provider/enrollment/page");
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param enrollment the current enrollment mode
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            EnrollmentType enrollmentType
    ) throws PortalServiceException {
        return showPage(pageName, enrollmentType, NO_ERRORS);
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param enrollment the current enrollment mode
     * @param errors     the errors encountered
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            EnrollmentType enrollmentType,
            List<FormError> errors
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollmentType);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);

        if (pageName == null) {
            if (viewModel.getTabNames().isEmpty()) {
                throw new PortalServiceException("No page to show.");
            }
            pageName = viewModel.getTabNames().get(0);

        } else if (!ViewStatics.PROVIDER_TYPE_PAGE.equals(pageName) && !ViewStatics.NOTES_PAGE.equals(pageName)
                && !viewModel.getTabNames().contains(pageName)) {
            if (pageName.equals(enrollmentType.getProgressPage())) { // no loops
                return showPage(null, enrollmentType, errors);
            }

            ControllerHelper.flashError("Requested page is not available for this enrollment.");
            return showPage(enrollmentType.getProgressPage(), enrollmentType, errors, viewModel);
        }

        return showPage(pageName, enrollmentType, errors, viewModel);
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param enrollment the current enrollment mode
     * @param errors     the errors encountered
     * @param viewModel  the view settings
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            EnrollmentType enrollmentType,
            List<FormError> errors,
            ViewModel viewModel
    ) throws PortalServiceException {

        viewModel.setCurrentTab(pageName);
        enrollmentType.setProgressPage(pageName);

        ModelAndView mv = new ModelAndView();
        mv.setViewName(determineViewName(enrollmentType));

        mv.addObject("errors", errors);
        mv.addObject("pageName", pageName);
        mv.addObject("pageTitle", pageName);
        mv.addObject("viewModel", viewModel);
        mv.addObject("viewRegistry", formViewRegistry);
        mv.addObject("summaryViewRegistry", summaryViewRegistry);

        RequestType requestType = enrollmentType.getRequestType();
        boolean reopened = "Y".equals(enrollmentType.getReopenedForEdit());
        mv.addObject("isReopened", reopened);
        if (requestType != null) { // imported data?x
            switch (requestType) {
                case RENEWAL:
                    mv.addObject("isRenewalEnrollment", true);
                    break;
                default:
                    mv.addObject("isRenewalEnrollment", false);
                    break;
            }
        }
        bindTicketDetailsToPage(mv, enrollmentType);

        // ticket details

        Map<String, Object> modelMap = new HashMap<>();
        Map<String, UITabModel> pageModels = viewModel.getTabModels();

        boolean readOnly = false;
        if (isSubmitted(enrollmentType.getStatus()) && !reopened) {
            readOnly = true;
        } else {
            long enrollmentId = BinderUtils.getAsLong(enrollmentType.getObjectId());
            if (enrollmentId > 0) {
                long profileId = BinderUtils.getAsLong(enrollmentType.getProviderInformation().getObjectId());
                Validity validity = getEnrollmentService().getSubmissionValidity(enrollmentId, profileId);
                if (validity == Validity.STALE) {
                    ControllerHelper.popup("staleTicket");
                }
            }
        }

        CMSUser user = ControllerHelper.getCurrentUser();
        getBinder(ViewStatics.PROVIDER_TYPE_FORM).bindToPage(user, enrollmentType, modelMap, readOnly);

        if (ViewStatics.SUMMARY_INFORMATION.equals(pageName)) {

            // bind all forms from all pages
            for (String page : viewModel.getTabNames()) {
                UITabModel pageModel = pageModels.get(page);
                List<String> formNames = pageModel.getFormNames();
                for (String form : formNames) {
                    getBinder(form).bindToPage(user, enrollmentType, modelMap, true);
                }
            }

        } else if (ViewStatics.NOTES_PAGE.equals(pageName)) {

            long enrollmentId = BinderUtils.getAsLong(enrollmentType.getObjectId());
            // always get from database as notes are directly managed
            if (enrollmentId > 0) {
                List<Note> allNotes = enrollmentService.findNotes(enrollmentId);
                mv.addObject("profileNotes", allNotes);
            } else {
                throw new PortalServiceRuntimeException("Missing ticket Id. Only saved requests can have notes.");
            }

        } else {

            // bind only forms for the requested page
            UITabModel pageModel = pageModels.get(pageName);
            if (pageModel != null) {
                List<String> formNames = pageModel.getFormNames();
                if (formNames != null) {
                    for (String form : formNames) {
                        getBinder(form).bindToPage(user, enrollmentType, modelMap, readOnly);
                    }
                }
            }
        }

        mv.addAllObjects(modelMap);

        return mv;
    }

    /**
     * Adds the ticket details to the page (not modifiable directly by user).
     *
     * @param mv         the model and view
     * @param enrollment the currently viewed request
     */
    private void bindTicketDetailsToPage(
            ModelAndView mv,
            EnrollmentType enrollmentType
    ) {
        mv.addObject("_99_states", lookupService.findAllLookups(StateType.class));
        mv.addObject("_99_counties", lookupService.findAllLookups(CountyType.class));

        if (enrollmentType.getRequestType() != null) {
            mv.addObject("_99_requestType", enrollmentType.getRequestType().value());
        }
        mv.addObject("_99_requestStatus", enrollmentType.getStatus());

        if (enrollmentType.getSubmittedOn() != null) {
            mv.addObject("_99_submittedOn", BinderUtils.formatCalendarTS(enrollmentType.getSubmittedOn()));
        }

        if (enrollmentType.getStatusDate() != null) {
            mv.addObject("_99_statusDate", BinderUtils.formatCalendarTS(enrollmentType.getStatusDate()));
        }

        if (enrollmentType.getRiskLevel() != null) {
            mv.addObject("_99_riskLevel", enrollmentType.getRiskLevel().value());
        }
    }

    /**
     * Retrieves the configured binder for the named form.
     *
     * @param form the name of the form
     * @return the configured binder
     * @throws PortalServiceException for any errors encountered
     */
    private FormBinder getBinder(String form) throws PortalServiceException {
        FormBinder formBinder = binderRegistry.get(form);
        if (formBinder == null) {
            throw new PortalServiceException("No Binder found for : " + form);
        }

        return formBinder;
    }

    /**
     * Determines the JSP name for the given page.
     *
     * @param enrollment the enrollment model
     * @return the jsp view for the page
     */
    private String determineViewName(EnrollmentType enrollmentType) {
        String status = enrollmentType.getStatus();
        if (enrollmentType.getRequestType() == null) {
            return "provider/enrollment/steps/view_profile_details";
        } else if (isSubmitted(status)) {
            if ("Y".equals(enrollmentType.getReopenedForEdit())) {
                return "provider/enrollment/steps/edit_details";
            }

            return "provider/enrollment/steps/view_details";
        } else if (enrollmentType.getRequestType() == RequestType.UPDATE) {
            return "provider/enrollment/steps/edit_details";
        } else {
            return "provider/enrollment/steps/enrollment_step";
        }
    }

    /**
     * Checks if the status is submitted.
     *
     * @param status the current status
     * @return true if the status is submitted
     */
    private boolean isSubmitted(String status) {
        return ViewStatics.PENDING_STATUS.equals(status)
                || ViewStatics.REJECTED_STATUS.equals(status)
                || ViewStatics.APPROVED_STATUS.equals(status);
    }

    /**
     * Shows the next page.
     *
     * @param pageName   the current page
     * @param enrollment the enrollment model
     * @return the next page
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showNextPage(
            String pageName,
            EnrollmentType enrollmentType
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollmentType);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);
        List<String> pages = viewModel.getTabNames();

        String nextPage = null;
        for (Iterator<String> iterator = pages.iterator(); iterator.hasNext();) {
            String page = iterator.next();
            if (page.equals(pageName)) {
                if (!iterator.hasNext()) {
                    throw new PortalServiceException("Already at last page.");
                }

                nextPage = iterator.next();
                break;
            }
        }

        if (nextPage == null) {
            nextPage = pages.iterator().next();
        }

        enrollmentType.setProgressPage(nextPage);
        return new ModelAndView("redirect:/provider/enrollment/page");
    }

    /**
     * Validates the given enrollment.
     *
     * @param enrollment the enrollment to be validated
     * @param pageName   the current page to validate
     * @param formNames  the names of the forms to be validated
     * @return any errors for the specified forms
     * @throws PortalServiceException for any errors encountered
     */
    private List<FormError> validate(
            EnrollmentType enrollmentType,
            String pageName,
            String[] formNames
    ) throws PortalServiceException {
        List<FormError> errors = new ArrayList<>();
        if (formNames != null) {
            ValidationResponse results = presentationService.checkForErrors(enrollmentType, Arrays.asList(pageName));
            for (String form : formNames) {
                errors.addAll(getBinder(form).translateErrors(enrollmentType, results.getValidationResult()));
            }

            OperationStatusType status = results.getValidationResult().getStatus();
            if (status != null) {
                StatusMessagesType statusMessages = status.getStatusMessages();
                if (statusMessages != null) {
                    List<StatusMessageType> errorList = statusMessages.getStatusMessage();
                    for (StatusMessageType error : errorList) {
                        getLogger().info("Uncaught Error: " + error.getMessage());
                    }
                }
            }
        }
        return errors;
    }

    /**
     * Binds all the submitted forms.
     *
     * @param formNames  the forms submitted
     * @param enrollment the model to bind to
     * @param request    the request
     * @throws PortalServiceException for any other errors encountered
     */
    private List<BinderException> bindRequest(
            String[] formNames,
            EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {

        List<BinderException> exceptions = new ArrayList<>();

        bindFiles(enrollmentType, request);

        CMSUser user = ControllerHelper.getCurrentUser();
        if (formNames != null) { // submitted forms
            for (String form : formNames) {
                exceptions.addAll(getBinder(form).bindFromPage(user, enrollmentType, request));
            }
        }

        return exceptions;
    }

    /**
     * Binds uploaded files.
     *
     * @param enrollment the enrollment
     * @param request    the current request
     * @throws PortalServiceException for any errors encountered
     */
    private void bindFiles(
            EnrollmentType enrollmentType,
            HttpServletRequest request
    ) throws PortalServiceException {
        Optional<MultipartHttpServletRequest> unwrappedRequest
                = unwrapMultipartRequest(request);
        if (unwrappedRequest.isPresent()) {
            try {
                MultipartHttpServletRequest multipart = unwrappedRequest.get();
                Map<String, MultipartFile> uploads = multipart.getFileMap();
                for (Entry<String, MultipartFile> file : uploads.entrySet()) {
                    Document attachment = new Document();
                    MultipartFile f = file.getValue();
                    if (f.getSize() == 0) {
                        continue;
                    }

                    attachment.setStream(new ByteArrayInputStream(f.getBytes()));
                    attachment.setFilename(f.getOriginalFilename());
                    attachment.setType(f.getContentType());
                    long attachmentId = enrollmentService.uploadAttachment(ControllerHelper.getCurrentUser(),
                            attachment);
                    request.setAttribute(file.getKey(), "" + attachmentId);

                    AttachedDocumentsType at = XMLUtility.nsGetAttachments(enrollmentType.getProviderInformation());
                    DocumentType doc = new DocumentType();
                    doc.setObjectId("" + attachmentId);
                    doc.setName(attachment.getFilename());
                    doc.setMimeType(attachment.getType());
                    at.getAttachment().add(doc);
                }
            } catch (IOException e) {
                throw new PortalServiceException("Could not read uploaded file", e);
            }
        }
    }

    private Optional<MultipartHttpServletRequest> unwrapMultipartRequest(
            ServletRequest request
    ) {
        if (request instanceof MultipartHttpServletRequest) {
            return Optional.of((MultipartHttpServletRequest) request);
        } else if (request instanceof ServletRequestWrapper) {
            return unwrapMultipartRequest(
                    ((ServletRequestWrapper) request).getRequest()
            );
        } else {
            return Optional.empty();
        }
    }
}
