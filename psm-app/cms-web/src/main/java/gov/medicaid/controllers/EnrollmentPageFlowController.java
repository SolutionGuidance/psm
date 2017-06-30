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
import gov.medicaid.domain.model.GetProfileDetailsRequest;
import gov.medicaid.domain.model.GetProfileDetailsResponse;
import gov.medicaid.domain.model.GetTicketDetailsRequest;
import gov.medicaid.domain.model.GetTicketDetailsResponse;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.ResubmitTicketRequest;
import gov.medicaid.domain.model.ResubmitTicketResponse;
import gov.medicaid.domain.model.SaveTicketRequest;
import gov.medicaid.domain.model.SaveTicketResponse;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.SubmitTicketRequest;
import gov.medicaid.domain.model.SubmitTicketResponse;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Note;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProviderLookup;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.StateType;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.MinimumLicenseRulesModel;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.security.CMSPrincipal;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.EnrollmentWebService;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;
import gov.medicaid.services.util.XMLAdapter;

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
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.topcoder.util.log.Level;

/**
 * Handles requests for enrollment pages.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 * @endpoint "/provider/enrollment/*"
 */
@Controller
@RequestMapping("/provider/enrollment/*")
@SessionAttributes("enrollment")
public class EnrollmentPageFlowController extends BaseController {

    /**
     * Empty list of errors.
     */
    @SuppressWarnings("unchecked")
    public static final List<FormError> NO_ERRORS = (List<FormError>) Collections.EMPTY_LIST;

    /**
     * The enrollment service.
     */
    private EnrollmentWebService enrollmentWebService;

    /**
     * The enrollment service.
     */
    private PresentationService presentationService;

    /**
     * Provider enrollment service.
     */
    private ProviderEnrollmentService enrollmentService;

    /**
     * Used for exporting PDFs.
     */
    private ExportService exportService;

    /**
     * Used for lookup values.
     */
    private LookupService lookupService;

    /**
     * Registry of binders.
     */
    private Map<String, FormBinder> binderRegistry = null;

    /**
     * Registry of forms.
     */
    private Map<String, String> formViewRegistry = null;

    /**
     * Registry of form displays.
     */
    private Map<String, String> summaryViewRegistry = null;

    /**
     * Hash key for hidden input security.
     */
    private String serverHashKey;

    /**
     * Empty constructor.
     */
    public EnrollmentPageFlowController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws PortalServiceConfigurationException
     *             - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (enrollmentWebService == null) {
            throw new PortalServiceConfigurationException("enrollmentWebService is not configured correctly.");
        }
        if (presentationService == null) {
            throw new PortalServiceConfigurationException("presentationService is not configured correctly.");
        }
        if (exportService == null) {
            throw new PortalServiceConfigurationException("exportService is not configured correctly.");
        }

