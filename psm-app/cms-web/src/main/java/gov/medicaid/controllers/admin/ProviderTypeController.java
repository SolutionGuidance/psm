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
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.AgreementDocumentService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderTypeService;
import gov.medicaid.services.util.Util;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 * This controller class that manages a provider type.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public class ProviderTypeController {
    private final AgreementDocumentService agreementDocumentService;
    private final LookupService lookupService;
    private final ProviderTypeService providerTypeService;

    public ProviderTypeController(
        AgreementDocumentService agreementDocumentService,
        LookupService lookupService,
        ProviderTypeService providerTypeService
    ) {
        this.agreementDocumentService = agreementDocumentService;
        this.lookupService = lookupService;
        this.providerTypeService = providerTypeService;
    }

    /**
     * This action will load the provider types page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewProviderTypes"
     * @verb GET
     */
    @RequestMapping(value = "/admin/viewProviderTypes", method = RequestMethod.GET)
    public ModelAndView view() throws PortalServiceException {
        ProviderTypeSearchCriteria criteria = new ProviderTypeSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(10);
        criteria.setSortColumn("description");

        SearchResult<ProviderType> result = providerTypeService.search(criteria);
        result.getItems().forEach(providerTypeService::updateProviderTypeCanDelete);
        ModelAndView model = new ModelAndView("admin/service_admin_provider_types");
        model.addObject("providerTypesSearchResult", result);
        model.addObject("searchCriteria", criteria);
        ControllerHelper.addPaginationDetails(result, model);
        ControllerHelper.addPaginationLinks(result, model);
        return model;
    }

    /**
     * This action will search for provider types.
     *
     * @param criteria the search criteria
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewProviderTypes"
     * @verb POST
     */
    @RequestMapping(value = "/admin/viewProviderTypes", method = RequestMethod.POST)
    public ModelAndView search(@ModelAttribute("criteria") ProviderTypeSearchCriteria criteria)
        throws PortalServiceException {
        SearchResult<ProviderType> result = providerTypeService.search(criteria);
        result.getItems().forEach(providerTypeService::updateProviderTypeCanDelete);
        ModelAndView model = new ModelAndView("admin/service_admin_provider_types");
        model.addObject("providerTypesSearchResult", result);
        model.addObject("searchCriteria", criteria);
        ControllerHelper.addPaginationDetails(result, model);
        ControllerHelper.addPaginationLinks(result, model);
        return model;
    }

   /**
     * This action will get the entity with the given ID.
     *
     * @param providerTypeId the entity ID
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/getProviderType"
     * @verb GET
     */
    @RequestMapping(value = "/admin/getProviderType", method = RequestMethod.GET)
    public ModelAndView get(@RequestParam("providerTypeId") String providerTypeId) throws PortalServiceException {
        ProviderType providerType = providerTypeService.get(providerTypeId);
        providerTypeService.updateProviderTypeCanDelete(providerType);
        return view(providerType);
    }

    /**
     * This action will prepare for the creation of the entity.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/beginCreateProviderType"
     * @verb GET
     */
    @RequestMapping(value = "/admin/beginCreateProviderType", method = RequestMethod.GET)
    public ModelAndView beginCreate() throws PortalServiceException {
        return addCommonElements(
            new ModelAndView("admin/service_admin_create_provider_type"),
            new ProviderType()
        );
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param providerTypeId the entity ID
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/beginEditProviderType"
     * @verb GET
     */
    @RequestMapping(value = "/admin/beginEditProviderType", method = RequestMethod.GET)
    public ModelAndView beginEdit(@RequestParam("providerTypeId") String providerTypeId) throws PortalServiceException {
        ProviderType providerType = providerTypeService.get(providerTypeId);

        return addCommonElements(
            new ModelAndView("admin/service_admin_edit_provider_type"),
            providerType);
    }

    /**
     * This action will create the entity.
     *
     * @param providerType the providerType
     * @param request the http servlet request
     * @return the model and view for creationg result
     * @throws IllegalArgumentException if providerType is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/createProviderType"
     * @verb POST
     */
    @RequestMapping(value = "/admin/createProviderType", method = RequestMethod.POST)
    public ModelAndView create(@ModelAttribute("providerType") ProviderType providerType, HttpServletRequest request)
        throws PortalServiceException {
        boolean blank = Util.isBlank(providerType.getDescription());
        boolean exists = lookupService.findLookupByDescription(ProviderType.class, providerType.getDescription()) != null;

        long[] agreementIds = ServletRequestUtils.getLongParameters(request, "providerAgreements");
        String[] licenseIds = ServletRequestUtils.getStringParameters(request, "providerLicenses");

        if (!blank && !exists) {
            providerTypeService.create(providerType);

            // Retrieve
            providerType = providerTypeService.get(providerType.getCode());

            providerTypeService.updateProviderTypeAgreementSettings(providerType, agreementIds);
            providerTypeService.updateProviderTypeLicenseSettings(providerType, licenseIds);

            return view(providerType);
        } else {
            FormError error = new FormError();
            error.setFieldId("providerTypeDescription");

            if (blank) {
                error.setMessage("Please specify a provider type.");
            } else if (exists) {
                error.setMessage("Specified provider type already exists.");
            }

            return addCommonElements(
                new ModelAndView("admin/service_admin_create_provider_type"),
                providerType,
                agreementIds,
                licenseIds,
                Collections.singletonList(error));
        }
    }

    /**
     * This action will save the entity.
     *
     * @param providerType the providerType
     * @param request the http servlet request
     * @return the model and view for update result
     * @throws IllegalArgumentException if providerType is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateProviderType"
     * @verb POST
     */
    @RequestMapping(value = "/admin/updateProviderType", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("providerType") ProviderType providerType, HttpServletRequest request)
        throws PortalServiceException {

        long[] agreementIds = ServletRequestUtils.getLongParameters(request, "providerAgreements");
        String[] licenseIds = ServletRequestUtils.getStringParameters(request, "providerLicenses");

        ProviderType typeByDesc = lookupService.findLookupByDescription(
            ProviderType.class,
            providerType.getDescription()
        );

        if (typeByDesc != null && !typeByDesc.getCode().equals(providerType.getCode())) {
            FormError error = new FormError();
            error.setFieldId("providerTypeDescription");
            error.setMessage("Cannot have a duplicate description: " + providerType.getDescription());

            return addCommonElements(
                new ModelAndView("admin/service_admin_edit_provider_type"),
                providerType,
                agreementIds,
                licenseIds,
                Collections.singletonList(error)
            );
        } else {
            providerTypeService.update(providerType);
            providerType = providerTypeService.get(providerType.getCode());

            providerTypeService.updateProviderTypeAgreementSettings(providerType, agreementIds);
            providerTypeService.updateProviderTypeLicenseSettings(providerType, licenseIds);

            return view(providerType);
        }
    }

    /**
     * This action will delete the entities with the given IDs from the single view.
     *
     * @param providerTypeIds the entity IDs
     * @param request the http servlet request
     * @return the successful text
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/deleteProviderTypes"
     * @verb GET
     */
    @RequestMapping(value = "/admin/deleteProviderTypes", method = RequestMethod.GET)
    @ResponseBody
    public String delete(@RequestParam("providerTypeIds") String[] providerTypeIds, HttpServletRequest request)
        throws PortalServiceException {
        for (String providerTypeId : providerTypeIds) {
            providerTypeService.delete(providerTypeId);
        }
        return "success";
    }

    private ModelAndView view(ProviderType providerType) {
        ModelAndView model = new ModelAndView("admin/service_admin_view_provider_type");
        model.addObject("providerType", providerType);
        model.addObject("agreements", providerType.getAgreementDocuments());
        model.addObject("licenseTypes", providerType.getLicenseTypes());
        return model;
    }

    private ModelAndView addCommonElements(ModelAndView mv, ProviderType providerType) throws PortalServiceException {
        return addCommonElements(
            mv,
            providerType,
            providerType.getAgreementDocuments() == null ?
                new long[0] :
                providerType.getAgreementDocuments()
                    .stream()
                    .mapToLong(AgreementDocument::getId)
                    .toArray(),
            providerType.getLicenseTypes() == null ?
                new String[0] :
                providerType.getLicenseTypes()
                    .stream()
                    .map(LicenseType::getCode)
                    .toArray(String[]::new),
            null
        );
    }

    private ModelAndView addCommonElements(
        ModelAndView mv,
        ProviderType providerType,
        long[] selectedAgreementIds,
        String[] selectedLicenseCodes,
        List<FormError> errors
    ) throws PortalServiceException {
        // Retrieve agreements
        AgreementDocumentSearchCriteria criteria = new AgreementDocumentSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(-1);
        List<AgreementDocument> agreements = agreementDocumentService.search(criteria).getItems();
        List<AgreementDocument> selectedAgreements = new ArrayList<AgreementDocument>();
        List<AgreementDocument> remainingAgreements = new ArrayList<AgreementDocument>(agreements);

        for (AgreementDocument agreement: agreements) {
            for (long selectedAgreementId: selectedAgreementIds) {
                if (selectedAgreementId == agreement.getId()) {
                    selectedAgreements.add(agreement);
                    remainingAgreements.remove(agreement);
                    break;
                }
            }
        }
        mv.addObject("providerType", providerType);
        mv.addObject("selectedAgreements", selectedAgreements);
        mv.addObject("remainingAgreements", remainingAgreements);

        List<LicenseType> allLicenseTypes = lookupService.findAllLookups(LicenseType.class);

        mv.addObject("selectedLicenseCodes", selectedLicenseCodes);
        mv.addObject("allLicenseTypes", allLicenseTypes);
        mv.addObject("errors", errors);
        return mv;
    }
}
