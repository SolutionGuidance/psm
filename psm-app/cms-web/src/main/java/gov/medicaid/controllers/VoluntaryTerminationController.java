package gov.medicaid.controllers;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.ejb.EJB;
import java.util.logging.Logger;

@Controller
@RequestMapping("/provider/profile/{profileId}/terminate")
public class VoluntaryTerminationController {
    private final Logger logger = Logger.getLogger(getClass().getName());

    @EJB
    private final ProviderEnrollmentService providerEnrollmentService;

    public VoluntaryTerminationController(
            ProviderEnrollmentService providerEnrollmentService
    ) {
        this.providerEnrollmentService = providerEnrollmentService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView beginTermination(
            @PathVariable("profileId") Integer profileId
    ) throws PortalServiceException {
        ModelAndView mv = new ModelAndView("provider/profile/voluntary_termination_begin");
        CMSUser user = ControllerHelper.getCurrentUser();
        ProviderProfile profile = providerEnrollmentService.getProviderDetails(
                user,
                profileId
        );

        mv.addObject("profileId", profileId);
        mv.addObject("npi", profile.getEntity().getNpi());
        mv.addObject(
                "providerType",
                profile.getEntity().getProviderType().getDescription()
        );

        return mv;
    }
}
