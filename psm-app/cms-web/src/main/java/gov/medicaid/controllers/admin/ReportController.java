package gov.medicaid.controllers.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {
    @RequestMapping(value = "/admin/reports", method = RequestMethod.GET)
    public ModelAndView viewReports() {
        return new ModelAndView("admin/reports/reports");
    }

    @RequestMapping(
            value = "/admin/reports/applications-by-reviewer",
            method = RequestMethod.GET
    )
    public ModelAndView viewApprovedDenied() {
        return new ModelAndView("admin/reports/applications_by_reviewer");
    }
}
