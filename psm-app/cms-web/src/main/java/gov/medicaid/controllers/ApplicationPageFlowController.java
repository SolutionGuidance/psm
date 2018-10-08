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
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.SubmitApplicationRequest;
import gov.medicaid.domain.model.SubmitApplicationResponse;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.EmailTemplate;
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
import gov.medicaid.services.ApplicationWebService;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.ProviderApplicationService;
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
 * Handles requests for application pages.
 *
 * @endpoint "/provider/application/*"
 */
@Controller
@RequestMapping("/provider/application/*")
@SessionAttributes("application")
public class ApplicationPageFlowController extends BaseController {

    /**
     * Empty list of errors.
     */
    private static final List<FormError> NO_ERRORS = Collections.emptyList();

    private final ApplicationWebService applicationWebService;
    private final PresentationService presentationService;
    private final ProviderApplicationService applicationService;
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

    public ApplicationPageFlowController(
        ApplicationWebService applicationWebService,
        PresentationService presentationService,
        ProviderApplicationService applicationService,
        NotificationService notificationService,
        ExportService exportService,
        LookupService lookupService
    ) {
        this.applicationWebService = applicationWebService;
        this.presentationService = presentationService;
        this.applicationService = applicationService;
        this.notificationService = notificationService;
        this.exportService = exportService;
        this.lookupService = lookupService;

        CMSConfigurator config = new CMSConfigurator();
        binderRegistry = config.getBinderRegistry();
        formViewRegistry = config.getNewApplicationViewRegistry();
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
     * @endpoint "/provider/application/attachment"
     * @verb GET
     */
    @RequestMapping(value = "/attachment", method = RequestMethod.GET)
    public void download(
            @RequestParam("id") long attachmentId,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        CMSUser user = ControllerHelper.getCurrentUser();
        applicationService.streamContent(user, attachmentId, response);
    }

    /**
     * Starts the application process.
     *
     * @param model the request model
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/start"
     * @verb GET
     */
    @RequestMapping(value = "/start", method = RequestMethod.GET)
    public String startApplication(Model model) throws PortalServiceException {
        ApplicationType applicationType = new ApplicationType();
        applicationType.setRequestType(RequestType.APPLICATION);
        model.addAttribute("application", applicationType);
        return "redirect:/provider/application/steps/type";
    }

    /**
     * Starts the renewal process.
     *
     * @param profileId the profile to renew
     * @param model     the request model
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/renew"
     * @verb GET
     */
    @RequestMapping(value = "/renew", method = RequestMethod.GET)
    public ModelAndView startRenewal(
            @RequestParam("profileId") long profileId,
            Model model
    ) throws PortalServiceException {
        Application application = applicationService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        ApplicationType applicationType = XMLAdapter.toXML(application);
        model.addAttribute("application", applicationType);
        return showPage(null, applicationType);
    }

    /**
     * Starts the renewal process using an old application.
     *
     * @param applicationId the profile to renew
     * @param model    the request model
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/renewApplication"
     * @verb GET
     */
    @RequestMapping(value = "/renewApplication", method = RequestMethod.GET)
    public ModelAndView startRenewalUsingApplication(
            @RequestParam("id") long applicationId,
            Model model
    ) throws PortalServiceException {
        Application oldApplication = applicationService.getApplicationDetails(ControllerHelper.getCurrentUser(), applicationId);
        long profileId = oldApplication.getProfileReferenceId();
        Application application = applicationService.renewProfile(ControllerHelper.getCurrentUser(), profileId);
        ApplicationType applicationType = XMLAdapter.toXML(application);
        model.addAttribute("application", applicationType);
        return showPage(null, applicationType);
    }

    /**
     * Starts the renewal process using an old application.
     *
     * @param applicationId the profile(s) to renew
     * @return the application start page.
     * @endpoint "/provider/application/bulkRenewApplications"
     * @verb POST
     */
    @RequestMapping(value = "/bulkRenewApplications", method = RequestMethod.POST)
    @ResponseBody
    public StatusDTO bulkRenewApplications(
            @RequestParam("ids") long[] applicationIds
    ) {
        Set<Long> profileIds = new HashSet<>();
        StatusDTO results = new StatusDTO();
        try {
            CMSUser user = ControllerHelper.getCurrentUser();
            List<String> supersededList = new ArrayList<>();
            List<String> successfulList = new ArrayList<>();
            List<String> failedList = new ArrayList<>();
            List<String> invalidApplications = new ArrayList<>();
            List<String> invalidDataApplications = new ArrayList<>();

            for (long applicationId : applicationIds) {
                Application oldApplication = applicationService.getApplicationDetails(user, applicationId);
                if (oldApplication.getStatus() != null
                        && oldApplication.getStatus().getDescription().equals(ViewStatics.APPROVED_STATUS)) {
                    long profileId = oldApplication.getProfileReferenceId();
                    if (profileId > 0) {
                        profileIds.add(profileId);
                    } else {
                        invalidDataApplications.add("" + applicationId);
                    }
                } else {
                    invalidApplications.add("" + applicationId);
                }
            }

            Long[] applications = applicationService.renewalProfiles(user, profileIds);

            for (Long applicationId : applications) {
                Application application = applicationService.getApplicationDetails(user, applicationId);
                ApplicationType applicationType = XMLAdapter.toXML(application);
                if (applicationId.intValue() == 0) {
                    invalidDataApplications.add("" + applicationId);
                } else {
                    try {
                        SubmitApplicationRequest serviceRequest = new SubmitApplicationRequest();
                        CMSPrincipal principal = ControllerHelper.getPrincipal();
                        serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
                        serviceRequest.setUsername(principal.getUsername());
                        serviceRequest.setNpi(principal.getUser().getProxyForNPI());
                        serviceRequest.setApplication(applicationType);
                        SubmitApplicationResponse serviceResponse = applicationWebService.submitApplication(serviceRequest);

                        if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                            if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                                supersededList.add("" + applicationId);
                            } else {
                                failedList.add("" + applicationId);
                            }
                        } else {
                            successfulList.add("" + applicationId);
                        }
                    } catch (Exception e) {
                        failedList.add(applicationType.getProviderInformation().getNPI());
                        if (!successfulList.contains(applicationId)) {
                            applicationService.removeDraftApplication(user, applicationId);
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

            if (!invalidApplications.isEmpty()) {
                sb.append("\n");
                sb.append("The following request IDs are not yet approved and cannot be renewed: "
                        + invalidApplications.toString());
            }

            if (!invalidDataApplications.isEmpty()) {
                sb.append("\n");
                sb.append(invalidDataApplications.size() + " other request(s) failed due to invalid data.");
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
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/edit"
     * @verb GET
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView startEdit(
            @RequestParam("profileId") long profileId,
            Model model
    ) throws PortalServiceException {
        Application application = applicationService.editProfile(ControllerHelper.getCurrentUser(), profileId);
        ApplicationType applicationType = XMLAdapter.toXML(application);
        model.addAttribute("application", applicationType);
        return showPage(null, applicationType);
    }

    /**
     * Views the given profile.
     *
     * @param profileId the profile to view
     * @param model     the request model
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/profile"
     * @verb GET
     */
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView viewProfile(
            @RequestParam("id") long profileId,
            Model model
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        ApplicationType applicationType = applicationWebService.getProfile(
                principal.getUsername(),
                principal.getAuthenticatedBySystem().name(),
                principal.getUser().getProxyForNPI(),
                profileId
        );

        model.addAttribute("application", applicationType);
        return showPage(null, applicationType);
    }

    /**
     * Displays the initial provider type selection.
     *
     * @param application the current model
     * @return the provider type selection page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/steps/type"
     * @verb GET
     */
    @RequestMapping(value = "/steps/type", method = RequestMethod.GET)
    public ModelAndView selectProviderType(
            @ModelAttribute("application") ApplicationType applicationType
    ) throws PortalServiceException {
        return showPage(ViewStatics.PROVIDER_TYPE_PAGE, applicationType, null);
    }

    /**
     * Handles requests to go back to the previous page.
     *
     * @param application the current application model
     * @param request    the request
     * @return the previous page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "provider/application/steps/prev"
     * @verb POST
     */
    @RequestMapping(value = "/steps/prev", method = RequestMethod.POST)
    public ModelAndView previousPage(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String[] formNames = request.getParameterValues("formNames");
        String pageName = request.getParameter("pageName");
        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        return showPrevPage(pageName, applicationType);
    }

    /**
     * Handles requests to go to the next page.
     *
     * @param application the current application model
     * @param request    the request
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/steps/next"
     * @verb POST
     */
    @RequestMapping(value = "/steps/next", method = RequestMethod.POST)
    public ModelAndView nextPage(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);

        setPersonDefaults(applicationType);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(applicationType, pageName, formNames);
        if (errors.isEmpty()) {
            return showNextPage(pageName, applicationType);
        } else {
            return showPage(pageName, applicationType, errors);
        }
    }

    /**
     * Sets the defaults for person applications.
     *
     * @param application the application request.
     */
    private void setPersonDefaults(ApplicationType applicationType) {
        if (applicationType.getRequestType() == RequestType.APPLICATION) {
            ProviderInformationType provider = applicationType.getProviderInformation();
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
     * @param application the current application model
     * @param request    the request
     * @return the next page, or the same page if there were errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/steps/rebind"
     * @verb POST
     */
    @RequestMapping(value = "/steps/rebind", method = RequestMethod.POST)
    public ModelAndView rebind(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");
        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        // List<FormError> errors = validate(applicationType, pageName, formNames);
        return showPage(pageName, applicationType);
    }

    /**
     * Loads the given current page of the application process.
     *
     * @param application the application model
     * @return the current page of the application process
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/page"
     * @verb GET
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ModelAndView showPage(
            @ModelAttribute("application") ApplicationType applicationType
    ) throws PortalServiceException {
        return showPage(applicationType.getProgressPage(), applicationType);
    }

    /**
     * Handles requests where request parameters indicate the destination page.
     *
     * @param application the current application model
     * @param request    the request
     * @param status     the session status
     * @return the destination page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "provider/application/steps/page"
     * @verb POST
     */
    @RequestMapping(value = "/page", method = RequestMethod.POST)
    public ModelAndView submitStepForm(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        if (null != request.getParameter("previous")) {
            return previousPage(applicationType, request);
        } else if (null != request.getParameter("next")) {
            return nextPage(applicationType, request);
        } else if (null != request.getParameter("submit") ||
                   null != request.getParameter("submitApplication")) {
            return submit(applicationType, request, status);
        } else if (null != request.getParameter("save")) {
            return save(applicationType, request, status);
        } else if (null != request.getParameter("saveNote")) {
            return saveNote(applicationType, request);
        } else if (null != request.getParameter("resubmitWithChanges")) {
            return resubmitWithChanges(applicationType, request, status);
        }
        throw new PortalServiceException("Submit action not recognized");
    }

    /**
     * Exports the application with the given id.
     *
     * @param applicationId the application to be exported
     * @param response the servlet response
     * @throws IOException            for read/write errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/exportApplication"
     * @verb GET
     */
    @RequestMapping(value = "/exportApplication", method = RequestMethod.GET)
    public void exportApplication(
            @RequestParam("id") long applicationId,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        ApplicationType applicationType = getApplication(applicationId);
        export(applicationType, response);
    }

    /**
     * Exports the given.
     *
     * @param application the application model
     * @param response   the response to write to
     * @throws IOException            for IO related errors
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/export"
     * @verb GET
     */
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void export(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        ModelAndView mv = showPage(ViewStatics.SUMMARY_INFORMATION, applicationType);
        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(ControllerHelper.getCurrentUser(), applicationType, mv.getModel(), response.getOutputStream());
    }

    /**
     * Performs practice lookup.
     *
     * @param criteria the lookup criteria
     * @return the lookup JSON
     * @endpoint "/provider/application/lookup"
     * @verb POST
     */
    @RequestMapping(value = "/lookup", method = RequestMethod.POST)
    @ResponseBody
    public SearchResult<PracticeLookup> lookup(
            PracticeSearchCriteria criteria
    ) {
        CMSUser user = ControllerHelper.getCurrentUser();
        SearchResult<PracticeLookup> results = applicationService.searchPractice(user, criteria);
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
     * @endpoint "/provider/application/lookupProvider"
     * @verb POST
     */
    @RequestMapping(value = "/lookupProvider", method = RequestMethod.POST)
    @ResponseBody
    public List<ProviderLookup> lookupProvider(
            @RequestParam("npi") String npi
    ) {
        List<ProviderLookup> results = applicationService.lookupProvider(npi);
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
     * @endpoint "/provider/application/ownerTypes"
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
     * Loads the given application by id.
     *
     * @param applicationId the application id
     * @param model    the view model
     * @return the edit application page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/view"
     * @verb GET
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public ModelAndView viewApplication(
            @RequestParam("id") long applicationId,
            Model model
    ) throws PortalServiceException {
        ApplicationType applicationType = getApplication(applicationId);
        model.addAttribute("application", applicationType);
        String page = applicationType.getProgressPage();
        if (isSubmitted(applicationType.getStatus())) {
            page = null; // go to first page.
        }

        Role role = ControllerHelper.getCurrentUser().getRole();
        if (ViewStatics.ROLE_SERVICE_ADMINISTRATOR.equals(role.getDescription()) &&
                ViewStatics.PENDING_STATUS.equals(applicationType.getStatus())) {
            model.addAttribute("showReviewLink", true);
        } else {
            model.addAttribute("showReviewLink", false);
        }

        return showPage(page, applicationType);
    }

    /**
     * Loads the given application by id.
     *
     * @param applicationId the application id
     * @param model    the view model
     * @return the edit application page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/reopen"
     * @verb GET
     */
    @RequestMapping(value = "/reopen", method = RequestMethod.GET)
    public ModelAndView modifySubmittedApplication(
            @RequestParam("id") long applicationId,
            Model model
    ) throws PortalServiceException {
        ApplicationType applicationType = getApplication(applicationId);
        applicationType.setReopenedForEdit("Y");
        model.addAttribute("application", applicationType);
        return showPage(null, applicationType);
    }

    /**
     * Retrieves the application.
     *
     * @param applicationId application identifier
     * @return the application
     * @throws PortalServiceException for any errors encountered
     */
    private ApplicationType getApplication(
            long applicationId
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        return applicationWebService.getApplicationDetails(
                principal.getUsername(),
                principal.getAuthenticatedBySystem().name(),
                principal.getUser().getProxyForNPI(),
                applicationId
        );
    }

    /**
     * Loads the given page application.
     *
     * @param application the application model
     * @param toPageName the page to jump to
     * @return the edit application page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/jump"
     * @verb GET
     */
    @RequestMapping(value = "/jump", method = RequestMethod.GET)
    public ModelAndView jump(
            @ModelAttribute("application") ApplicationType applicationType,
            @RequestParam("page") String toPageName
    ) throws PortalServiceException {
        return showPage(toPageName, applicationType);
    }

    /**
     * Loads the given page application.
     *
     * @param application the application model
     * @param toPageName the page to jump to
     * @param request    the request
     * @return the edit application page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/jump"
     * @verb POST
     */
    @RequestMapping(value = "/jump", method = RequestMethod.POST)
    public ModelAndView jump(
            @ModelAttribute("application") ApplicationType applicationType,
            @RequestParam("page") String toPageName,
            HttpServletRequest request
    ) throws PortalServiceException {
        String fromPage = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(fromPage, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(applicationType, fromPage, formNames);
        if (errors.isEmpty()) {
            return showPage(toPageName, applicationType);
        } else {
            return showPage(fromPage, applicationType, errors);
        }
    }

    /**
     * Saves the current application as draft.
     *
     * @param application the current application model
     * @param request    the request
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/saveNote"
     * @verb POST
     */
    @RequestMapping(value = "/saveNote", method = RequestMethod.POST)
    public ModelAndView saveNote(
            @ModelAttribute("application") ApplicationType applicationType,
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
            long applicationId = BinderUtils.getAsLong(applicationType.getObjectId());
            if (applicationId > 0) {
                applicationService.addNoteToApplication(principal.getUser(), applicationId, text);
            }

            return new ModelAndView("redirect:/provider/application/jump?page=Notes");
        } else {
            return showPage("Notes", applicationType, errors);
        }
    }

    /**
     * Saves the current application as draft.
     *
     * @param application the current application model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/save"
     * @verb POST
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView save(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = new ArrayList<>();
        // validate when saving the first page
        if (ViewStatics.INDIVIDUAL_PCA_INFORMATION.equals(pageName)
                || ViewStatics.PERSONAL_INFORMATION.equals(pageName) || ViewStatics.ORGANIZATION_INFO.equals(pageName)) {
            errors = validate(applicationType, pageName, formNames);
        }

        if (errors.isEmpty()) {
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            long applicationId = applicationWebService.saveApplication(
                    principal.getUsername(),
                    principal.getAuthenticatedBySystem().name(),
                    principal.getUser().getProxyForNPI(),
                    applicationType
            );

            ControllerHelper.flashPopup("saveAsDraftModal");
            ModelAndView mv = new ModelAndView("redirect:/provider/application/view");
            mv.addObject("id", applicationId);
            status.setComplete();
            return mv;
        } else {
            return showPage(pageName, applicationType, errors);
        }
    }

    /**
     * Submits the current application.
     *
     * @param application the current application model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/submit"
     * @verb POST
     */
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public ModelAndView submit(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(applicationType, pageName, formNames);
        if (errors.isEmpty()) {
            SubmitApplicationRequest serviceRequest = new SubmitApplicationRequest();
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            serviceRequest.setSystemId(principal.getAuthenticatedBySystem().name());
            serviceRequest.setUsername(principal.getUsername());
            serviceRequest.setNpi(principal.getUser().getProxyForNPI());
            serviceRequest.setApplication(applicationType);
            SubmitApplicationResponse serviceResponse = applicationWebService.submitApplication(serviceRequest);

            ModelAndView mv = new ModelAndView("redirect:/provider/application/view");
            status.setComplete();
            if (!"SUCCESS".equals(serviceResponse.getStatus())) {
                if (Validity.SUPERSEDED.name().equals(serviceResponse.getStatus())) {
                    ControllerHelper.popup("supersededApplication");
                    return showPage(applicationType.getProgressPage(), applicationType);
                } else {
                    mv.addObject("id", serviceResponse.getApplicationNumber());
                    return mv;
                }
            } else {
                mv.addObject("id", serviceResponse.getApplicationNumber());
                ControllerHelper.flashPopup("submitApplicationModal");

                notificationService.sendApplicationNotification(applicationType, EmailTemplate.PENDING_APPLICATION);

                // Issue #215 - add hook for successful submission

                return mv;
            }
        } else {
            return showPage(pageName, applicationType, errors);
        }
    }

    /**
     * Submits the current application.
     *
     * @param application the current application model
     * @param request    the request
     * @param status     the session status
     * @return the same page, with a success/error message
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/application/resubmitWithChanges"
     * @verb POST
     */
    @RequestMapping(value = "/resubmitWithChanges", method = RequestMethod.POST)
    public ModelAndView resubmitWithChanges(
            @ModelAttribute("application") ApplicationType applicationType,
            HttpServletRequest request,
            SessionStatus status
    ) throws PortalServiceException {
        String pageName = request.getParameter("pageName");
        String[] formNames = request.getParameterValues("formNames");

        List<BinderException> exceptions = bindRequest(formNames, applicationType, request);
        if (!exceptions.isEmpty()) {
            ModelAndView inputPage = showPage(pageName, applicationType, NO_ERRORS);
            return addErrorsToPage(inputPage, exceptions);
        }

        List<FormError> errors = validate(applicationType, pageName, formNames);
        if (errors.isEmpty()) {
            CMSPrincipal principal = ControllerHelper.getPrincipal();
            String resubmissionStatus = applicationWebService.resubmitApplication(
                    principal.getUsername(),
                    principal.getAuthenticatedBySystem().name(),
                    principal.getUser().getProxyForNPI(),
                    applicationType
            );

            ModelAndView mv = new ModelAndView("redirect:/provider/application/view");
            status.setComplete();
            if (!"SUCCESS".equals(resubmissionStatus)) {
                if (Validity.SUPERSEDED.name().equals(resubmissionStatus)) {
                    ControllerHelper.popup("supersededApplication");
                    return showPage(applicationType.getProgressPage(), applicationType);
                } else {
                    mv.addObject("id", applicationType.getObjectId());
                    return mv;
                }
            } else {
                mv.addObject("id", applicationType.getObjectId());
                ControllerHelper.flashPopup("submitApplicationModal");

                notificationService.sendApplicationNotification(applicationType, EmailTemplate.MODIFIED_APPLICATION);

                // Issue #215 - add hook for successful resubmission

                return mv;
            }
        } else {
            return showPage(pageName, applicationType, errors);
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
     * @param application the current application model
     * @return the view for the previous page
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPrevPage(
            String pageName,
            ApplicationType applicationType
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);
        List<String> pages = viewModel.getTabNames();

        String prevPage = ViewStatics.PROVIDER_TYPE_PAGE;
        for (String page : pages) {
            if (page.equals(pageName)) {
                break;
            }
            prevPage = page;
        }

        applicationType.setProgressPage(prevPage);
        return new ModelAndView("redirect:/provider/application/page");
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param application the current application mode
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            ApplicationType applicationType
    ) throws PortalServiceException {
        return showPage(pageName, applicationType, NO_ERRORS);
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param application the current application mode
     * @param errors     the errors encountered
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            ApplicationType applicationType,
            List<FormError> errors
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ViewModel viewModel = presentationService.getProviderViewModel(provider);

        if (pageName == null) {
            if (viewModel.getTabNames().isEmpty()) {
                throw new PortalServiceException("No page to show.");
            }
            pageName = viewModel.getTabNames().get(0);

        } else if (!ViewStatics.PROVIDER_TYPE_PAGE.equals(pageName) && !ViewStatics.NOTES_PAGE.equals(pageName)
                && !viewModel.getTabNames().contains(pageName)) {
            if (pageName.equals(applicationType.getProgressPage())) { // no loops
                return showPage(null, applicationType, errors);
            }

            ControllerHelper.flashError("Requested page is not available for this application.");
            return showPage(applicationType.getProgressPage(), applicationType, errors, viewModel);
        }

        return showPage(pageName, applicationType, errors, viewModel);
    }

    /**
     * Shows the requested page.
     *
     * @param pageName   the requested page name
     * @param application the current application mode
     * @param errors     the errors encountered
     * @param viewModel  the view settings
     * @return the page model
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showPage(
            String pageName,
            ApplicationType applicationType,
            List<FormError> errors,
            ViewModel viewModel
    ) throws PortalServiceException {

        viewModel.setCurrentTab(pageName);
        applicationType.setProgressPage(pageName);

        ModelAndView mv = new ModelAndView();
        mv.setViewName(determineViewName(applicationType));

        mv.addObject("errors", errors);
        mv.addObject("pageName", pageName);
        mv.addObject("pageTitle", pageName);
        mv.addObject("viewModel", viewModel);
        mv.addObject("viewRegistry", formViewRegistry);
        mv.addObject("summaryViewRegistry", summaryViewRegistry);

        RequestType requestType = applicationType.getRequestType();
        boolean reopened = "Y".equals(applicationType.getReopenedForEdit());
        mv.addObject("isReopened", reopened);
        if (requestType != null) { // imported data?x
            switch (requestType) {
                case RENEWAL:
                    mv.addObject("isRenewalApplication", true);
                    break;
                default:
                    mv.addObject("isRenewalApplication", false);
                    break;
            }
        }
        bindApplicationDetailsToPage(mv, applicationType);

        // application details

        Map<String, Object> modelMap = new HashMap<>();
        Map<String, UITabModel> pageModels = viewModel.getTabModels();

        boolean readOnly = false;
        if (isSubmitted(applicationType.getStatus()) && !reopened) {
            readOnly = true;
        } else {
            long applicationId = BinderUtils.getAsLong(applicationType.getObjectId());
            if (applicationId > 0) {
                long profileId = BinderUtils.getAsLong(applicationType.getProviderInformation().getObjectId());
                Validity validity = applicationService.getSubmissionValidity(applicationId, profileId);
                if (validity == Validity.STALE) {
                    ControllerHelper.popup("staleApplication");
                }
            }
        }

        CMSUser user = ControllerHelper.getCurrentUser();
        getBinder(ViewStatics.PROVIDER_TYPE_FORM).bindToPage(user, applicationType, modelMap, readOnly);

        if (ViewStatics.SUMMARY_INFORMATION.equals(pageName)) {

            // bind all forms from all pages
            for (String page : viewModel.getTabNames()) {
                UITabModel pageModel = pageModels.get(page);
                List<String> formNames = pageModel.getFormNames();
                for (String form : formNames) {
                    getBinder(form).bindToPage(user, applicationType, modelMap, true);
                }
            }

        } else if (ViewStatics.NOTES_PAGE.equals(pageName)) {

            long applicationId = BinderUtils.getAsLong(applicationType.getObjectId());
            // always get from database as notes are directly managed
            if (applicationId > 0) {
                List<Note> allNotes = applicationService.findNotes(applicationId);
                mv.addObject("profileNotes", allNotes);
            } else {
                throw new PortalServiceRuntimeException("Missing application Id. Only saved requests can have notes.");
            }

        } else {

            // bind only forms for the requested page
            UITabModel pageModel = pageModels.get(pageName);
            if (pageModel != null) {
                List<String> formNames = pageModel.getFormNames();
                if (formNames != null) {
                    for (String form : formNames) {
                        getBinder(form).bindToPage(user, applicationType, modelMap, readOnly);
                    }
                }
            }
        }

        mv.addAllObjects(modelMap);

        return mv;
    }

    /**
     * Adds the application details to the page (not modifiable directly by user).
     *
     * @param mv         the model and view
     * @param application the currently viewed request
     */
    private void bindApplicationDetailsToPage(
            ModelAndView mv,
            ApplicationType applicationType
    ) {
        mv.addObject("_99_states", lookupService.findAllLookups(StateType.class));
        mv.addObject("_99_counties", lookupService.findAllLookups(CountyType.class));

        if (applicationType.getRequestType() != null) {
            mv.addObject("_99_requestType", applicationType.getRequestType().value());
        }
        mv.addObject("_99_requestStatus", applicationType.getStatus());

        if (applicationType.getSubmittedOn() != null) {
            mv.addObject("_99_submittedOn", BinderUtils.formatCalendarTS(applicationType.getSubmittedOn()));
        }

        if (applicationType.getStatusDate() != null) {
            mv.addObject("_99_statusDate", BinderUtils.formatCalendarTS(applicationType.getStatusDate()));
        }

        if (applicationType.getRiskLevel() != null) {
            mv.addObject("_99_riskLevel", applicationType.getRiskLevel().value());
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
     * @param application the application model
     * @return the jsp view for the page
     */
    private String determineViewName(ApplicationType applicationType) {
        String status = applicationType.getStatus();
        if (applicationType.getRequestType() == null) {
            return "provider/application/steps/view_profile_details";
        } else if (isSubmitted(status)) {
            if ("Y".equals(applicationType.getReopenedForEdit())) {
                return "provider/application/steps/edit_details";
            }

            return "provider/application/steps/view_details";
        } else if (applicationType.getRequestType() == RequestType.UPDATE) {
            return "provider/application/steps/edit_details";
        } else {
            return "provider/application/steps/application_step";
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
     * @param application the application model
     * @return the next page
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView showNextPage(
            String pageName,
            ApplicationType applicationType
    ) throws PortalServiceException {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
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

        applicationType.setProgressPage(nextPage);
        return new ModelAndView("redirect:/provider/application/page");
    }

    /**
     * Validates the given application.
     *
     * @param application the application to be validated
     * @param pageName   the current page to validate
     * @param formNames  the names of the forms to be validated
     * @return any errors for the specified forms
     * @throws PortalServiceException for any errors encountered
     */
    private List<FormError> validate(
            ApplicationType applicationType,
            String pageName,
            String[] formNames
    ) throws PortalServiceException {
        List<FormError> errors = new ArrayList<>();
        if (formNames != null) {
            ValidationResponse results = presentationService.checkForErrors(applicationType, Arrays.asList(pageName));
            for (String form : formNames) {
                errors.addAll(getBinder(form).translateErrors(applicationType, results.getValidationResult()));
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
     * @param application the model to bind to
     * @param request    the request
     * @throws PortalServiceException for any other errors encountered
     */
    private List<BinderException> bindRequest(
            String[] formNames,
            ApplicationType applicationType,
            HttpServletRequest request
    ) throws PortalServiceException {

        List<BinderException> exceptions = new ArrayList<>();

        bindFiles(applicationType, request);

        CMSUser user = ControllerHelper.getCurrentUser();
        if (formNames != null) { // submitted forms
            for (String form : formNames) {
                exceptions.addAll(getBinder(form).bindFromPage(user, applicationType, request));
            }
        }

        return exceptions;
    }

    /**
     * Binds uploaded files.
     *
     * @param application the application
     * @param request    the current request
     * @throws PortalServiceException for any errors encountered
     */
    private void bindFiles(
            ApplicationType applicationType,
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
                    long attachmentId = applicationService.uploadAttachment(ControllerHelper.getCurrentUser(),
                            attachment);
                    request.setAttribute(file.getKey(), "" + attachmentId);

                    AttachedDocumentsType at = XMLUtility.nsGetAttachments(applicationType.getProviderInformation());
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
