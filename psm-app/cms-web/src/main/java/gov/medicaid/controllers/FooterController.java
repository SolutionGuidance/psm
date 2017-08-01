package gov.medicaid.controllers;

import gov.medicaid.services.PortalServiceException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.medicaid.controllers.BaseController;
import org.springframework.web.servlet.ModelAndView;

/**
 * Allows us to insert a variable into the footer display.
 */
@Controller
public class FooterController {
    /**
     * This shows the footer, with the latest commit date.
     *
     * @return the model and view instance that contains the name of view to be
     * rendered and data to be used for rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/"
     * @verb GET
     */
    @RequestMapping(
            value = "/",
            method = RequestMethod.GET
    )
    public ModelAndView getFooter( ) throws PortalServiceException {

        String test = "TEST";
        ModelAndView model = new ModelAndView("footer");
        System.out.println("DEBUG: test value is " + test);
        model.addObject("date", test);

        return model;
    }
}
