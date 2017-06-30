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
package gov.medicaid.controllers.admin;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.controllers.BaseController;
import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.controllers.dto.ApprovalDTO;
import gov.medicaid.controllers.dto.StatusDTO;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.LicenseInformationType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProcessResultsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CategoryOfService;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.Event;
import gov.medicaid.entities.HelpItem;
import gov.medicaid.entities.HelpSearchCriteria;
import gov.medicaid.entities.ProviderCategoryOfService;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.entities.RequestType;
import gov.medicaid.entities.RiskLevel;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.EventService;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.HelpService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.ProviderTypeService;
import gov.medicaid.services.ScreeningService;
import gov.medicaid.services.util.LogUtil;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.jbpm.task.query.TaskSummary;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class manages enrollments, except for their creation and update.
 * </p>
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class EnrollmentController extends BaseController {

    /**
     * The generic error message to be presented to the user.
     */
    private static final String USER_ERROR_MSG = "There was a problem processing your request, please contact support.";

    /**
     * The business process task name for approval.
     */
    private static final String APPROVAL_TASK_NAME = "Screening Review";

    /**
     * Client interface for the jBPM enrollment service. It is managed with a getter and setter, may have any value, but
     * is expected to be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to
     * change after dependency injection
     */
    private ProviderEnrollmentService enrollmentService;

    /**
     * Client interface for the jBPM enrollment service. It is managed with a getter and setter, may have any value, but
     * is expected to be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to
     * change after dependency injection
     */
    private BusinessProcessService businessProcessService;

    /**
     * Represents the screening service. It is managed with a getter and setter, may have any value, but is expected to
     * be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection
     */
    private ScreeningService screeningService;

    /**
     * Represents the help service. it is managed with a getter and setter. It may have any value, but is expected to be
     * set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private HelpService helpService;

    /**
     * Represents the event service. it is managed with a getter and setter. It may have any value, but is expected to
     * be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private EventService eventService;

    /**
     * Lookup service.
     */
    private LookupService lookupService;

    /**
     * Represents the provider type service.
     */
    private ProviderTypeService providerTypeService;

    /**
     * Used for PDF export.
     */
    private ExportService exportService;

    /**
     * Empty constructor.
     */
    public EnrollmentController() {
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
        if (screeningService == null) {
            throw new PortalServiceConfigurationException("screeningService is not configured correctly.");
        }
        if (enrollmentService == null) {
            throw new PortalServiceConfigurationException("enrollmentService is not configured correctly.");
        }
        if (helpService == null) {
            throw new PortalServiceConfigurationException("helpService must be configured.");
        }

        if (eventService == null) {
            throw new PortalServiceConfigurationException("eventService must be configured.");
        }

        if (lookupService == null) {
            throw new PortalServiceConfigurationException("lookupService must be configured.");
        }
    }

    /**
     * This method is used to convert the date field.
     * 
     * @param binder
     *            the WebDataBinder instance
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        binder.registerCustomEditor(Date.class, "submissionDateStart", new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(Date.class, "submissionDateEnd", new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(Date.class, "startDate", new CustomDateEditor(dateFormat, true));
    }

    /**
     * This action will load the first page of draft profile enrollments.
     * 
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/"
     */
    @RequestMapping("/agent/enrollment/")
    public ModelAndView view() throws PortalServiceException {
        String signature = "EnrollmentController#view()";
        LogUtil.traceEntry(getLog(), signature, null, null);
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        ArrayList<String> statuses = new ArrayList<String>();
        criteria.setShowFilterPanel(true);
        statuses.add("Draft");
        criteria.setStatuses(statuses);
        return LogUtil.traceExit(getLog(), signature, doSearch(criteria, "draft"));
    }

    /**
     * This action will load the dashboard page.
     * 
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             If there are any errors in the action
     * @endpoint "/agent/enrollment/viewDashboard"
     * @verb GET
     */
    @RequestMapping(value = "/agent/enrollment/viewDashboard", method = RequestMethod.GET)
    public ModelAndView viewDashboard() throws PortalServiceException {
        String signature = "EnrollmentController#viewDashboard()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            // Package a ProviderSearchCriteria with first page of size 10 sorted by last update date column
            ProviderSearchCriteria criteria = new ProviderSearchCriteria();
            criteria.setPageNumber(1);
            criteria.setPageSize(10);
            criteria.setSortColumn("modifiedTime");

            SearchResult<UserRequest> result = enrollmentService.searchTickets(ControllerHelper.getCurrentUser(),
                    criteria);

            // Get latest notifications:
            List<Event> notifications = eventService.getLatest();
            ModelAndView model = new ModelAndView("admin/dashboard");
            model.addObject("profiles", result.getItems());
            model.addObject("notifications", notifications);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will load the help page.
     * 
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             If there are any errors in the action
     * @endpoint "/agent/enrollment/viewHelp"
     * @verb GET
     */
    @RequestMapping(value = "/agent/enrollment/viewHelp", method = RequestMethod.GET)
    public ModelAndView getHelp() throws PortalServiceException {
        String signature = "EnrollmentController#getHelp()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            // Get all help topics with help service
            HelpSearchCriteria criteria = new HelpSearchCriteria();
            criteria.setPageNumber(1);
            criteria.setPageSize(-1);
            SearchResult<HelpItem> result = helpService.search(criteria);
            ModelAndView model = new ModelAndView("admin/help");
            model.addObject("helpItems", result.getItems());

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     * 
     * @param id
     *            the entity ID
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             If there are any errors in the action
     * @endpoint "/agent/enrollment/viewHelpItem"
     * @verb GET
     */
    @RequestMapping(value = "/agent/enrollment/viewHelpItem", method = RequestMethod.GET)
    public ModelAndView getHelpItem(@RequestParam("helpItemId") long id) throws PortalServiceException {
        String signature = "EnrollmentController#getHelpItem(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { id });

        try {
            HelpItem helpItem = helpService.get(id);
            ModelAndView model = new ModelAndView("admin/help_detail");
            model.addObject("helpItem", helpItem);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Rejects the ticket.
     * 
     * @param id
     *            the ticket id
     * @return the model and view for
     * @throws PortalServiceException
     * @endpoint "/agent/enrollment/rejectTicket"
     */
    @RequestMapping("/agent/enrollment/rejectTicket")
    public ModelAndView rejectTicket(@RequestParam("id") long id) throws PortalServiceException {
        String signature = "EnrollmentController#rejectTicket(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { id });
        CMSUser user = ControllerHelper.getCurrentUser();
        enrollmentService.rejectTicket(user, id, "Manual Reject by the agent");
        ModelAndView mv = new ModelAndView("redirect:/provider/search/rejected?statuses=Rejected&showFilterPanel=true");

        return LogUtil.traceExit(getLog(), signature, mv);
    }
    
    /**
     * This action will load the screening results for manual verification.
     * 
     * @param id
     *            - the profile id
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/screeningReview"
     */
    @RequestMapping("/agent/enrollment/screeningReview")
    public ModelAndView screeningReview(@RequestParam("id") long id) throws PortalServiceException {
        String signature = "EnrollmentController#viewScreeningResults(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { id });

        CMSUser user = ControllerHelper.getCurrentUser();
        Enrollment ticket = enrollmentService.getTicketDetails(user, id);
        long processInstanceId = ticket.getProcessInstanceId();
        if (processInstanceId <= 0) {
            throw new PortalServiceException("Requested profile is not available for review.");
        }

        try {
            List<TaskSummary> availableTasks = businessProcessService.getAvailableTasks(user.getUsername(),
                    Arrays.asList(user.getRole().getDescription()));
            ModelAndView mv = null;
            for (TaskSummary taskSummary : availableTasks) {
                if (taskSummary.getName().equals(APPROVAL_TASK_NAME)
                        && taskSummary.getProcessInstanceId() == processInstanceId) {
                    EnrollmentProcess taskModel = businessProcessService.getTaskModel(taskSummary.getId());
                    mv = new ModelAndView("admin/service_agent_review_screening", "model", taskModel);
                    VerificationStatusType verification = XMLUtility.nsGetVerificationStatus(taskModel);
                    if (taskModel.getProcessResults() != null) {
                        ProcessResultsType processResults = taskModel.getProcessResults();
                        if (processResults.getScreeningResults() != null) {
                            ScreeningResultsType screeningResults = processResults.getScreeningResults();
                            if (screeningResults.getAutomaticScreeningStatus() != null) {
                                ValidationResultType status = screeningResults.getAutomaticScreeningStatus();
                                if (status.getStatus() != null) {
                                    StatusMessagesType messages = status.getStatus().getStatusMessages();
                                    if (messages != null) {
                                        List<StatusMessageType> errors = messages.getStatusMessage();
                                        List<FormError> formErrors = new ArrayList<FormError>();
                                        for (StatusMessageType statusMessageType : errors) {
                                            FormError error = new FormError();
                                            formErrors.add(error);
                                            error.setFieldId("placeholder");
                                            error.setMessage(statusMessageType.getMessage());
                                        }
                                        mv.addObject("errors", formErrors);
                                    }
                                }
                            }
                        }
                    }
                    mv.addObject("verification", verification);
                    mv.addObject("id", id);
                    break;
                }
            }
            if (mv == null) {
                throw new PortalServiceException("The screening results are not yet available for review.");
            }
            return LogUtil.traceExit(getLog(), signature, mv);
        } catch (Exception e) {
            throw new PortalServiceException("Error while invoking process server.", e);
        }
    }

    /**
     * This action will load the screening results log.
     * 
     * @param id
     *            - the profile id
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/autoScreeningResult"
     */
    @RequestMapping("/agent/enrollment/autoScreeningResult")
    public ModelAndView viewScreeningLog(@RequestParam("id") long id, @RequestParam("type") String type,
            @RequestParam(value = "licenseId", required = false) String licenseId) throws PortalServiceException {
        String signature = "EnrollmentController#viewScreeningResults(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { id });

        CMSUser user = ControllerHelper.getCurrentUser();
        Enrollment ticket = enrollmentService.getTicketDetails(user, id);
        long processInstanceId = ticket.getProcessInstanceId();
        if (processInstanceId <= 0) {
            throw new PortalServiceException("Requested profile is not available for review.");
        }

        try {
            List<TaskSummary> availableTasks = businessProcessService.getAvailableTasks(user.getUsername(),
                    Arrays.asList(user.getRole().getDescription()));
            ModelAndView mv = new ModelAndView("admin/screening_log");
            for (TaskSummary taskSummary : availableTasks) {
                if (taskSummary.getName().equals(APPROVAL_TASK_NAME)
                        && taskSummary.getProcessInstanceId() == processInstanceId) {
                    EnrollmentProcess taskModel = businessProcessService.getTaskModel(taskSummary.getId());
                    ScreeningResultsType screeningResults = XMLUtility.nsGetScreeningResults(taskModel);
                    List<ScreeningResultType> results = screeningResults.getScreeningResult();
                    SearchResultType output = null;
                    for (ScreeningResultType screeningResultType : results) {
                        if (screeningResultType.getScreeningType().equals(type)) {
                            if ("EXCLUDED PROVIDERS".equals(type)) {
                                output = screeningResultType.getExclusionVerificationResult();
                            } else if ("LICENSE VERIFICATION".equals(type)) {
                                if (screeningResultType.getLicenseVerificationResult().getLicenseObjectId()
                                        .equals(licenseId)) {
                                    output = screeningResultType.getLicenseVerificationResult().getSearchResults();
                                }
                            } else if ("SAM EXCLUDED PROVIDERS".equals(type)) {
                                output = screeningResultType.getSAMExclusionVerificationResult();
                            } else {
                                output = screeningResultType.getSearchResult();
                            }
                        }
                    }
                    mv.addObject("output", output);
                    break;
                }
            }
            return LogUtil.traceExit(getLog(), signature, mv);
        } catch (Exception e) {
            throw new PortalServiceException("Error while invoking process server.", e);
        }
    }

    /**
     * This action will search for profile enrollments.
     * 
     * @param criteria
     *            - the search criteria
     * @param response
     *            the response to write the PDF to
     * @throws IOException
     *             for read/write errors
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/exportBatch"
     * @endpoint "/provider/search/exportBatch"
     */
    @SuppressWarnings("unchecked")
    @RequestMapping({ "/agent/enrollment/exportBatch", "/provider/search/exportBatch" })
    public void exportBatch(@ModelAttribute("criteria") ProviderSearchCriteria criteria, HttpServletResponse response)
            throws PortalServiceException, IOException {
        String signature = "EnrollmentController#search(ProviderSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new IllegalArgumentException("A valid criteria must be provided.");
        }

        ModelAndView results = doSearch(criteria, "print");
        SearchResult<UserRequest> items = (SearchResult<UserRequest>) results.getModel().get("results");

        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(items.getItems(), null, response.getOutputStream());
    }

    /**
     * This action will search for profile enrollments.
     * 
     * @param criteria
     *            - the search criteria
     * @param view
     *            the view name
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/search/{view}"
     * @endpoint "/provider/search/{view}"
     */
    @RequestMapping({ "/agent/enrollment/search/{view}", "/provider/search/{view}" })
    public ModelAndView search(@ModelAttribute("criteria") ProviderSearchCriteria criteria, @PathVariable String view,
            HttpServletResponse response) throws PortalServiceException {

        nocache(response);
        String signature = "EnrollmentController#search(ProviderSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new IllegalArgumentException("A valid criteria must be provided.");
        }

        return LogUtil.traceExit(getLog(), signature, doSearch(criteria, view));
    }

    /**
     * This method is used to supply the lookup values.
     * 
     * @param modelAndView
     *            the modelAndView object
     * @throws PortalServiceException
     *             if any error occurred.
     */
    private void supplyLookupValues(ModelAndView modelAndView) throws PortalServiceException {
        modelAndView.addObject("requestTypesLookup", lookupService.findAllLookups(RequestType.class));
        modelAndView.addObject("enrollmentStatusesLookup", lookupService.findAllLookups(EnrollmentStatus.class));
        modelAndView.addObject("riskLevelsLookup", lookupService.findAllLookups(RiskLevel.class));
        ProviderTypeSearchCriteria providerTypeSearchCriteria = new ProviderTypeSearchCriteria();
        providerTypeSearchCriteria.setAscending(true);
        providerTypeSearchCriteria.setSortColumn("description");
        providerTypeSearchCriteria.setPageNumber(1);
        providerTypeSearchCriteria.setPageSize(-1);
        List<ProviderType> items = providerTypeService.search(providerTypeSearchCriteria).getItems();
        modelAndView.addObject("providerTypesLookup", items);
    }

    /**
     * This action will search for profile enrollment with the given npi.
     * 
     * @param npi
     *            - the npi
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws IllegalArgumentException
     *             - if npi is null/empty
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/status"
     */
    @RequestMapping(value = "/agent/enrollment/status")
    public ModelAndView getByNumber(@RequestParam("npi") String npi) throws PortalServiceException {
        String signature = "EnrollmentController#getByNumber(String npi)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "npi" }, new Object[] { npi });

        if (npi == null || npi.trim().length() == 0) {
            throw new IllegalArgumentException("A valid NPI must be provided.");
        }

        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setNpi(npi);
        criteria.setPageNumber(1);
        criteria.setPageSize(-1);
        criteria.setSortColumn("6");
        CMSUser user = ControllerHelper.getCurrentUser();
        SearchResult<UserRequest> results = enrollmentService.searchTickets(user, criteria);
        if (results.getTotal() == 0) {
            ModelAndView mv = new ModelAndView("forward:/agent/enrollment/viewDashboard", "invalidEnrollmentNumber",
                    "yes");
            mv.addObject("invalidEnrollmentNumberValue", npi);
            return mv;
        }

        UserRequest result = results.getItems().get(0);
        ModelAndView mv = new ModelAndView("admin/service_agent_enrollment_status", "profile", result);
        return LogUtil.traceExit(getLog(), signature, mv);
    }

    /**
     * This action will get the profile enrollment with the given profile ID.
     * 
     * @param ticketId
     *            - the ticket ID
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/details"
     */
    @RequestMapping("/agent/enrollment/details")
    public ModelAndView getDetails(@RequestParam("id") long ticketId,
            @RequestParam(value = "print", required = false) String isPrint) throws PortalServiceException {
        String signature = "EnrollmentController#getDetails(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { ticketId });

        if ("yes".equals(isPrint)) {
            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/reviewPrint?id=" + ticketId);
            return LogUtil.traceExit(getLog(), signature, mv);
        } else {
            ModelAndView mv = new ModelAndView("redirect:/provider/enrollment/view?id=" + ticketId);
            return LogUtil.traceExit(getLog(), signature, mv);
        }
    }

    /**
     * This action will save the note in current enrollment of the profile with the given ID.
     * 
     * @param ticketId
     *            - the ticket ID
     * @param note
     *            - the note
     * @throws IllegalArgumentException
     *             - if note is null/empty
     * @return the operation status and message
     * @endpoint "/agent/enrollment/note"
     */
    @RequestMapping("/agent/enrollment/note")
    @ResponseBody
    public StatusDTO saveNote(@RequestParam("id") long ticketId, @RequestParam("note") String note) {
        String signature = "EnrollmentController#saveNote(long id, String note)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "note" }, new Object[] { ticketId, note });

        if (note == null || note.trim().length() == 0) {
            throw new IllegalArgumentException("A note must be provided.");
        }

        StatusDTO statusDTO = new StatusDTO();
        CMSUser user = ControllerHelper.getCurrentUser();
        try {
            enrollmentService.addNoteToTicket(user, ticketId, note);
            statusDTO.setSuccess(true);
        } catch (PortalServiceException ex) {
            LogUtil.traceError(getLog(), signature, ex);
            statusDTO.setMessage(USER_ERROR_MSG);
        }

        return LogUtil.traceExit(getLog(), signature, statusDTO);
    }

    /**
     * This action will approve the current enrollment.
     * 
     * @param id
     *            - the profile ID
     * @param dto
     *            - any changes to be applied (manual verification) this is optional, and only provided if any changes
     *            are needed
     * @return the operation status and message
     * @endpoint "/agent/enrollment/approve"
     */
    @RequestMapping("/agent/enrollment/approve")
    public String approve(@RequestParam("id") long id, ApprovalDTO dto) {
        String signature = "EnrollmentController#approve(long id, ApprovalDTO dto)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "dto" }, new Object[] { id, dto });
        StatusDTO statusDTO = new StatusDTO();

        try {
            completeReview(id, dto, false, "");
            statusDTO.setSuccess(true);
            ControllerHelper.flashInfo("Approval request has been sent, you will be notified once it is processed.");
        } catch (PortalServiceException ex) {
            LogUtil.traceError(getLog(), signature, ex);
            ControllerHelper.flashError(USER_ERROR_MSG);
        }
        return "redirect:/ops/viewDashboard";
    }

    /**
     * This action will reject the current enrollment of the profile with the given ID.
     * 
     * @param id
     *            - the profile ID
     * @param reason
     *            - the reason
     * @return the status result
     * @throws IllegalArgumentException
     *             - if reason is null/empty
     * @endpoint "/agent/enrollment/reject"
     */
    @RequestMapping("/agent/enrollment/reject")
    @ResponseBody
    public StatusDTO reject(@RequestParam("id") long id, @RequestParam("reason") String reason) {
        String signature = "EnrollmentController#reject(long id, String reason)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "reason" }, new Object[] { id, reason });

        if (reason == null || reason.trim().length() == 0) {
            throw new IllegalArgumentException("A reason must be provided.");
        }

        StatusDTO statusDTO = new StatusDTO();
        try {
            completeReview(id, null, true, reason);
            statusDTO.setMessage("Request has been sent, you will be notified once it is processed.");
        } catch (PortalServiceException ex) {
            LogUtil.traceError(getLog(), signature, ex);
            statusDTO.setMessage(USER_ERROR_MSG);
        }

        return LogUtil.traceExit(getLog(), signature, statusDTO);
    }

    /**
     * This action will initiated an immediate screening of the enrollment.
     * 
     * @param id
     *            - the profile ID
     * @return the status
     * @endpoint "/agent/enrollment/screen"
     */
    @RequestMapping("/agent/enrollment/screen")
    @ResponseBody
    public StatusDTO initiateOnDemandScreening(@RequestParam("id") long id) {
        String signature = "EnrollmentController#initiateOnDemandScreening(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { id });

        StatusDTO statusDTO = new StatusDTO();
        try {
            screeningService.performScreening(id);
            statusDTO.setSuccess(true);
        } catch (PortalServiceException ex) {
            LogUtil.traceError(getLog(), signature, ex);
            statusDTO.setMessage(USER_ERROR_MSG);
        }
        return LogUtil.traceExit(getLog(), signature, statusDTO);
    }

    /**
     * This action will initiated a screening of the enrollment at the given date.
     * 
     * @param id
     *            - the profile ID
     * @param date
     *            - the date of the requested screening
     * @return the status
     * @throws IllegalArgumentException
     *             - if date is null or is a date in the past
     * @endpoint "/agent/enrollment/schedule"
     */
    @RequestMapping("/agent/enrollment/schedule")
    @ResponseBody
    public StatusDTO initiateScheduledScreening(@RequestParam("id") long id, @RequestParam("date") Date date) {
        String signature = "EnrollmentController#initiateScheduledScreening(long id, Date date)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "date" }, new Object[] { id, date });

        if (date == null || date.before(new Date())) {
            throw new IllegalArgumentException("A valid future date must be specified.");
        }

        StatusDTO statusDTO = new StatusDTO();
        try {
            screeningService.scheduleScreening(id, date);
            statusDTO.setSuccess(true);
        } catch (PortalServiceException ex) {
            LogUtil.traceError(getLog(), signature, ex);
            statusDTO.setMessage(USER_ERROR_MSG);
        }
        return LogUtil.traceExit(getLog(), signature, statusDTO);
    }

    /**
     * Set the helpService.
     * 
     * @param helpService
     *            the helpService to set
     */
    public void setHelpService(HelpService helpService) {
        this.helpService = helpService;
    }

    /**
     * Set the eventService.
     * 
     * @param eventService
     *            the eventService to set
     */
    public void setEventService(EventService eventService) {
        this.eventService = eventService;
    }

    /**
     * Sets the value of the field <code>screeningService</code>.
     * 
     * @param screeningService
     *            the screeningService to set
     */
    public void setScreeningService(ScreeningService screeningService) {
        this.screeningService = screeningService;
    }

    /**
     * Completes the review step of the screening process.
     * 
     * @param ticketId
     *            the ticket id
     * @param dto
     *            the manual verification changes (if any)
     * @param reject
     *            true if the application is to be denied
     * @param reason
     *            the reason for denial
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private void completeReview(long ticketId, ApprovalDTO dto, boolean reject, String reason)
            throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Enrollment ticketDetails = enrollmentService.getTicketDetails(user, ticketId);
        
        long processInstanceId = ticketDetails.getProcessInstanceId();
        if (processInstanceId <= 0) {
            throw new PortalServiceException("Requested profile is not available for approval.");
        }
        try {
            List<TaskSummary> availableTasks = businessProcessService.getAvailableTasks(user.getUsername(),
                    Arrays.asList(user.getRole().getDescription()));
            boolean found = false;
            for (TaskSummary taskSummary : availableTasks) {
                if (taskSummary.getName().equals(APPROVAL_TASK_NAME)
                        && taskSummary.getProcessInstanceId() == processInstanceId) {
                    found = true;
                    long taskId = taskSummary.getId();

                    if (!reject) {
                        // apply approver changes
                        ProviderInformationType provider = applyChanges(dto, taskId);
                        businessProcessService.completeReview(taskId, user.getUsername(),
                                Arrays.asList(user.getRole().getDescription()), provider, false, reason);
                    } else {
                        businessProcessService.completeReview(taskId, user.getUsername(),
                                Arrays.asList(user.getRole().getDescription()), null, true, reason);
                    }
                }
            }
            if (!found) {
                throw new PortalServiceException("You do not have access to the requested operation.");
            }
        } catch (Exception ex) {
            throw new PortalServiceException("Error while invoking process server.", ex);
        }
    }

    /**
     * Applies manual verification to the current process model.
     * 
     * @param dto
     *            the manual verification dto
     * @param taskId
     *            the screening task id
     * @return the modified provider profile
     * @throws Exception
     *             for any errors encountered
     */
    private ProviderInformationType applyChanges(ApprovalDTO dto, long taskId) throws Exception {
        if (dto == null) { // no changes
            return null;
        }

        EnrollmentType enrollment = businessProcessService.getTaskModel(taskId).getEnrollment();
        ProviderInformationType provider = enrollment.getProviderInformation();
        if (dto.getVerifiedLicenses() != null) {
            List<String> verifiedLicenses = dto.getVerifiedLicenses();
            LicenseInformationType licenseInformation = provider.getLicenseInformation();
            for (String licenseId : verifiedLicenses) {
                for (LicenseType license : licenseInformation.getLicense()) {
                    if (licenseId.equals(license.getAttachmentObjectId())) {
                        license.setVerified("Y");
                    }
                }
            }
        }

        VerificationStatusType status = provider.getVerificationStatus();
        if ("Y".equals(dto.getNonExclusionVerified())) { // modify only if set to Y
            status.setNonExclusion("Y");
        }
        if ("Y".equals(dto.getNonExclusionVerified())) { // modify only if set to Y
            status.setSAMNonExclusion("Y");
        }

        if ("Y".equals(dto.getNpiVerified())) {
            status.setNPI("Y");
        }

        if ("Y".equals(dto.getNpiLookupVerified())) {
            status.setNPILookup("Y");
        }

        if ("Y".equals(dto.getSsnVerified())) {
            status.setSocialSecurityNumber("Y");
        }

        if ("Y".equals(dto.getBgsVerified())) {
            status.setNetStudy("Y");
        }

        return provider;
    }

    /**
     * Executes the search.
     * 
     * @param criteria
     *            the search criteria
     * @param view
     *            the view to render the results
     * @return the search results
     * @throws PortalServiceException
     *             for any errors encountered
     */
    private ModelAndView doSearch(ProviderSearchCriteria criteria, String view) throws PortalServiceException {
        if (criteria.getPageNumber() == 0 && criteria.getPageSize() == 0) {
            criteria.setPageNumber(1);
            criteria.setPageSize(10);
            criteria.setAscending(false);
            criteria.setSortColumn("6");
        }
        SearchResult<UserRequest> results = enrollmentService
                .searchTickets(ControllerHelper.getCurrentUser(), criteria);

        ModelAndView mv = new ModelAndView("admin/service_agent_enrollments_" + view, "results", results);
        if (criteria.getStatuses() == null || criteria.getStatuses().isEmpty()) {
            mv.addObject("Status", "");
            // populate notes

            List<UserRequest> items = results.getItems();
            if (items != null) {
                for (UserRequest item : items) {
                    item.setNotes(enrollmentService.findNotes(item.getTicketId()));
                }
            }
        } else {
            mv.addObject("Status", criteria.getStatuses().get(0));
        }

        // load all actions that can be performed by user, JSP should check that processInstanceId are equal
        CMSUser user = ControllerHelper.getCurrentUser();
        try {
            System.out.println("searching available tasks...");
            List<TaskSummary> availableTasks = businessProcessService.getAvailableTasks(user.getUsername(),
                    Arrays.asList(user.getRole().getDescription()));
            mv.addObject("tasks", availableTasks);
            for (TaskSummary taskSummary : availableTasks) {
                System.out.println("available task: " + taskSummary.getProcessInstanceId());
            }
        } catch (Exception e) {
            throw new PortalServiceException("Error while invoking process server.", e);
        }
        mv.addObject("searchCriteria", criteria);
        supplyLookupValues(mv);
        return mv;
    }

    /**
     * This action will load the COS associated with a provider.
     * 
     * @param profileId
     *            the profile id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/cos"
     */
    @RequestMapping("/agent/enrollment/cos")
    public ModelAndView viewCategoryOfService(@RequestParam("id") long profileId) throws PortalServiceException {
        String signature = "EnrollmentController#viewCategoryOfService(long profileId)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { profileId });
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderProfile profile = enrollmentService.getProviderDetails(user, profileId);
        if (profile != null) {
            ModelAndView mv = new ModelAndView("admin/service_agent_enrollment_cos", "profile", profile);
            List<ProviderCategoryOfService> existingServices = enrollmentService.getProviderCategoryOfServices(user,
                    profileId);
            mv.addObject("existingServices", existingServices);
            // get the COS codes using lookup
            mv.addObject("codes", lookupService.findAllLookups(CategoryOfService.class));
            return mv;
        }
        throw new PortalServiceException("Cannot find the profile for the given id.");
    }

    /**
     * This action will load the COS associated with a ticket.
     * 
     * @param ticketId
     *            the ticket id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/pendingcos"
     */
    @RequestMapping("/agent/enrollment/pendingcos")
    public ModelAndView viewPendingCategoryOfService(@RequestParam("id") long ticketId) throws PortalServiceException {
        String signature = "EnrollmentController#viewCategoryOfService(long ticketId)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id" }, new Object[] { ticketId });
        CMSUser user = ControllerHelper.getCurrentUser();
        Enrollment enrollment = enrollmentService.getTicketDetails(user, ticketId);
        if (enrollment != null) {
            ModelAndView mv = new ModelAndView("admin/service_agent_enrollment_pending_cos", "enrollment", enrollment);
            List<ProviderCategoryOfService> existingServices = enrollmentService.getPendingCategoryOfServices(user,
                    ticketId);
            mv.addObject("existingServices", existingServices);
            // get the COS codes using lookup
            mv.addObject("codes", lookupService.findAllLookups(CategoryOfService.class));
            return mv;
        }
        throw new PortalServiceException("Cannot find the ticket for the given id.");
    }

    /**
     * Saves the category of services.
     * 
     * @param profileId
     *            the profile id
     * @param startDate
     *            start date
     * @param endDate
     *            end date
     * @param cos
     *            the list of codes
     * @param prevCosId
     *            previous cosId if copied
     * @param prevCosEndDate
     *            previous cos end date
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/addCOS"
     * @verb POST
     */
    @RequestMapping(value = "/agent/enrollment/addCOS", method = RequestMethod.POST)
    public ModelAndView addCategoryOfService(@RequestParam("id") long profileId,
            @RequestParam("startDate") Date startDate, @RequestParam("endDate") String endDate,
            @RequestParam("cos") String[] cos, @RequestParam("prevCosId") long prevCosId,
            @RequestParam("prevCosEndDate") String prevCosEndDate) throws PortalServiceException {
        String signature = "EnrollmentController#addCategoryOfService(long profileId, String startDate, String endDate, String cos)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "startDate", "endDate", "cos" }, new Object[] {
                profileId, startDate, endDate, cos });
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderCategoryOfService categoryOfService = new ProviderCategoryOfService();
        List<CategoryOfService> categories = new ArrayList<CategoryOfService>();
        for (String c : cos) {
            categories.add(lookupService.findLookupByCode(CategoryOfService.class, c));
        }
        if (cos.length > 0 && startDate != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            categoryOfService.setCategories(categories);
            categoryOfService.setStartDate(startDate);
            if (endDate != null && endDate.trim().length() > 0) {
                try {
                    categoryOfService.setEndDate(dateFormat.parse(endDate));
                } catch (ParseException e) {
                    // ignore
                }
            }
            categoryOfService.setProfileId(profileId);
            Date prevCatEndDate = null;
            if (prevCosId != 0) {
                try {
                    prevCatEndDate = dateFormat.parse(prevCosEndDate);
                } catch (ParseException e) {
                    // ignore
                }
            }
            enrollmentService.addCOSToProfile(user, categoryOfService, prevCosId, prevCatEndDate);
        }
        return new ModelAndView("redirect:/agent/enrollment/cos?id=" + profileId);
    }

    /**
     * Saves the category of services.
     * 
     * @param ticketId
     *            the ticket id
     * @param startDate
     *            start date
     * @param endDate
     *            end date
     * @param cos
     *            the list of codes
     * @param prevCosId
     *            previous cosId if copied
     * @param prevCosEndDate
     *            previous cos end date
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/addPendingCOS"
     * @verb POST
     */
    @RequestMapping(value = "/agent/enrollment/addPendingCOS", method = RequestMethod.POST)
    public ModelAndView addPendingCategoryOfService(@RequestParam("id") long ticketId,
            @RequestParam("startDate") Date startDate, @RequestParam("endDate") String endDate,
            @RequestParam("cos") String[] cos, @RequestParam("prevCosId") long prevCosId,
            @RequestParam("prevCosEndDate") String prevCosEndDate) throws PortalServiceException {
        String signature = "EnrollmentController#addCategoryOfService(long profileId, String startDate, String endDate, String cos)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "id", "startDate", "endDate", "cos" }, new Object[] {
                ticketId, startDate, endDate, cos });
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderCategoryOfService categoryOfService = new ProviderCategoryOfService();
        List<CategoryOfService> categories = new ArrayList<CategoryOfService>();
        for (String c : cos) {
            categories.add(lookupService.findLookupByCode(CategoryOfService.class, c));
        }
        if (cos.length > 0 && startDate != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            categoryOfService.setCategories(categories);
            categoryOfService.setStartDate(startDate);
            if (endDate != null && endDate.trim().length() > 0) {
                try {
                    categoryOfService.setEndDate(dateFormat.parse(endDate));
                } catch (ParseException e) {
                    // ignore
                }
            }
            categoryOfService.setTicketId(ticketId);
            Date prevCatEndDate = null;
            if (prevCosId != 0) {
                try {
                    prevCatEndDate = dateFormat.parse(prevCosEndDate);
                } catch (ParseException e) {
                    // ignore
                }
            }
            enrollmentService.addCOSToTicket(user, categoryOfService, prevCosId, prevCatEndDate);
        }
        return new ModelAndView("redirect:/agent/enrollment/pendingcos?id=" + ticketId);
    }

    /**
     * Deletes the Category of Service.
     * 
     * @param profileId
     *            the profile id
     * @param id
     *            cos id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/deleteCOS"
     */
    @RequestMapping("/agent/enrollment/deleteCOS")
    public ModelAndView deleteCategoryOfService(@RequestParam("profileId") long profileId, @RequestParam("id") long id)
            throws PortalServiceException {
        String signature = "EnrollmentController#deleteCategoryOfService(long profileId, long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "profileId", "id" }, new Object[] { profileId, id });
        CMSUser user = ControllerHelper.getCurrentUser();
        enrollmentService.deleteCOSByProfile(user, profileId, id);
        return new ModelAndView("redirect:/agent/enrollment/cos?id=" + profileId);
    }

    /**
     * Deletes the pending Category of Service.
     * 
     * @param ticketId
     *            the ticket id
     * @param id
     *            cos id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException
     *             - If there are any errors in the action
     * @endpoint "/agent/enrollment/deletePendingCOS"
     */
    @RequestMapping("/agent/enrollment/deletePendingCOS")
    public ModelAndView deletePendingCategoryOfService(@RequestParam("ticketId") long ticketId,
            @RequestParam("id") long id) throws PortalServiceException {
        String signature = "EnrollmentController#deleteCategoryOfService(long ticketId, long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "ticketId", "id" }, new Object[] { ticketId, id });
        CMSUser user = ControllerHelper.getCurrentUser();
        enrollmentService.deleteCOSByTicket(user, ticketId, id);
        return new ModelAndView("redirect:/agent/enrollment/pendingcos?id=" + ticketId);
    }

    /**
     * The setter for the lookupService instance variable.
     * 
     * @param lookupService
     *            the lookupService to set
     */
    public void setLookupService(LookupService lookupService) {
        this.lookupService = lookupService;
    }

    /**
     * The setter for the providerTypeService instance variable.
     * 
     * @param providerTypeService
     *            the providerTypeService to set
     */
    public void setProviderTypeService(ProviderTypeService providerTypeService) {
        this.providerTypeService = providerTypeService;
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
     * Sets the value of the field <code>businessProcessService</code>.
     * 
     * @param businessProcessService
     *            the businessProcessService to set
     */
    public void setBusinessProcessService(BusinessProcessService businessProcessService) {
        this.businessProcessService = businessProcessService;
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

}