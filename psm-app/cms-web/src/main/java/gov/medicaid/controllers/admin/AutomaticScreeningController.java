package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.BaseController;
import gov.medicaid.controllers.dto.ScreeningDTO;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.DmfAutomaticScreening;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.ScreeningService;
import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/agent/")
public class AutomaticScreeningController extends BaseController {
    private final ScreeningService screeningService;
    private final ProviderEnrollmentService providerEnrollmentService;
    private static final String DATE_PATTERN = "MM/dd/yyyy";

    public AutomaticScreeningController(
            ScreeningService screeningService,
            ProviderEnrollmentService providerEnrollmentService
    ) {
        this.screeningService = screeningService;
        this.providerEnrollmentService = providerEnrollmentService;
    }

    @RequestMapping("/automatic-screening/{automaticScreeningId}")
    public ModelAndView viewScreening(
            @PathVariable long automaticScreeningId
    ) {
        AutomaticScreening screening = screeningService.findScreening(
                automaticScreeningId
        ).orElseThrow(() -> new PortalServiceRuntimeException(
                "No automatic screening found with that ID."
        ));

        if (screening instanceof LeieAutomaticScreening) {
            return showLeieScreening((LeieAutomaticScreening) screening);
        } else if (screening instanceof DmfAutomaticScreening) {
            return showDmfScreening((DmfAutomaticScreening) screening);
        } else {
            throw new PortalServiceRuntimeException(
                    "Unknown automatic screening type " +
                            screening.getClass().getCanonicalName()
            );
        }
    }

    private ModelAndView showLeieScreening(LeieAutomaticScreening screening) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/automatic_screening_leie");
        mv.addObject(
                "enrollment_id",
                screening.getEnrollment().getTicketId()
        );
        mv.addObject(
                "in_review",
                ViewStatics.PENDING_STATUS.equals(
                        screening.getEnrollment()
                                .getStatus()
                                .getDescription())
        );
        mv.addObject("screening_result", screening.getResult().toString());
        mv.addObject("screening_date", screening.getCreatedAt());
        mv.addObject("search_term", screening.getNpiSearchTerm());
        mv.addObject("exclusions", screening.getMatches());
        return mv;
    }

    private ModelAndView showDmfScreening(DmfAutomaticScreening screening) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/automatic_screening_dmf");
        mv.addObject(
                "enrollment_id",
                screening.getEnrollment().getTicketId()
        );
        mv.addObject(
                "in_review",
                ViewStatics.PENDING_STATUS.equals(
                        screening.getEnrollment()
                                .getStatus()
                                .getDescription())
        );
        mv.addObject("screening_result", screening.getResult().toString());
        mv.addObject("screening_date", screening.getCreatedAt());
        mv.addObject("results", screening.getMatches());
        return mv;
    }

    private ScreeningDTO getScreeningDetails(AutomaticScreening screening) {
        Enrollment enrollment = screening.getEnrollment();
        ProviderProfile profile = providerEnrollmentService
                .getProviderDetailsByTicket(enrollment.getTicketId(), true);

        ScreeningDTO dto = new ScreeningDTO();
        dto.date = Date.from(screening.getCreatedAt()
                .atZone(ZoneId.systemDefault())
                .toInstant());
        dto.npi = profile.getEntity().getNpi();
        dto.screeningId = screening.getAutomaticScreeningId();
        dto.providerName = profile.getEntity().getName();
        dto.providerType = profile.getEntity()
                .getProviderType()
                .getDescription();
        dto.reason = enrollment.getStatusNote();
        dto.screeningType = screening.getType();
        dto.result = screening.getResult();
        dto.enrollmentId = enrollment.getTicketId();
        return dto;
    }

    @RequestMapping(value = "/screenings", method = RequestMethod.GET)
    public ModelAndView view(
            @RequestParam Map<String, String> params
    ) {
        ModelAndView mv = new ModelAndView("admin/screenings");
        mv.addObject("activeTab", MapUtils.getObject(params, "status", "all"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(DATE_PATTERN);
        if (!params.containsKey("endDate")) {
            params.put(
                    "endDate",
                    LocalDateTime.now()
                            .toLocalDate()
                            .format(formatter)
            );
        }
        if (!params.containsKey("startDate")) {
            params.put(
                    "startDate",
                    LocalDateTime.now()
                            .minusMonths(1)
                            .toLocalDate()
                            .format(formatter)
            );
        }
        mv.addObject("startDate", params.get("startDate"));
        mv.addObject("endDate", params.get("endDate"));
        mv.addObject(
                "screenings",
                screeningService.getScreenings(params)
                        .stream()
                        .map(this::getScreeningDetails)
                        .collect(Collectors.toList())
        );
        return mv;
    }
}
