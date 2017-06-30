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

import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ScreeningService;
import gov.medicaid.services.util.LogUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class that manages the screening schedule.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ScreeningScheduleController extends BaseServiceAdminController {

    /**
     * Represents the screening schedule service. It is managed with a getter and setter. It may have any value, but is
     * expected to be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to
     * change after dependency injection.
     */
    private ScreeningService screeningService;

    /**
     * Empty constructor.
     */
    public ScreeningScheduleController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();

        if (screeningService == null) {
            throw new PortalServiceConfigurationException("screeningService must be configured.");
        }
    }

    /**
     * This method is used to convert the date field.
     *
     * @param binder the WebDataBinder instance
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm a", Locale.US);
        binder.registerCustomEditor(Date.class, "upcomingScreeningDate", new CustomDateEditor(dateFormat, false));
    }

    /**
     * This action will get the screen schedule.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/getScreeningSchedule"
     * @verb GET
     */
    @RequestMapping(value = "/admin/getScreeningSchedule", method = RequestMethod.GET)
    public ModelAndView get() throws PortalServiceException {
        String signature = "ScreeningScheduleController#get()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            ScreeningSchedule schedule = screeningService.getScreeningSchedule();
            ModelAndView model = new ModelAndView("admin/service_admin_view_schedule");
            model.addObject("schedule", schedule);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/beginEditScreeningSchedule"
     * @verb GET
     */
    @RequestMapping(value = "/admin/beginEditScreeningSchedule", method = RequestMethod.GET)
    public ModelAndView beginEdit() throws PortalServiceException {
        String signature = "ScreeningScheduleController#beginEdit()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            ScreeningSchedule schedule = screeningService.getScreeningSchedule();
            ModelAndView model = new ModelAndView("admin/service_admin_edit_schedule");
            model.addObject("schedule", schedule);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will save the entity.
     *
     * @param schedule the ScreeningSchedule
     * @param request the http servlet request
     * @return the model and view instance
     * @throws IllegalArgumentException if screeningSchedule is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateScreeningSchedule"
     * @verb POST
     */
    @RequestMapping(value = "/admin/updateScreeningSchedule", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("schedule") ScreeningSchedule schedule, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "ScreeningScheduleController#edit(ScreeningSchedule screeningSchedule)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"screeningSchedule"}, new Object[] {schedule});

        try {
            screeningService.saveScreeningSchedule(schedule);

            ModelAndView model = new ModelAndView("admin/service_admin_view_schedule");
            model.addObject("schedule", schedule);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Getter of screeningService.
     *
     * @return the screeningService
     */
    public ScreeningService getScreeningService() {
        return screeningService;
    }

    /**
     * Set the screeningService.
     *
     * @param screeningService the screeningService to set
     */
    public void setScreeningService(ScreeningService screeningService) {
        this.screeningService = screeningService;
    }
}
