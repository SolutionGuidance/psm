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
package gov.medicaid.controllers.admin;

import gov.medicaid.entities.HelpItem;
import gov.medicaid.entities.HelpSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.HelpService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.LogUtil;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class that manages help items.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class HelpController extends BaseServiceAdminController {
    /**
     * Represents the help service. it is managed with a getter and setter. It may have any value, but is expected to be
     * set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private HelpService helpService;

    /**
     * Empty constructor.
     */
    public HelpController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();

        if (helpService == null) {
            throw new PortalServiceConfigurationException("helpService must be configured.");
        }
    }

    /**
     * This action will load the help items page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/searchHelp"
     * @verb GET
     */
    @RequestMapping(value = "/admin/searchHelp", method = RequestMethod.GET)
    public ModelAndView view() throws PortalServiceException {
        String signature = "HelpController#view()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            // Package a ProviderSearchCriteria with first page of size 10 sorted by last update date column
            HelpSearchCriteria criteria = new HelpSearchCriteria();
            criteria.setPageNumber(1);
            criteria.setPageSize(-1);

            SearchResult<HelpItem> result = helpService.search(criteria);
            ModelAndView model = new ModelAndView("admin/service_admin_help_items");
            model.addObject("helpItems", result.getItems());

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will search for help items.
     *
     * @param criteria the search criteria
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/searchHelp"
     * @verb POST
     */
    @RequestMapping(value = "/admin/searchHelp", method = RequestMethod.POST)
    public ModelAndView search(@ModelAttribute("criteria") HelpSearchCriteria criteria) throws PortalServiceException {
        String signature = "HelpController#searchHelp(HelpSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"criteria"}, new Object[] {criteria});

        try {
            List<HelpItem> helpItems = helpService.search(criteria).getItems();
            ModelAndView model = new ModelAndView("admin/service_admin_help_items");
            model.addObject("helpItems", helpItems);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param helpItemId the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/getHelpItem"
     * @verb GET
     */
    @RequestMapping(value = "/admin/getHelpItem", method = RequestMethod.GET)
    public ModelAndView get(@RequestParam("helpItemId") long helpItemId) throws PortalServiceException {
        String signature = "HelpController#getHelpItem(long helpItemId)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"helpItemId"}, new Object[] {helpItemId});

        try {
            HelpItem helpItem = helpService.get(helpItemId);
            ModelAndView model = new ModelAndView("admin/service_admin_view_help_item");
            model.addObject("helpItem", helpItem);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param helpItemId the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/editHelpItem"
     * @verb GET
     */
    @RequestMapping(value = "/admin/editHelpItem", method = RequestMethod.GET)
    public ModelAndView beginEdit(@RequestParam("helpItemId") long helpItemId) throws PortalServiceException {
        String signature = "HelpController#beginEdit(long helpItemId)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"helpItemId"}, new Object[] {helpItemId});

        try {
            ModelAndView model = new ModelAndView("admin/service_admin_edit_help_item");
            if (helpItemId == 0) {
                model.addObject("helpItem", new HelpItem());
            } else {
                HelpItem helpItem = helpService.get(helpItemId);
                model.addObject("helpItem", helpItem);
            }
            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will create the entity.
     *
     * @param helpItem the helpItem
     * @param request the http servlet request
     *
     * @return the model and view
     *
     * @throws IllegalArgumentException if helpItem is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/createHelpItem"
     * @verb POST
     */
    @RequestMapping(value = "/admin/createHelpItem", method = RequestMethod.POST)
    public ModelAndView create(@ModelAttribute("helpItem") HelpItem helpItem, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "HelpController#create(HelpItem helpItem)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"helpItem"}, new Object[] {helpItem});

        try {
            helpService.create(helpItem);
            helpItem = helpService.get(helpItem.getId());

            ModelAndView model = new ModelAndView("admin/service_admin_view_help_item");
            model.addObject("helpItem", helpItem);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will save the entity.
     *
     * @param helpItem the helpItem
     * @param request the http servlet request
     *
     * @return the model and view
     *
     * @throws IllegalArgumentException if helpItem is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateHelpItem"
     * @verb POST
     */
    @RequestMapping(value = "/admin/updateHelpItem", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("helpItem") HelpItem helpItem, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "HelpController#edit(HelpItem helpItem)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"admin/helpItem"}, new Object[] {helpItem});

        try {
            helpService.update(helpItem);
            helpItem = helpService.get(helpItem.getId());

            ModelAndView model = new ModelAndView("service_admin_view_help_item");
            model.addObject("helpItem", helpItem);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will delete the entity with the given ID from the single view.
     *
     * @param helpItemId the entity ID
     * @param request the http servlet request
     * @return the successful text
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/deleteHelpItem"
     * @verb GET
     */
    @RequestMapping(value = "/admin/deleteHelpItem", method = RequestMethod.GET)
    @ResponseBody
    public String delete(@RequestParam("helpItemId") long helpItemId, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "HelpController#delete(long helpItemId)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"helpItemId"}, new Object[] {helpItemId});

        try {
            helpService.delete(helpItemId);
            return LogUtil.traceExit(getLog(), signature, "success");
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Getter of helpService.
     *
     * @return the helpService
     */
    public HelpService getHelpService() {
        return helpService;
    }

    /**
     * Set the helpService.
     *
     * @param helpService the helpService to set
     */
    public void setHelpService(HelpService helpService) {
        this.helpService = helpService;
    }
}
