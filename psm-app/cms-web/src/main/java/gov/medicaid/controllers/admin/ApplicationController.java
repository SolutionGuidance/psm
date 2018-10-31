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

package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.BaseController;
import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.controllers.dto.ApprovalDTO;
import gov.medicaid.controllers.dto.StatusDTO;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProcessResultsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.ApplicationStatus;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.AutomaticScreening.Result;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CategoryOfService;
import gov.medicaid.entities.DmfAutomaticScreening;
import gov.medicaid.entities.Event;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.entities.ProviderCategoryOfService;
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
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.ProviderTypeService;

import org.jbpm.task.query.TaskSummary;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * <p>
 * This controller class manages applications, except for their creation and update.
 * </p>
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public class ApplicationController extends BaseController {

    /**
     * The generic error message to be presented to the user.
     */
    private static final String USER_ERROR_MSG = "There was a problem processing your request, please contact support.";

    /**
     * The business process task name for approval.
     */
    private static final String APPROVAL_TASK_NAME = "Screening Review";

    private final ProviderApplicationService applicationService;
    private final BusinessProcessService businessProcessService;
    private final EventService eventService;
    private final LookupService lookupService;
    private final ProviderTypeService providerTypeService;
    private final ExportService exportService;

    public ApplicationController(
        ProviderApplicationService applicationService,
        BusinessProcessService businessProcessService,
        EventService eventService,
        LookupService lookupService,
        ProviderTypeService providerTypeService,
        ExportService exportService
    ) {
        this.applicationService = applicationService;
        this.businessProcessService = businessProcessService;
        this.eventService = eventService;
        this.lookupService = lookupService;
        this.providerTypeService = providerTypeService;
        this.exportService = exportService;
    }

    /**
     * This method is used to convert the date field.
     *
     * @param binder the WebDataBinder instance
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        binder.registerCustomEditor(Date.class, "submissionDateStart", new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(Date.class, "submissionDateEnd", new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(Date.class, "startDate", new CustomDateEditor(dateFormat, true));
    }

    /**
     * This action will load the first page of draft profile applications.
     *
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/"
     */
    @RequestMapping("/agent/application/")
    public ModelAndView view() throws PortalServiceException {
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        ArrayList<String> statuses = new ArrayList<>();
        criteria.setShowFilterPanel(true);
        statuses.add("Draft");
        criteria.setStatuses(statuses);
        return doSearch("admin/service_agent_applications_draft", criteria);
    }

    /**
     * This action will load the dashboard page.
     *
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/viewDashboard"
     * @verb GET
     */
    @RequestMapping(
            value = "/agent/application/viewDashboard",
            method = RequestMethod.GET
    )
    public ModelAndView viewDashboard() throws PortalServiceException {
        // Package a ProviderSearchCriteria with first page of size 10 sorted by last update date column
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(10);
        criteria.setSortColumn("modifiedTime");

        SearchResult<UserRequest> result = applicationService.searchApplications(ControllerHelper.getCurrentUser(),
                criteria);

        // Get latest notifications:
        List<Event> notifications = eventService.getLatest();
        ModelAndView model = new ModelAndView("admin/dashboard");
        model.addObject("profiles", result.getItems());
        model.addObject("notifications", notifications);
        return model;
    }

    /**
     * Rejects the application.
     *
     * @param id the application id
     * @return the model and view for
     * @throws PortalServiceException
     * @endpoint "/agent/application/rejectApplication"
     */
    @RequestMapping("/agent/application/rejectApplication")
    public ModelAndView rejectApplication(
            @RequestParam("id") long id
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        applicationService.rejectApplication(user, id, "Manual Rejection");
        ModelAndView mv = new ModelAndView("redirect:/provider/applications/rejected?statuses=Rejected&showFilterPanel=true");
        return mv;
    }

    /**
     * This action will load the screening results for manual verification.
     *
     * @param id the profile id
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/screeningReview"
     */
    @RequestMapping("/agent/application/screeningReview")
    public ModelAndView screeningReview(
            @RequestParam("id") long id
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Application application = applicationService.getApplicationWithScreenings(
                user,
                id
        ).orElseThrow(() -> new PortalServiceException(
                "Could not find application with that ID."
        ));
        long processInstanceId = application.getProcessInstanceId();
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
                    ApplicationProcess taskModel = businessProcessService.getTaskModel(taskSummary.getId());
                    mv = new ModelAndView("admin/service_agent_review_screening", "model", taskModel);
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
                                        List<FormError> formErrors = new ArrayList<>();
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
                    addLeieResults(mv, application);
                    addDmfResults(mv, application);
                    mv.addObject("id", id);
                    break;
                }
            }
            if (mv == null) {
                throw new PortalServiceException("The screening results are not yet available for review.");
            }
            return mv;
        } catch (Exception e) {
            throw new PortalServiceException("Error while invoking process server.", e);
        }
    }

    private void addLeieResults(ModelAndView mv, Application application) {
        Optional<LeieAutomaticScreening> screening = getMostRecentAutomaticScreeningResult(
                LeieAutomaticScreening.class,
                application
        );
        Optional<Result> result = screening.map(AutomaticScreening::getResult);
        mv.addObject(
                "leieScreeningPassed",
                Result.PASS.equals(result.orElse(null))
        );
        mv.addObject(
                "leieScreeningResult",
                result.map(Enum::toString).orElse("Not performed")
        );
        screening.ifPresent(leieAutomaticScreening -> mv.addObject(
                "leieScreeningId",
                leieAutomaticScreening.getAutomaticScreeningId()
        ));
    }

    private void addDmfResults(ModelAndView mv, Application application) {
        Optional<DmfAutomaticScreening> screening = getMostRecentAutomaticScreeningResult(
                DmfAutomaticScreening.class,
                application
        );
        Optional<Result> result = screening.map(AutomaticScreening::getResult);
        mv.addObject(
                "dmfScreeningPassed",
                Result.PASS.equals(result.orElse(null))
        );
        mv.addObject(
                "dmfScreeningResult",
                result.map(Enum::toString).orElse("Not performed")
        );
        screening.ifPresent(dmfAutomaticScreening -> mv.addObject(
                "dmfScreeningId",
                dmfAutomaticScreening.getAutomaticScreeningId()
        ));
    }

    private <T extends AutomaticScreening>
    Optional<T> getMostRecentAutomaticScreeningResult(
            Class<T> automaticScreeningType,
            Application application
    ) {
        return application.getAutomaticScreenings()
                .stream()
                .filter(automaticScreeningType::isInstance)
                .max(Comparator.comparing(AutomaticScreening::getCreatedAt))
                .map(automaticScreeningType::cast);
    }

    /**
     * This action will search for profile applications.
     *
     * @param criteria the search criteria
     * @param response the response to write the PDF to
     * @throws IOException            for read/write errors
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/exportBatch"
     * @endpoint "/provider/search/exportBatch"
     */
    @SuppressWarnings("unchecked")
    @RequestMapping({
            "/agent/application/exportBatch",
            "/provider/search/exportBatch"
    })
    public void exportBatch(
            @ModelAttribute("criteria") ProviderSearchCriteria criteria,
            HttpServletResponse response
    ) throws PortalServiceException, IOException {
        if (criteria == null) {
            throw new IllegalArgumentException("A valid criteria must be provided.");
        }

        ModelAndView results = doSearch("admin/service_agent_print_applications", criteria);
        SearchResult<UserRequest> items = (SearchResult<UserRequest>) results.getModel().get("results");

        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(items.getItems(), null, response.getOutputStream());
    }

    /**
     * This action will list applications.
     *
     * @param criteria the search criteria
     * @param view     the view name
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/list/{view}"
     * @endpoint "/provider/applications/{view}"
     */
    @RequestMapping({
            "/agent/application/list/{view}",
            "/provider/applications/{view}"
    })
    public ModelAndView list(
            @ModelAttribute("criteria") ProviderSearchCriteria criteria,
            @PathVariable("view") String view,
            HttpServletResponse response
    ) throws PortalServiceException {

        nocache(response);
        if (criteria == null) {
            throw new IllegalArgumentException("A valid criteria must be provided.");
        }

        ModelAndView mv = doSearch("admin/service_agent_application_list", criteria);
        mv.addObject("tabName", view);
        return mv;
    }

    @RequestMapping({
            "/agent/application/search/{view}",
            "/provider/search/{view}"
    })
    public ModelAndView search(
            @ModelAttribute("criteria") ProviderSearchCriteria criteria,
            @PathVariable("view") String view,
            HttpServletResponse response
    ) throws PortalServiceException {

        nocache(response);
        if (criteria == null) {
            throw new IllegalArgumentException("A valid criteria must be provided.");
        }

        return doSearch("admin/service_agent_search_applications_" + view, criteria);
    }

    /**
     * This method is used to supply the lookup values.
     *
     * @param modelAndView the modelAndView object
     * @throws PortalServiceException if any error occurred.
     */
    private void supplyLookupValues(
            ModelAndView modelAndView
    ) throws PortalServiceException {
        modelAndView.addObject("requestTypesLookup", lookupService.findAllLookups(RequestType.class));
        modelAndView.addObject("applicationStatusesLookup", lookupService.findAllLookups(ApplicationStatus.class));
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
     * This action will search for profile application with the given npi.
     *
     * @param npi the npi
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws IllegalArgumentException if npi is null/empty
     * @endpoint "/agent/application/status"
     */
    @RequestMapping(value = "/agent/application/status")
    public ModelAndView getByNumber(
            @RequestParam("npi") String npi
    ) {

        if (npi == null || npi.trim().length() == 0) {
            throw new IllegalArgumentException("A valid NPI must be provided.");
        }

        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setNpi(npi);
        criteria.setPageNumber(1);
        criteria.setPageSize(-1);
        criteria.setSortColumn("6");
        CMSUser user = ControllerHelper.getCurrentUser();
        SearchResult<UserRequest> results = applicationService.searchApplications(user, criteria);
        if (results.getTotal() == 0) {
            ModelAndView mv = new ModelAndView("forward:/agent/application/viewDashboard", "invalidApplicationNumber",
                    "yes");
            mv.addObject("invalidApplicationNumberValue", npi);
            return mv;
        }

        UserRequest result = results.getItems().get(0);
        ModelAndView mv = new ModelAndView("admin/service_agent_application_status", "profile", result);
        return mv;
    }

    /**
     * This action will get the profile application with the given profile ID.
     *
     * @param applicationId the application ID
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/details"
     */
    @RequestMapping("/agent/application/details")
    public ModelAndView getDetails(
            @RequestParam("id") long applicationId
    ) throws PortalServiceException {
        return new ModelAndView("redirect:/provider/application/view?id=" + applicationId);
    }

    /**
     * This action will save the note in current application of the profile with
     * the given ID.
     *
     * @param applicationId the application ID
     * @param note     the note
     * @return the operation status and message
     * @throws IllegalArgumentException if note is null/empty
     * @endpoint "/agent/application/note"
     */
    @RequestMapping("/agent/application/note")
    @ResponseBody
    public StatusDTO saveNote(
            @RequestParam("id") long applicationId,
            @RequestParam("note") String note
    ) {
        if (note == null || note.trim().length() == 0) {
            throw new IllegalArgumentException("A note must be provided.");
        }

        StatusDTO statusDTO = new StatusDTO();
        CMSUser user = ControllerHelper.getCurrentUser();
        try {
            applicationService.addNoteToApplication(user, applicationId, note);
            statusDTO.setSuccess(true);
        } catch (PortalServiceException ex) {
            statusDTO.setMessage(USER_ERROR_MSG);
        }

        return statusDTO;
    }

    /**
     * This action will approve the current application.
     *
     * @param id  the profile ID
     * @param dto any changes to be applied (manual verification) this is
     *            optional, and only provided if any changes are needed
     * @return the operation status and message
     * @endpoint "/agent/application/approve"
     */
    @RequestMapping("/agent/application/approve")
    public String approve(@RequestParam("id") long id, ApprovalDTO dto) {
        try {
            completeReview(id, dto, false, "");
            ControllerHelper.flashInfo("Approval request has been sent, you will be notified once it is processed.");
        } catch (PortalServiceException ex) {
            ControllerHelper.flashError(USER_ERROR_MSG);
        }
        return "redirect:/ops/viewDashboard";
    }

    /**
     * Completes the review step of the screening process.
     *
     * @param applicationId the application id
     * @param dto      the manual verification changes (if any)
     * @param reject   true if the application is to be denied
     * @param reason   the reason for denial
     * @throws PortalServiceException for any errors encountered
     */
    private void completeReview(
            long applicationId,
            ApprovalDTO dto,
            boolean reject,
            String reason
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Application application = applicationService.getApplicationDetails(user, applicationId);

        long processInstanceId = application.getProcessInstanceId();
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
     * @param dto    the manual verification dto
     * @param taskId the screening task id
     * @return the modified provider profile
     * @throws Exception for any errors encountered
     */
    private ProviderInformationType applyChanges(
            ApprovalDTO dto,
            long taskId
    ) throws Exception {
        if (dto == null) { // no changes
            return null;
        }

        ApplicationType applicationType = businessProcessService.getTaskModel(taskId).getApplication();
        ProviderInformationType provider = applicationType.getProviderInformation();
        VerificationStatusType status = provider.getVerificationStatus();
        if ("Y".equals(dto.getNonExclusionVerified())) { // modify only if set to Y
            status.setNonExclusion("Y");
        }
        if ("Y".equals(dto.getNotInDmfVerified())) { // modify only if set to Y
            status.setNotInDmf("Y");
        }

        return provider;
    }

    /**
     * Executes the search.
     *
     * @param criteria the search criteria
     * @param view     the view to render the results
     * @return the search results
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView doSearch(
            String viewName,
            ProviderSearchCriteria criteria
    ) throws PortalServiceException {
        if (criteria.getPageNumber() == 0 && criteria.getPageSize() == 0) {
            criteria.setPageNumber(1);
            criteria.setPageSize(10);
            criteria.setAscending(false);
            criteria.setSortColumn("6");
        }
        SearchResult<UserRequest> results = applicationService
                .searchApplications(ControllerHelper.getCurrentUser(), criteria);

        ModelAndView mv = new ModelAndView(viewName, "results", results);
        if (criteria.getStatuses() == null || criteria.getStatuses().isEmpty()) {
            mv.addObject("Status", "");
        } else {
            mv.addObject("Status", criteria.getStatuses().get(0));
        }

        // populate notes
        List<UserRequest> items = results.getItems();
        if (items != null) {
            for (UserRequest item : items) {
                item.setNotes(applicationService.findNotes(item.getApplicationId()));
            }
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

        ControllerHelper.addPaginationDetails(results, mv);
        ControllerHelper.addPaginationLinks(results, mv);

        return mv;
    }

    /**
     * This action will load the COS associated with a provider.
     *
     * @param profileId the profile id
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/cos"
     */
    @RequestMapping("/agent/application/cos")
    public ModelAndView viewCategoryOfService(
            @RequestParam("id") long applicationId
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Optional<Application> application = applicationService.getApplication(user, applicationId);
        if (application.isPresent()) {
            ModelAndView mv = new ModelAndView("admin/service_agent_application_cos", "application", application);
            List<ProviderCategoryOfService> existingServices = applicationService.getPendingCategoryOfServices(user,
                    applicationId);
            mv.addObject("existingServices", existingServices);
            // get the COS codes using lookup
            mv.addObject("codes", lookupService.findAllLookups(CategoryOfService.class));
            return mv;
        }
        throw new PortalServiceException("Cannot find the application for the given id.");
    }

    /**
     * This action will load the COS associated with a application.
     *
     * @param applicationId the application id
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/pendingcos"
     */
    @RequestMapping("/agent/application/pendingcos")
    public ModelAndView viewPendingCategoryOfService(
            @RequestParam("id") long applicationId
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Application application = applicationService.getApplicationDetails(user, applicationId);
        if (application != null) {
            ModelAndView mv = new ModelAndView("admin/service_agent_application_pending_cos", "application", application);
            List<ProviderCategoryOfService> existingServices = applicationService.getPendingCategoryOfServices(user,
                    applicationId);
            mv.addObject("existingServices", existingServices);
            // get the COS codes using lookup
            mv.addObject("codes", lookupService.findAllLookups(CategoryOfService.class));
            return mv;
        }
        throw new PortalServiceException("Cannot find the application for the given id.");
    }

    /**
     * Saves the category of services.
     *
     * @param profileId      the profile id
     * @param startDate      start date
     * @param endDate        end date
     * @param cos            the list of codes
     * @param prevCosId      previous cosId if copied
     * @param prevCosEndDate previous cos end date
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/addCOS"
     * @verb POST
     */
    @RequestMapping(
            value = "/agent/application/addCOS",
            method = RequestMethod.POST
    )
    public ModelAndView addCategoryOfService(
            @RequestParam("id") long profileId,
            @RequestParam("startDate") Date startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("cos") String[] cos,
            @RequestParam("prevCosId") long prevCosId,
            @RequestParam("prevCosEndDate") String prevCosEndDate
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderCategoryOfService categoryOfService = new ProviderCategoryOfService();
        List<CategoryOfService> categories = new ArrayList<>();
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

            //This used to be code that could potentially have added categories of service to
            //profiles, rather than applications, but this code doesn't look like it was actually
            //used.  In the case that it is in the future, you have to figure out how to properly
            //uncomment the following section and stop throwing the exception.
            //
            //Of note, the call to applicationService.addCOSToProfile has been removed because it makes
            //no more sense, so that will have to be investigated too.

            /*
             * categoryOfService.setProfileId(profileId);
             *
             * Date prevCatEndDate = null;
             * if (prevCosId != 0) {
             *     try {
             *         prevCatEndDate = dateFormat.parse(prevCosEndDate);
             *     } catch (ParseException e) {
             *         // ignore
             *     }
             * }
             * applicationService.addCOSToProfile(user, categoryOfService, prevCosId, prevCatEndDate);
             */

            throw new PortalServiceException("Category of Services can no longer be added to profiles");
        }
        return new ModelAndView("redirect:/agent/application/cos?id=" + profileId);
    }

    /**
     * Saves the category of services.
     *
     * @param applicationId       the application id
     * @param startDate      start date
     * @param endDate        end date
     * @param cos            the list of codes
     * @param prevCosId      previous cosId if copied
     * @param prevCosEndDate previous cos end date
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/addPendingCOS"
     * @verb POST
     */
    @RequestMapping(
            value = "/agent/application/addPendingCOS",
            method = RequestMethod.POST
    )
    public ModelAndView addPendingCategoryOfService(
            @RequestParam("id") long applicationId,
            @RequestParam("startDate") Date startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("cos") String[] cos,
            @RequestParam("prevCosId") long prevCosId,
            @RequestParam("prevCosEndDate") String prevCosEndDate
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderCategoryOfService categoryOfService = new ProviderCategoryOfService();
        List<CategoryOfService> categories = new ArrayList<>();
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
            categoryOfService.setApplicationId(applicationId);
            Date prevCatEndDate = null;
            if (prevCosId != 0) {
                try {
                    prevCatEndDate = dateFormat.parse(prevCosEndDate);
                } catch (ParseException e) {
                    // ignore
                }
            }
            applicationService.addCOSToApplication(user, categoryOfService, prevCosId, prevCatEndDate);
        }
        return new ModelAndView("redirect:/agent/application/pendingcos?id=" + applicationId);
    }

    /**
     * Deletes the Category of Service.
     *
     * @param profileId the profile id
     * @param id        cos id
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/deleteCOS"
     */
    @RequestMapping("/agent/application/deleteCOS")
    public ModelAndView deleteCategoryOfService(
            @RequestParam("profileId") long profileId,
            @RequestParam("id") long id
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        applicationService.deleteCOSByProfile(user, profileId, id);
        return new ModelAndView("redirect:/agent/application/cos?id=" + profileId);
    }

    /**
     * Deletes the pending Category of Service.
     *
     * @param applicationId the application id
     * @param id       cos id
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/agent/application/deletePendingCOS"
     */
    @RequestMapping("/agent/application/deletePendingCOS")
    public ModelAndView deletePendingCategoryOfService(
            @RequestParam("applicationId") long applicationId,
            @RequestParam("id") long id
    ) throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        applicationService.deleteCOSByApplication(user, applicationId, id);
        return new ModelAndView("redirect:/agent/application/pendingcos?id=" + applicationId);
    }
}
