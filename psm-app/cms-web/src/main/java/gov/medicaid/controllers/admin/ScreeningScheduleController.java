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

import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ScreeningService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Preconditions.checkNotNull;

/**
 * <p>
 * This controller class that manages the screening schedule.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public class ScreeningScheduleController {
    private final ScreeningService screeningService;

    public ScreeningScheduleController(ScreeningService screeningService) {
        this.screeningService = screeningService;
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
    @RequestMapping(
        value = "/admin/getScreeningSchedule",
        method = RequestMethod.GET
    )
    public ModelAndView get() throws PortalServiceException {
        ScreeningSchedule schedule = screeningService.getScreeningSchedule();
        ModelAndView model = new ModelAndView("admin/service_admin_view_schedule");
        model.addObject("schedule", schedule);

        return model;
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
    @RequestMapping(
        value = "/admin/beginEditScreeningSchedule",
        method = RequestMethod.GET
    )
    public ModelAndView beginEdit() throws PortalServiceException {
        ScreeningSchedule schedule = screeningService.getScreeningSchedule();
        ModelAndView model = new ModelAndView("admin/service_admin_edit_schedule");
        model.addObject("schedule", schedule);
        return model;
    }

    /**
     * This action will save the entity.
     *
     * @param schedule the ScreeningSchedule
     * @return the model and view instance
     * @throws IllegalArgumentException if screeningSchedule is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateScreeningSchedule"
     * @verb POST
     */
    @RequestMapping(
        value = "/admin/updateScreeningSchedule",
        method = RequestMethod.POST
    )
    public ModelAndView edit(
        @ModelAttribute("schedule") ScreeningSchedule schedule
    ) throws PortalServiceException {
        validateSchedule(schedule);

        screeningService.saveScreeningSchedule(schedule);

        ModelAndView model = new ModelAndView("admin/service_admin_view_schedule");
        model.addObject("schedule", schedule);

        return model;
    }

    private void validateSchedule(ScreeningSchedule schedule) {
        checkNotNull(schedule, "Schedule is required.");
        checkNotNull(
            schedule.getDayOfMonth(),
            "Day of month is required."
        );
        checkArgument(
            schedule.getDayOfMonth() >= 1 && schedule.getDayOfMonth() <= 28,
            "Day of month must be between 1 and 28."
        );
        checkNotNull(
            schedule.getHourOfDay(),
            "Hour of day is required."
        );
        checkArgument(
            schedule.getHourOfDay() >= 0 && schedule.getHourOfDay() < 24,
            "Hour of day must be between 0 and 23."
        );
    }
}