        CMSConfigurator config = new CMSConfigurator();
        binderRegistry = config.getBinderRegistry();
        formViewRegistry = config.getNewEnrollmentViewRegistry();
        summaryViewRegistry = config.getSummaryViewRegistry();
        serverHashKey = config.getServerHashKey();
    }

    /**
     * Downloads an attachment.
     * 
     * @param enrollment
     *            the session model
     * @param attachmentId
     *            the attachment to download
     * @param response
     *            the response to write to
     * @throws IOException
     *             for read/write errors
     * @throws PortalServiceException
     *             for any other errors
     * @endpoint "/provider/enrollment/attachment"
     * @verb GET
     */
    @RequestMapping(value = "/attachment", method = RequestMethod.GET)
    public void download(@ModelAttribute("enrollment") EnrollmentType enrollment,
            @RequestParam("id") long attachmentId, HttpServletResponse response) throws PortalServiceException,
            IOException {

        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(enrollment.getProviderInformation());
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType documentType : attachment) {
            if (documentType.getObjectId().equals("" + attachmentId)) {
                response.setContentType(documentType.getMimeType());
                response.setHeader("Content-Disposition", "attachment; filename=" + documentType.getName());
                break;
            }
        }
        CMSUser user = ControllerHelper.getCurrentUser();
        enrollmentService.streamContent(user, attachmentId, response.getOutputStream());
    }

    /**
     * Starts the enrollment process.
     * 
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/start"
     * @verb GET
     */
    @RequestMapping(value = "/start", method = RequestMethod.GET)
    public String startEnrollment(Model model) throws PortalServiceException {
        EnrollmentType enrollment = new EnrollmentType();
        enrollment.setRequestType(RequestType.ENROLLMENT);
        model.addAttribute("enrollment", enrollment);
        return "redirect:/provider/enrollment/steps/type";
    }

    /**
     * Starts the renewal process.
     * 
     * @param profileId
     *            the profile to renew
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/renew"
     * @verb GET
     */
    @RequestMapping(value = "/renew", method = RequestMethod.GET)
    public ModelAndView startRenewal(@RequestParam("profileId") long profileId, Model model)
            throws PortalServiceException {
        Enrollment ticket = enrollmentService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollment = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollment);
        return showPage(null, enrollment);
    }

    /**
     * Starts the renewal process using an old ticket.
     * 
     * @param ticketId
     *            the profile to renew
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/renewTicket"
     * @verb GET
     */
    @RequestMapping(value = "/renewTicket", method = RequestMethod.GET)
    public ModelAndView startRenewalUsingTicket(@RequestParam("id") long ticketId, Model model)
            throws PortalServiceException {
        Enrollment oldTicket = enrollmentService.getTicketDetails(ControllerHelper.getCurrentUser(), ticketId);
        long profileId = oldTicket.getProfileReferenceId();
        Enrollment ticket = enrollmentService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollment = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollment);
        return showPage(null, enrollment);
    }

    /**
     * Starts the renewal process using an old ticket.
     * 
     * @param ticketId
     *            the profile to renew
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/bulkRenewTickets"
     * @verb POST
     */
    @RequestMapping(value = "/bulkRenewTickets", method = RequestMethod.POST)
    @ResponseBody
    public StatusDTO bulkRenewTickets(@RequestParam("ids") long[] ticketIds, Model model) {
        Set<Long> profileIds = new HashSet<Long>();
        StatusDTO results = new StatusDTO();
        try {
            CMSUser user = ControllerHelper.getCurrentUser();
            List<String> supersededList = new ArrayList<String>();
            List<String> successfulList = new ArrayList<String>();
            List<String> failedList = new ArrayList<String>();
            List<String> invalidTickets = new ArrayList<String>();
            List<String> invalidDataTickets = new ArrayList<String>();

            for (long ticketId : ticketIds) {
                Enrollment oldTicket = enrollmentService.getTicketDetails(user, ticketId);
                if (oldTicket.getStatus() != null
                        && oldTicket.getStatus().getDescription().equals(ViewStatics.APPROVED_STATUS)) {
                    long profileId = oldTicket.getProfileReferenceId();
                    if (profileId > 0) {
                        profileIds.add(profileId);
                    } else {
                        invalidDataTickets.add("" + ticketId);
                    }
                } else {
                    invalidTickets.add("" + ticketId);
                }
            }

            Long[] tickets = enrollmentService.renewalProfiles(user, profileIds);

            for (Long ticketId : tickets) {
                Enrollment ticket = enrollmentService.getTicketDetails(user, ticketId);
                EnrollmentType enrollment = XMLAdapter.toXML(ticket);
                if (ticketId.intValue() == 0) {
                    invalidDataTickets.add("" + ticketId);
                } else {
                    try {
                        SubmitTicketRequest serviceRequest = new SubmitTicketRequest();
                        CMSPrincipal principal = ControllerHelper.getPrincipal();
                        serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
                        serviceRequest.setUsername(principal.getUsername());
                        serviceRequest.setNpi(principal.getUser().getProxyForNPI());
                        serviceRequest.setEnrollment(enrollment);
                        SubmitTicketResponse serviceResponse = enrollmentWebService.submitEnrollment(serviceRequest);

                        if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                            if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                                supersededList.add("" + ticketId);
                            } else {
                                failedList.add("" + ticketId);
                            }
                        } else {
                            successfulList.add("" + ticketId);
                        }
                    } catch (Exception e) {
                        failedList.add(enrollment.getProviderInformation().getNPI());
                        if (!successfulList.contains(ticketId)) {
                            enrollmentService.removeDraftTicket(user, ticketId);
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
     * @param profileId
     *            the profile to edit
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/edit"
     * @verb GET
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView startEdit(@RequestParam("profileId") long profileId, Model model) throws PortalServiceException {
        Enrollment ticket = enrollmentService.editProfile(ControllerHelper.getCurrentUser(), profileId);
        EnrollmentType enrollment = XMLAdapter.toXML(ticket);
        model.addAttribute("enrollment", enrollment);
        return showPage(null, enrollment);
    }

    /**
     * Views the given profile.
     * 
     * @param profileId
     *            the profile to view
     * @param model
     *            the request model
     * @return the enrollment start page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/profile"
     * @verb GET
     */
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView viewProfile(@RequestParam("id") long profileId, Model model) throws PortalServiceException {

        GetProfileDetailsRequest request = new GetProfileDetailsRequest();
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        request.setSystemId(principal.getAuthenticatedBySystem().name());
        request.setUsername(principal.getUsername());
        request.setNpi(principal.getUser().getProxyForNPI());
        request.setProfileId(profileId);
        GetProfileDetailsResponse response = enrollmentWebService.getProfile(request);

        EnrollmentType enrollment = response.getEnrollment();
        model.addAttribute("enrollment", enrollment);
        return showPage(null, enrollment);
    }

    /**
     * Displays the initial provider type selection.
     * 
     * @param enrollment
     *            the current model
     * @return the provider type selection page.
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/steps/type"
     * @verb GET
     */
    @RequestMapping(value = "/steps/type", method = RequestMethod.GET)
    public ModelAndView selectProviderType(@ModelAttribute("enrollment") EnrollmentType enrollment)
            throws PortalServiceException {
        return showPage(ViewStatics.PROVIDER_TYPE_PAGE, enrollment, null);
    }

    /**
     * Handles requests to go back to the previous page.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param model
     *            the request model
     * @return the previous page, or the same page if there were errors
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "provider/enrollment/steps/prev"
     * @verb POST
     */
    @RequestMapping(value = "/steps/prev", method = RequestMethod.POST)
    public ModelAndView previousPage(@ModelAttribute("enrollment") EnrollmentType enrollment,
            HttpServletRequest request, Model model) throws PortalServiceException {

        String[] formNames = request.getParameterValues("formNames");
        String pageName = request.getParameter("pageName");
        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        return showPrevPage(pageName, enrollment);
    }

    /**
     * Handles requests to go to the next page.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param model
     *            the request model
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/steps/next"
     * @verb POST
     */
    @RequestMapping(value = "/steps/next", method = RequestMethod.POST)
    public ModelAndView nextPage(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletRequest request,
            Model model) throws PortalServiceException {

        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);

        setPersonDefaults(enrollment);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        List<FormError> errors = validate(enrollment, pageName, formNames);
        if (errors.isEmpty()) {
            return showNextPage(pageName, enrollment);
        } else {
            return showPage(pageName, enrollment, errors);
        }
    }

    /**
     * Sets the defaults for person applications.
     * 
     * @param enrollment
     *            the enrollment request.
     */
    private void setPersonDefaults(EnrollmentType enrollment) {
        if (enrollment.getRequestType() == RequestType.ENROLLMENT) {
            ProviderInformationType provider = enrollment.getProviderInformation();
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
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param model
     *            the request model
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/steps/rebind"
     * @verb POST
     */
    @RequestMapping(value = "/steps/rebind", method = RequestMethod.POST)
    public ModelAndView rebind(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletRequest request,
            Model model) throws PortalServiceException {

        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        // List<FormError> errors = validate(enrollment, pageName, formNames);
        return showPage(pageName, enrollment);
    }

    /**
     * Loads the given current page of the enrollment process.
     * 
     * @param enrollment
     *            the enrollment model
     * @return the current page of the enrollment process
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/page"
     * @verb GET
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ModelAndView showPage(@ModelAttribute("enrollment") EnrollmentType enrollment) throws PortalServiceException {
        return showPage(enrollment.getProgressPage(), enrollment);
    }

    /**
     * Loads the given current page of the enrollment process.
     * 
     * @param enrollment
     *            the enrollment model
     * @return the current page of the enrollment process
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/print"
     * @verb GET
     */
    @RequestMapping(value = "/print", method = RequestMethod.GET)
    public ModelAndView showPrint(@ModelAttribute("enrollment") EnrollmentType enrollment)
            throws PortalServiceException {
        ModelAndView mv = showPage(ViewStatics.SUMMARY_INFORMATION, enrollment);
        mv.setViewName("provider/enrollment/print_modal");
        return mv;
    }

    /**
     * Shows the print preview for the given ticket.
     * 
     * @param ticketId
     *            the ticket to be exported
     * @return the print preview
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/preview"
     * @verb GET
     */
    @RequestMapping(value = "/preview", method = RequestMethod.GET)
    public ModelAndView showPreview(@RequestParam("id") long ticketId) throws PortalServiceException {
        EnrollmentType ticket = getTicket(ticketId);
        return showPrint(ticket);
    }

    /**
     * Shows the print preview for the given ticket.
     * 
     * @param ticketId
     *            the ticket to be exported
     * @return the print preview
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/reviewPrint"
     * @verb GET
     */
    @RequestMapping(value = "/reviewPrint", method = RequestMethod.GET)
    public ModelAndView reviewPrint(@RequestParam("id") long ticketId) throws PortalServiceException {
        EnrollmentType ticket = getTicket(ticketId);
        ModelAndView mv = showPage(ViewStatics.SUMMARY_INFORMATION, ticket);
        mv.setViewName("admin/service_agent_view_enrollment_details");
        return mv;
    }

    /**
     * Exports the ticket with the given id.
     * 
     * @param ticketId
     *            the ticket to be exported
     * @param response
     *            the servlet response
     * @throws IOException
     *             for read/write errors
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/exportTicket"
     * @verb GET
     */
    @RequestMapping(value = "/exportTicket", method = RequestMethod.GET)
    public void exportTicket(@RequestParam("id") long ticketId, HttpServletResponse response)
            throws PortalServiceException, IOException {
        EnrollmentType ticket = getTicket(ticketId);
        export(ticket, response);
    }

    /**
     * Exports the given.
     * 
     * @param enrollment
     *            the enrollment model
     * @param response
     *            the response to write to
     * @throws IOException
     *             for IO related errors
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/export"
     * @verb GET
     */
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletResponse response)
            throws PortalServiceException, IOException {
        ModelAndView mv = showPage(ViewStatics.SUMMARY_INFORMATION, enrollment);
        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(ControllerHelper.getCurrentUser(), enrollment, mv.getModel(), response.getOutputStream());
    }

    /**
     * Performs practice lookup.
     * 
     * @param criteria
     *            the lookup criteria
     * @return the lookup JSON
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/lookup"
     * @verb POST
     */
    @RequestMapping(value = "/lookup", method = RequestMethod.POST)
    @ResponseBody
    public SearchResult<PracticeLookup> lookup(PracticeSearchCriteria criteria) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        SearchResult<PracticeLookup> results = getEnrollmentService().searchPractice(user, criteria);
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
     * @param npi
     *            the provider NPI
     * @return the lookup JSON
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/lookupProvider"
     * @verb POST
     */
    @RequestMapping(value = "/lookupProvider", method = RequestMethod.POST)
    @ResponseBody
    public List<ProviderLookup> lookupProvider(@RequestParam("npi") String npi) throws PortalServiceException {
        List<ProviderLookup> results = getEnrollmentService().lookupProvider(npi);
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
     * @param entity
     *            type
     * @return the lookup JSON
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/ownerTypes"
     * @verb POST
     */
    @RequestMapping(value = "/ownerTypes", method = RequestMethod.POST)
    @ResponseBody
    public List<BeneficialOwnerType> lookupOwnerTypes(@RequestParam("entityType") String entityType)
            throws PortalServiceException {
        return lookupService.findBeneficialOwnerTypes(entityType);
    }

    /**
     * Performs license type lookup.
     * 
     * @param entity
     *            type
     * @return the lookup JSON
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/lookupMinimumLicenses"
     * @verb POST
     */
    @RequestMapping(value = "/lookupMinimumLicenses", method = RequestMethod.POST)
    @ResponseBody
    public MinimumLicenseRulesModel lookupMinimumLicenses(@ModelAttribute("enrollment") EnrollmentType enrollment,
            HttpServletRequest request, Model model) throws PortalServiceException {

        String[] formNames = request.getParameterValues("formNames");
        bindRequest(formNames, enrollment, request);
        return presentationService.getMinimumLicenseRules(enrollment);
    }

    /**
     * Loads the given enrollment by id.
     * 
     * @param ticketId
     *            the enrollment ticket id
     * @param model
     *            the view model
     * @return the edit ticket page
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/view"
     * @verb GET
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public ModelAndView viewTicket(@RequestParam("id") long ticketId, Model model) throws PortalServiceException {
        EnrollmentType enrollment = getTicket(ticketId);
        model.addAttribute("enrollment", enrollment);
        String page = enrollment.getProgressPage();
        if (isSubmitted(enrollment.getStatus())) {
            page = null; // go to first page.
        }
        return showPage(page, enrollment);
    }

    /**
     * Loads the given enrollment by id.
     * 
     * @param ticketId
     *            the enrollment ticket id
     * @param model
     *            the view model
     * @return the edit ticket page
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/reopen"
     * @verb GET
     */
    @RequestMapping(value = "/reopen", method = RequestMethod.GET)
    public ModelAndView modifySubmittedTicket(@RequestParam("id") long ticketId, Model model)
            throws PortalServiceException {
        EnrollmentType enrollment = getTicket(ticketId);
        enrollment.setReopenedForEdit("Y");
        model.addAttribute("enrollment", enrollment);
        return showPage(null, enrollment);
    }

    /**
     * Retrieves the ticket.
     * 
     * @param ticketId
     *            ticket identifier
     * @return the ticket
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private EnrollmentType getTicket(long ticketId) throws PortalServiceException {
        GetTicketDetailsRequest request = new GetTicketDetailsRequest();
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        request.setSystemId(principal.getAuthenticatedBySystem().name());
        request.setUsername(principal.getUsername());
        request.setNpi(principal.getUser().getProxyForNPI());
        request.setTicketNumber(ticketId);
        GetTicketDetailsResponse response = enrollmentWebService.getTicketDetails(request);

        EnrollmentType enrollment = response.getEnrollment();
        return enrollment;
    }

    /**
     * Loads the given page enrollment.
     * 
     * @param enrollment
     *            the enrollment model
     * @param toPageName
     *            the page to jump to
     * @return the edit ticket page
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/jump"
     * @verb GET
     */
    @RequestMapping(value = "/jump", method = RequestMethod.GET)
    public ModelAndView jump(@ModelAttribute("enrollment") EnrollmentType enrollment,
            @RequestParam("page") String toPageName) throws PortalServiceException {
        return showPage(toPageName, enrollment);
    }

    /**
     * Loads the given page enrollment.
     * 
     * @param enrollment
     *            the enrollment model
     * @param toPageName
     *            the page to jump to
     * @param request
     *            the request
     * @return the edit ticket page
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/jump"
     * @verb POST
     */
    @RequestMapping(value = "/jump", method = RequestMethod.POST)
    public ModelAndView jump(@ModelAttribute("enrollment") EnrollmentType enrollment,
            @RequestParam("page") String toPageName, HttpServletRequest request) throws PortalServiceException {

        String fromPage = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(fromPage, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        List<FormError> errors = validate(enrollment, fromPage, formNames);
        if (errors.isEmpty()) {
            return showPage(toPageName, enrollment);
        } else {
            return showPage(fromPage, enrollment, errors);
        }
    }

    /**
     * Saves the current enrollment ticket as draft.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param status
     *            the session status
     * @param model
     *            the request model
     * @return the same page, with a success/error message
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/saveNote"
     * @verb POST
     */
    @RequestMapping(value = "/saveNote", method = RequestMethod.POST)
    public ModelAndView saveNote(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletRequest request,
            Model model, SessionStatus status) throws PortalServiceException {

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        String text = request.getParameter("noteText");

        ArrayList<FormError> errors = new ArrayList<FormError>();
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
            long ticketId = BinderUtils.getAsLong(enrollment.getObjectId());
            if (ticketId > 0) {
                enrollmentService.addNoteToTicket(principal.getUser(), ticketId, text);
            } else {
                long profileId = BinderUtils.getAsLong(enrollment.getProviderInformation().getObjectId());
                enrollmentService.addNoteToProfile(principal.getUser(), profileId, text);
            }

            return new ModelAndView("redirect:/provider/enrollment/jump?page=Notes");
        } else {
            return showPage("Notes", enrollment, errors);
        }
    }

    /**
     * Saves the current enrollment ticket as draft.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param status
     *            the session status
     * @param model
     *            the request model
     * @return the same page, with a success/error message
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/save"
     * @verb POST
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView save(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletRequest request,
            Model model, SessionStatus status) throws PortalServiceException {

        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        List<FormError> errors = new ArrayList<FormError>();
        // validate when saving the first page
        if (ViewStatics.INDIVIDUAL_PCA_INFORMATION.equals(pageName)
                || ViewStatics.PERSONAL_INFORMATION.equals(pageName) || ViewStatics.ORGANIZATION_INFO.equals(pageName)) {
            errors = validate(enrollment, pageName, formNames);
        }

        if (errors.isEmpty()) {
            SaveTicketRequest serviceRequest = new SaveTicketRequest();
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
            serviceRequest.setUsername(principal.getUsername());
            serviceRequest.setNpi(principal.getUser().getProxyForNPI());
            serviceRequest.setEnrollment(enrollment);
            SaveTicketResponse serviceResponse = enrollmentWebService.saveTicket(serviceRequest);

            ControllerHelper.flashPopup("saveAsDraftModal");
            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            mv.addObject("id", serviceResponse.getTicketNumber());
            status.setComplete();
            return mv;
        } else {
            return showPage(pageName, enrollment, errors);
        }
    }

    /**
     * Submits the current enrollment.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param model
     *            the request model
     * @param status
     *            the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/submit"
     * @verb POST
     */
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public ModelAndView submit(@ModelAttribute("enrollment") EnrollmentType enrollment, HttpServletRequest request,
            Model model, SessionStatus status) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        List<FormError> errors = validate(enrollment, pageName, formNames);
        if (errors.isEmpty()) {
            SubmitTicketRequest serviceRequest = new SubmitTicketRequest();
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
            serviceRequest.setUsername(principal.getUsername());
            serviceRequest.setNpi(principal.getUser().getProxyForNPI());
            serviceRequest.setEnrollment(enrollment);
            SubmitTicketResponse serviceResponse = enrollmentWebService.submitEnrollment(serviceRequest);

            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            status.setComplete();
            if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                    ControllerHelper.popup("supersededTicket");
                    return showPage(enrollment.getProgressPage(), enrollment);
                } else {
                    mv.addObject("id", serviceResponse.getTicketNumber());
                    return mv;
                }
            } else {
                mv.addObject("id", serviceResponse.getTicketNumber());
                ControllerHelper.flashPopup("submitEnrollmentModal");

                // Issue #215 - add hook for successful submission

                return mv;
            }
        } else {
            return showPage(pageName, enrollment, errors);
        }
    }

    /**
     * Submits the current enrollment.
     * 
     * @param enrollment
     *            the current enrollment model
     * @param request
     *            the request
     * @param model
     *            the request model
     * @param status
     *            the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException
     *             for any errors encountered
     * @endpoint "/provider/enrollment/resubmitWithChanges"
     * @verb POST
     */
    @RequestMapping(value = "/resubmitWithChanges", method = RequestMethod.POST)
    public ModelAndView resubmitWithChanges(@ModelAttribute("enrollment") EnrollmentType enrollment,
            HttpServletRequest request, Model model, SessionStatus status) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, enrollment, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, enrollment, NO_ERRORS);
            for (BinderException binderException : exceptions) {
                ControllerHelper.addError(binderException.getMessage());
                inputPage.addObject(binderException.getParameterKey(), binderException.getParameterValue());
            }
            return inputPage;
        }

        List<FormError> errors = validate(enrollment, pageName, formNames);
        if (errors.isEmpty()) {
            ResubmitTicketRequest serviceRequest = new ResubmitTicketRequest();
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
            serviceRequest.setUsername(principal.getUsername());
            serviceRequest.setNpi(principal.getUser().getProxyForNPI());
            serviceRequest.setTicketId(enrollment.getObjectId());
            serviceRequest.setEnrollment(enrollment);
            ResubmitTicketResponse serviceResponse = enrollmentWebService.resubmitEnrollment(serviceRequest);

            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view");
            status.setComplete();
            if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                    ControllerHelper.popup("supersededTicket");
                    return showPage(enrollment.getProgressPage(), enrollment);
                } else {
                    mv.addObject("id", enrollment.getObjectId());
                    return mv;
                }
            } else {
                mv.addObject("id", enrollment.getObjectId());
                ControllerHelper.flashPopup("submitEnrollmentModal");

                // Issue #215 - add hook for successful resubmission

                return mv;
            }
        } else {
            return showPage(pageName, enrollment, errors);
        }
    }

    /**
     * Shows the previous page.
     * 
     * @param pageName
     *            the current page
     * @param enrollment
     *            the current enrollment model
     * @return the view for the previous page
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView showPrevPage(String pageName, EnrollmentType enrollment) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);
        List<String> pages = viewModel.getTabNames();

        String prevPage = ViewStatics.PROVIDER_TYPE_PAGE;
        for (Iterator<String> iterator = pages.iterator(); iterator.hasNext();) {
            String page = iterator.next();
            if (page.equals(pageName)) {
                break;
            }
            prevPage = page;
        }

        enrollment.setProgressPage(prevPage);
        return new ModelAndView("redirect:/provider/enrollment/page");
    }

    /**
     * Shows the requested page.
     * 
     * @param pageName
     *            the requested page name
     * @param enrollment
     *            the current enrollment mode
     * @return the page model
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView showPage(String pageName, EnrollmentType enrollment) throws PortalServiceException {
        return showPage(pageName, enrollment, NO_ERRORS);
    }

    /**
     * Shows the requested page.
     * 
     * @param pageName
     *            the requested page name
     * @param enrollment
     *            the current enrollment mode
     * @param errors
     *            the errors encountered
     * @return the page model
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView showPage(String pageName, EnrollmentType enrollment, List<FormError> errors)
            throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);

        if (pageName == null) {
            if (viewModel.getTabNames().isEmpty()) {
                throw new PortalServiceException("No page to show.");
            }
            pageName = viewModel.getTabNames().get(0);

        } else if (!ViewStatics.PROVIDER_TYPE_PAGE.equals(pageName) && !ViewStatics.NOTES_PAGE.equals(pageName)
                && !viewModel.getTabNames().contains(pageName)) {
            if (pageName.equals(enrollment.getProgressPage())) { // no loops
                return showPage(null, enrollment, errors);
            }

            ControllerHelper.flashError("Requested page is not available for this enrollment.");
            return showPage(enrollment.getProgressPage(), enrollment, errors, viewModel);
        }

        return showPage(pageName, enrollment, errors, viewModel);
    }

    /**
     * Shows the requested page.
     * 
     * @param pageName
     *            the requested page name
     * @param enrollment
     *            the current enrollment mode
     * @param errors
     *            the errors encountered
     * @param viewModel
     *            the view settings
     * @return the page model
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView showPage(String pageName, EnrollmentType enrollment, List<FormError> errors,
            ViewModel viewModel) throws PortalServiceException {

        viewModel.setCurrentTab(pageName);
        enrollment.setProgressPage(pageName);

        ModelAndView mv = new ModelAndView();
        mv.setViewName(determineViewName(pageName, enrollment));

        mv.addObject("errors", errors);
        mv.addObject("pageName", pageName);
        mv.addObject("pageTitle", pageName);
        mv.addObject("viewModel", viewModel);
        mv.addObject("viewRegistry", formViewRegistry);
        mv.addObject("summaryViewRegistry", summaryViewRegistry);

        RequestType requestType = enrollment.getRequestType();
        boolean reopened = "Y".equals(enrollment.getReopenedForEdit());
        mv.addObject("isReopened", reopened);
        if (requestType != null) { // imported data?x
        	switch (requestType) {
        	case UPDATE:
        		mv.addObject("isEditEnrollment", true);
        		mv.addObject("isNewEnrollment", false);
        		mv.addObject("isRenewalEnrollment", false);
        		break;
        	case RENEWAL:
        		mv.addObject("isEditEnrollment", false);
        		mv.addObject("isNewEnrollment", false);
        		mv.addObject("isRenewalEnrollment", true);
        		break;
        	default:
        		mv.addObject("isNewEnrollment", true);
        		mv.addObject("isEditEnrollment", false);
        		mv.addObject("isRenewalEnrollment", false);
        		break;
        	}
        }
        bindTicketDetailsToPage(mv, enrollment);

        // ticket details

        Map<String, Object> modelMap = new HashMap<String, Object>();
        Map<String, UITabModel> pageModels = viewModel.getTabModels();

        boolean readOnly = false;
        if (isSubmitted(enrollment.getStatus()) && !reopened) {
            readOnly = true;
        } else {
            long ticketId = BinderUtils.getAsLong(enrollment.getObjectId());
            if (ticketId > 0) {
                long profileId = BinderUtils.getAsLong(enrollment.getProviderInformation().getObjectId());
                Validity validity = getEnrollmentService().getSubmissionValidity(ticketId, profileId);
                if (validity == Validity.STALE) {
                    ControllerHelper.popup("staleTicket");
                }
            }
        }

        CMSUser user = ControllerHelper.getCurrentUser();
        getBinder(ViewStatics.PROVIDER_TYPE_FORM).bindToPage(user, enrollment, modelMap, readOnly);

        if (ViewStatics.SUMMARY_INFORMATION.equals(pageName)) {

            // bind all forms from all pages
            for (String page : viewModel.getTabNames()) {
                UITabModel pageModel = pageModels.get(page);
                List<String> formNames = pageModel.getFormNames();
                for (String form : formNames) {
                    getBinder(form).bindToPage(user, enrollment, modelMap, true);
                }
            }

        } else if (ViewStatics.NOTES_PAGE.equals(pageName)) {

            long ticketId = BinderUtils.getAsLong(enrollment.getObjectId());
            // always get from database as notes are directly managed
            if (ticketId > 0) {
                List<Note> allNotes = enrollmentService.findNotes(ticketId);
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
                        getBinder(form).bindToPage(user, enrollment, modelMap, readOnly);
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
     * @param mv
     *            the model and view
     * @param enrollment
     *            the currently viewed request
     */
    private void bindTicketDetailsToPage(ModelAndView mv, EnrollmentType enrollment) {
        mv.addObject("_99_states", lookupService.findAllLookups(StateType.class));
        mv.addObject("_99_counties", lookupService.findAllLookups(CountyType.class));
        mv.addObject("_99_legacyInd", enrollment.getProviderInformation().getLegacyTransfer());

        if (enrollment.getRequestType() != null) {
            mv.addObject("_99_requestType", enrollment.getRequestType().value());
        }
        mv.addObject("_99_requestStatus", enrollment.getStatus());

        if (enrollment.getSubmittedOn() != null) {
            mv.addObject("_99_submittedOn", BinderUtils.formatCalendarTS(enrollment.getSubmittedOn()));
        }

        if (enrollment.getStatusDate() != null) {
            mv.addObject("_99_statusDate", BinderUtils.formatCalendarTS(enrollment.getStatusDate()));
        }

        if (enrollment.getRiskLevel() != null) {
            mv.addObject("_99_riskLevel", enrollment.getRiskLevel().value());
        }
    }

    /**
     * Retrieves the configured binder for the named form.
     * 
     * @param form
     *            the name of the form
     * @return the configured binder
     * @throws PortalServiceException
     *             for any errors encountered
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
     * @param pageName
     *            the page name
     * @param enrollment
     *            the enrollment model
     * @return the jsp view for the page
     */
    private String determineViewName(String pageName, EnrollmentType enrollment) {
        String status = enrollment.getStatus();
        if (enrollment.getRequestType() == null) {
            return "provider/enrollment/steps/view_profile_details";
        } else if (isSubmitted(status)) {
            if ("Y".equals(enrollment.getReopenedForEdit())) {
                return "provider/enrollment/steps/edit_details";
            }

            return "provider/enrollment/steps/view_details";
        } else if (enrollment.getRequestType() == RequestType.UPDATE) {
            return "provider/enrollment/steps/edit_details";
        } else {
            return "provider/enrollment/steps/enrollment_step";
        }
    }

    /**
     * Checks if the status is submitted.
     * 
     * @param status
     *            the current status
     * @return true if the status is submitted
     */
    private boolean isSubmitted(String status) {
        return ViewStatics.PENDING_STATUS.equals(status) || ViewStatics.REJECTED_STATUS.equals(status)
                || ViewStatics.APPROVED_STATUS.equals(status);
    }

    /**
     * Shows the next page.
     * 
     * @param pageName
     *            the current page
     * @param enrollment
     *            the enrollment model
     * @return the next page
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView showNextPage(String pageName, EnrollmentType enrollment) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
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

        enrollment.setProgressPage(nextPage);
        return new ModelAndView("redirect:/provider/enrollment/page");
    }

    /**
     * Validates the given enrollment.
     * 
     * @param enrollment
     *            the enrollment to be validated
     * @param pageName
     *            the current page to validate
     * @param formNames
     *            the names of the forms to be validated
     * @return any errors for the specified forms
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private List<FormError> validate(EnrollmentType enrollment, String pageName, String[] formNames)
            throws PortalServiceException {
        List<FormError> errors = new ArrayList<FormError>();
        if (formNames != null) {
            ValidationResponse results = presentationService.checkForErrors(enrollment, Arrays.asList(pageName));
            for (String form : formNames) {
                errors.addAll(getBinder(form).translateErrors(enrollment, results.getValidationResult()));
            }

            OperationStatusType status = results.getValidationResult().getStatus();
            if (status != null) {
                StatusMessagesType statusMessages = status.getStatusMessages();
                if (statusMessages != null) {
                    List<StatusMessageType> errorList = statusMessages.getStatusMessage();
                    for (StatusMessageType error : errorList) {
                        getLog().log(Level.INFO, "Uncaught Error: " + error.getMessage());
                    }
                }
            }
        }
        return errors;
    }

    /**
     * Binds all the submitted forms.
     * 
     * @param formNames
     *            the forms submitted
     * @param enrollment
     *            the model to bind to
     * @param request
     *            the request
     * @throws BinderException
     *             for binding errors due to invalid data type/formats
     * @throws PortalServiceException
     *             for any other errors encountered
     */
    private List<BinderException> bindRequest(String[] formNames, EnrollmentType enrollment, HttpServletRequest request)
            throws PortalServiceException {

        List<BinderException> exceptions = new ArrayList<BinderException>();

        bindFiles(enrollment, request);
        
        CMSUser user = ControllerHelper.getCurrentUser();
        if (formNames != null) { // submitted forms
    		for (String form : formNames) {
    			exceptions.addAll(getBinder(form).bindFromPage(user, enrollment, request));
    		}
        }

        return exceptions;
    }

    /**
     * Binds uploaded files.
     * 
     * @param enrollment
     *            the enrollment
     * @param request
     *            the current request
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private void bindFiles(EnrollmentType enrollment, HttpServletRequest request) throws PortalServiceException {
        if (request instanceof MultipartHttpServletRequest) {
            try {
                MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
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

                    AttachedDocumentsType at = XMLUtility.nsGetAttachments(enrollment.getProviderInformation());
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

    /**
     * Sets the value of the field <code>enrollmentWebService</code>.
     * 
     * @param enrollmentWebService
     *            the enrollmentWebService to set
     */
    public void setEnrollmentWebService(EnrollmentWebService enrollmentWebService) {
        this.enrollmentWebService = enrollmentWebService;
    }

    /**
     * Sets the value of the field <code>presentationService</code>.
     * 
     * @param presentationService
     *            the presentationService to set
     */
    public void setPresentationService(PresentationService presentationService) {
        this.presentationService = presentationService;
    }

    /**
     * Sets the value of the field <code>binderRegistry</code>.
     * 
     * @param binderRegistry
     *            the binderRegistry to set
     */
    public void setBinderRegistry(Map<String, FormBinder> binderRegistry) {
        this.binderRegistry = binderRegistry;
    }

    /**
     * Gets the value of the field <code>enrollmentService</code>.
     * 
     * @return the enrollmentService
     */
    public ProviderEnrollmentService getEnrollmentService() {
        return enrollmentService;
    }

    /**
     * Sets the value of the field <code>enrollmentService</code>.
     * 
     * @param enrollmentService
     *            the enrollmentService to set
     */
    public void setEnrollmentService(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    /**
     * Sets the value of the field <code>exportService</code>.
     * 
     * @param exportService
     *            the exportService to set
     */
    public void setExportService(ExportService exportService) {
        this.exportService = exportService;
    }

    /**
     * Sets the value of the field <code>lookupService</code>.
     * 
     * @param lookupService
     *            the lookupService to set
     */
    public void setLookupService(LookupService lookupService) {
        this.lookupService = lookupService;
    }
}
