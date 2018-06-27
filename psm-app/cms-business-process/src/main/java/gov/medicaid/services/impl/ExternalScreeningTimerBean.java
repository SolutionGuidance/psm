package gov.medicaid.services.impl;

import com.google.common.annotations.VisibleForTesting;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
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
    private ProviderEnrollmentService providerEnrollmentService;

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

    private void runRescreenings() throws PortalServiceException {
        for (UserRequest enrollment : getRescreenableEnrollments()) {
            logger.info(String.format(
                "Running automatic re-screenings for enrollment " +
                    "with enrollment_id %d.",
                enrollment.getTicketId()
            ));
            leieExternalScreener.screen(
                enrollment.getTicketId(),
                enrollment.getNpi()
            );
        }
    }

    private List<UserRequest> getRescreenableEnrollments() throws PortalServiceException {
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setStatuses(Collections.singletonList(
            ViewStatics.APPROVED_STATUS
        ));
        return providerEnrollmentService.searchTickets(
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
    public void setProviderEnrollmentService(ProviderEnrollmentService providerEnrollmentService) {
        this.providerEnrollmentService = providerEnrollmentService;
    }
}
