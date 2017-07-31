package gov.medicaid.controllers;

import gov.medicaid.services.PortalServiceException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.medicaid.controllers.BaseController;
import org.springframework.web.servlet.ModelAndView;
import gov.medicaid.services.util.LogUtil;

/**
 * Allows us to insert a variable into the footer display.
 */
@Controller
public class FooterController extends BaseController {
    /**
     * Empty constructor.
     */
    public FooterController() {
    }

    /**
     * This shows the footer, with the latest commit date.
     *
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/footer"
     * @verb GET
     */
    @RequestMapping(
            value = "/footer",
            method = RequestMethod.GET
    )
    public ModelAndView getFooter( ) throws PortalServiceException {
        String signature = "FooterController#getFooter";
        LogUtil.traceEntry(getLog(), signature, new String[]{""}, new Object[]{null});

        ModelAndView model = new ModelAndView("/includes/footer");
        model.addObject("date", "TEST");

        return LogUtil.traceExit(getLog(), signature, model);
    }
}
