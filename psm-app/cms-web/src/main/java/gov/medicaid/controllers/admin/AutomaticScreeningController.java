package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.BaseController;
import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.controllers.dto.ScreeningDTO;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.DmfAutomaticScreening;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ScreeningSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.ScreeningService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/agent/")
public class AutomaticScreeningController extends BaseController {
    private final ScreeningService screeningService;
    private final ProviderEnrollmentService providerEnrollmentService;

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
                screening.getEnrollment().getEnrollmentId()
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
                screening.getEnrollment().getEnrollmentId()
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
                .getProviderDetails(enrollment.getProfileReferenceId(), true);

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
        dto.enrollmentId = enrollment.getEnrollmentId();
        return dto;
    }

    @RequestMapping(value = "/screenings", method = RequestMethod.GET)
    public ModelAndView view(
            @ModelAttribute ScreeningSearchCriteria criteria
    ) {
        setCriteriaDefaults(criteria);

        ModelAndView mv = new ModelAndView("admin/screenings");
        mv.addObject("activeTab", criteria.getStatus());

        SearchResult<AutomaticScreening> screenings =
                screeningService.getScreenings(criteria);

        ControllerHelper.addPaginationDetails(screenings, mv);
        ControllerHelper.addPaginationLinks(screenings, mv);

        mv.addObject("startDate", criteria.getStartDate());
        mv.addObject("endDate", criteria.getEndDate());
        mv.addObject("criteria", criteria);
        mv.addObject(
                "screenings",
                screenings
                        .getItems()
                        .stream()
                        .map(this::getScreeningDetails)
                        .collect(Collectors.toList())
        );
        return mv;
    }

    private void setCriteriaDefaults(ScreeningSearchCriteria criteria) {
        if (criteria.getPageNumber() == 0) {
            criteria.setPageSize(10);
            criteria.setPageNumber(1);
        }

        if (criteria.getStatus() == null) {
            criteria.setStatus("all");
        }
        if (criteria.getEndDate() == null) {
            criteria.setEndDate(
                    Date.from(
                            LocalDateTime.now()
                                    .toLocalDate()
                                    .atStartOfDay(ZoneId.systemDefault()).toInstant()
                    )
            );
        }
        if (criteria.getStartDate() == null) {
            criteria.setStartDate(
                    Date.from(
                            LocalDateTime.now()
                                    .minusMonths(1)
                                    .toLocalDate()
                                    .atStartOfDay(ZoneId.systemDefault()).toInstant()
                    )
            );
        }
    }
}
