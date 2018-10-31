/*
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

package gov.medicaid.services.impl;

import com.google.common.annotations.VisibleForTesting;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.ScreeningService;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import java.time.Clock;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class ExternalScreeningTimerBean extends BaseService {
    private final Logger logger = Logger.getLogger(getClass().getName());
    private final Clock clock;

    private LeieExternalScreener leieExternalScreener;

    @EJB
    private ProviderApplicationService providerApplicationService;

    @EJB
    private ScreeningService screeningService;

    public ExternalScreeningTimerBean() {
        clock = Clock.systemDefaultZone();
    }

    @VisibleForTesting
    ExternalScreeningTimerBean(
        ScreeningService screeningService,
        Clock clock
    ) {
        this.screeningService = screeningService;
        this.clock = clock;
    }

    @PostConstruct
    @Override
    public void init() {
        super.init();

        CMSConfigurator config = new CMSConfigurator();
        leieExternalScreener = new LeieExternalScreener(
            config.getLeieApiBaseUrl(),
            getEm()
        );
    }

    @SuppressWarnings("unused") // automatically called by container on schedule
    @Schedule(hour = "*")
    public void periodicScheduleCheck() throws PortalServiceException {
        if (isScheduledTime()) {
            logger.info("Beginning re-screenings.");
            runRescreenings();
        } else {
            logger.finer(
                "Not starting re-screenings because now is not the time" +
                    " according to the screening schedule."
            );
        }
    }

    private void runRescreenings() {
        for (UserRequest application : getRescreenableApplications()) {
            logger.info(String.format(
                "Running automatic re-screenings for application " +
                    "with application_id %d.",
                application.getApplicationId()
            ));
            leieExternalScreener.screen(
                application.getApplicationId(),
                application.getNpi()
            );
        }
    }

    private List<UserRequest> getRescreenableApplications() {
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setStatuses(Collections.singletonList(
            ViewStatics.APPROVED_STATUS
        ));
        return providerApplicationService.searchApplications(
            getSystemUser(),
            criteria
        ).getItems();
    }

    @VisibleForTesting
    boolean isScheduledTime() throws PortalServiceException {
        LocalDateTime now = LocalDateTime.now(clock);
        ScreeningSchedule screeningSchedule = screeningService.getScreeningSchedule();
        return now.getDayOfMonth() == screeningSchedule.getDayOfMonth()
            && now.getHour() == screeningSchedule.getHourOfDay();
    }

    @SuppressWarnings("unused") // called by container to inject service
    public void setScreeningService(ScreeningService screeningService) {
        this.screeningService = screeningService;
    }

    @SuppressWarnings("unused") // called by container to inject service
    public void setProviderApplicationService(ProviderApplicationService providerApplicationService) {
        this.providerApplicationService = providerApplicationService;
    }
}
