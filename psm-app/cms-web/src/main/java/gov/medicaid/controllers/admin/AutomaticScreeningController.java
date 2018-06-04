package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.dto.ScreeningDTO;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.LeieAutomaticScreening;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.ScreeningService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.stream.Collectors;

@Controller
@RequestMapping("/agent/")
public class AutomaticScreeningController extends BaseServiceAdminController {
    private final ScreeningService screeningService;

    public AutomaticScreeningController(ScreeningService screeningService) {
        this.screeningService = screeningService;
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

    private ScreeningDTO getScreeningDetails(AutomaticScreening screening) {
        // TODO: Accessing provider details is WIP.
        // Entity entity = screening.getEnrollment().getDetails().getEntity();
        // entity.getNpi();
        // entity.getName();
        // entity.getProviderType().getDescription();

        ScreeningDTO dto = new ScreeningDTO();
        dto.date = screening.getCreatedAt();
        dto.npi = "...";
        dto.providerName = "...";
        dto.providerType = "...";
        dto.reason = "New Enrollment";
        dto.screeningType = "LEIE";
        dto.result = screening.getResult();
        return dto;
    }

    @RequestMapping(value = "/screenings", method = RequestMethod.GET)
    public ModelAndView view() {
        ModelAndView mv = new ModelAndView("admin/screenings");

        mv.addObject(
                "screenings",
                screeningService.getAllScreenings()
                        .stream()
                        .map(this::getScreeningDetails)
                        .collect(Collectors.toList())
        );
        return mv;
    }
}
