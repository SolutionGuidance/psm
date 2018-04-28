/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.controllers.reports;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.security.CMSPrincipal;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

/**
 * Handles reports.
 *
 * @version 1.0
 * @endpoint "/reports/*"
 */
@Controller
@RequestMapping("/reports/enrollmentapproval/*")
public class EnrollmentApprovalReportController extends gov.medicaid.controllers.BaseController {

    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Service used to perform operations.
     */
    private ProviderEnrollmentService enrollmentService;

    /**
     * Sets the value of the field <code>enrollmentService</code>.
     *
     * @param enrollmentService the enrollmentService to set
     */
    public void setEnrollmentService(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (enrollmentService == null) {
            throw new PortalServiceConfigurationException("enrollmentService is not configured correctly.");
        }
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public void getEnrollments(
        @RequestParam(value = "startDate", required = false) Date startDate,
        @RequestParam(value = "endDate", required = false) Date endDate,
        HttpServletResponse response
    ) throws PortalServiceException {
        CMSPrincipal principal = ControllerHelper.getPrincipal();

        String csvFileName = "enrollments.csv";
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setCreateDateStart(startDate);
        criteria.setCreateDateEnd(endDate);
        SearchResult<Enrollment> result = enrollmentService.searchEnrollments(principal.getUser(), criteria);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);
            for(Enrollment enrollment : result.getItems()) {
                csvPrinter.printRecord(enrollment.getTicketId(), enrollment.getCreatedOn());
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }

    }
}
