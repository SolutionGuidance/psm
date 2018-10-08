/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.AgreementDocumentSearchCriteria;
import gov.medicaid.entities.AgreementDocumentType;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.AgreementDocumentService;
import gov.medicaid.services.PortalServiceException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.security.Principal;

/**
 * <p>
 * This controller class that manages agreement documents.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public class AgreementDocumentController {
    private final AgreementDocumentService agreementDocumentService;

    public AgreementDocumentController(AgreementDocumentService agreementDocumentService) {
        this.agreementDocumentService = agreementDocumentService;
    }

    /**
     * This action will load the agreement documents page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewAgreementDocuments"
     * @verb GET
     */
    @RequestMapping(value = "/admin/viewAgreementDocuments", method = RequestMethod.GET)
    public ModelAndView view() throws PortalServiceException {
        AgreementDocumentSearchCriteria criteria = new AgreementDocumentSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(10);
        criteria.setSortColumn("title");
        criteria.setAscending(true);
        return search(criteria);
    }

    /**
     * This action will search for agreement documents.
     *
     * @param criteria the search criteria
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewAgreementDocuments"
     * @verb POST
     */
    @RequestMapping(value = "/admin/viewAgreementDocuments", method = RequestMethod.POST)
    public ModelAndView search(@ModelAttribute("criteria") AgreementDocumentSearchCriteria criteria)
        throws PortalServiceException {
        SearchResult<AgreementDocument> result = agreementDocumentService.search(criteria);
        ModelAndView model = new ModelAndView("admin/service_admin_agreement_documents");
        model.addObject("agreementDocumentsSearchResult", result);
        model.addObject("searchCriteria", criteria);
        ControllerHelper.addPaginationDetails(result, model);
        ControllerHelper.addPaginationLinks(result, model);
        return model;
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param id the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/getAgreementDocument"
     * @verb GET
     */
    @RequestMapping(value = "/admin/getAgreementDocument", method = RequestMethod.GET)
    public ModelAndView get(@RequestParam("agreementId") long id) throws PortalServiceException {
        AgreementDocument agreementDocument = agreementDocumentService.get(id);
        ModelAndView model = new ModelAndView("admin/service_admin_view_agreement_document");
        model.addObject("agreementDocument", agreementDocument);

        return model;
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param id the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/provider/application/agreement"
     * @verb GET
     */
    @RequestMapping(value = "/provider/application/agreement", method = RequestMethod.GET)
    public ModelAndView getAgreement(@RequestParam("id") long id) throws PortalServiceException {
        AgreementDocument agreementDocument = agreementDocumentService.get(id);
        ModelAndView model = new ModelAndView("provider/application/view_agreement");
        model.addObject("agreementDocument", agreementDocument);

        return model;
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param id the entity ID
     * @param agreementDocumentType the agreement document type to add
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/editAgreementDocument"
     * @verb GET
     */
    @RequestMapping(value = "/admin/editAgreementDocument", method = RequestMethod.GET)
    public ModelAndView beginEdit(@RequestParam("agreementId") long id,
        @RequestParam(value = "agreementDocumentType", required = false) AgreementDocumentType agreementDocumentType)
        throws PortalServiceException {
        ModelAndView model = new ModelAndView("admin/service_admin_edit_agreement_document");
        if (id == 0) {
            AgreementDocument agreementDocument = new AgreementDocument();
            agreementDocument.setType(agreementDocumentType == AgreementDocumentType.AGREEMENT ? "01" : "02");
            model.addObject("agreementDocument", agreementDocument);
        } else {
            AgreementDocument agreementDocument = agreementDocumentService.get(id);
            model.addObject("agreementDocument", agreementDocument);
        }
        return model;
    }

    /**
     * This action will create the entity.
     *
     * @param agreementDocument the agreementDocument
     * @param request the http servlet request
     *
     * @return the model and view
     *
     * @throws IllegalArgumentException if agreementDocument is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/createAgreementDocument"
     * @verb POST
     */
    @RequestMapping(value = "/admin/createAgreementDocument", method = RequestMethod.POST)
    public ModelAndView create(@ModelAttribute("agreementDocument") AgreementDocument agreementDocument,
        HttpServletRequest request, Principal principal) throws PortalServiceException {
        agreementDocument.setCreatedBy(principal.getName());
        agreementDocumentService.create(agreementDocument);
        ModelAndView model = new ModelAndView("admin/service_admin_view_agreement_document");
        model.addObject("agreementDocument", agreementDocument);

        return model;
    }

    /**
     * This action will save the entity.
     *
     * @param agreementDocument the agreementDocument
     * @param request the http servlet request
     *
     * @return the model and view
     *
     * @throws IllegalArgumentException if agreementDocument is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateAgreementDocument"
     * @verb POST
     */
    @RequestMapping(value = "/admin/updateAgreementDocument", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("agreementDocument") AgreementDocument agreementDocument,
        HttpServletRequest request) throws PortalServiceException {
        agreementDocumentService.update(agreementDocument);

        ModelAndView model = new ModelAndView("admin/service_admin_view_agreement_document");
        model.addObject("agreementDocument", agreementDocument);

        return model;
    }

    /**
     * This action will delete the entities with the given IDs from the single view.
     *
     * @param agreementIds the entity IDs
     * @param request the http servlet request
     * @return the successful text
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/deleteAgreementDocuments"
     * @verb GET
     */
    @RequestMapping(value = "/admin/deleteAgreementDocuments", method = RequestMethod.GET)
    @ResponseBody
    public String delete(@RequestParam("agreementIds") long[] agreementIds, HttpServletRequest request)
        throws PortalServiceException {
        for (long agreementId : agreementIds) {
            agreementDocumentService.delete(agreementId);
        }
        return "success";
    }
}
