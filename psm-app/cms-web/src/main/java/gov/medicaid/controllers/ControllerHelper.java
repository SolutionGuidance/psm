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
package gov.medicaid.controllers;

import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.security.CMSPrincipal;

import org.springframework.web.servlet.ModelAndView;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Utility class for front end controllers.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ControllerHelper {

    /**
     * Private constructor.
     */
    private ControllerHelper() {
    }

    /**
     * Returns the current user.
     *
     * @return the current user.
     */
    public static CMSUser getCurrentUser() {
        CMSPrincipal principal = getPrincipal();
        CMSUser user = principal.getUser();
        return user;
    }

    /**
     * Retrieves the current principal.
     * @return the current request principal
     */
    public static CMSPrincipal getPrincipal() {
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        CMSPrincipal principal = (CMSPrincipal) authentication.getPrincipal();
        return principal;
    }

    /**
     * Adds a flash info message to the session.
     * @param message the message to be added
     */
    public static void flashInfo(String message) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        session.setAttribute(FlashMessageInterceptor.FLASH_INFO, message);
    }

    /**
     * Popups the given element after the next get.
     *
     * @param popupId the element to be shown
     */
    public static void flashPopup(String popupId) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        session.setAttribute(FlashMessageInterceptor.FLASH_POPUP, popupId);
    }

    /**
     * Popups the given element upon rendering.
     *
     * @param popupId the element to be shown
     */
    public static void popup(String popupId) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        attr.getRequest().setAttribute(FlashMessageInterceptor.FLASH_POPUP, popupId);
    }


    /**
     * Adds a flash error message to the session.
     * @param message the message to be added
     */
    public static void flashError(String message) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        session.setAttribute(FlashMessageInterceptor.FLASH_ERROR, message);
    }

    /**
     * Adds a flash error message to the session.
     * @param message the message to be added
     */
    public static void addError(String message) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        attr.getRequest().setAttribute(FlashMessageInterceptor.FLASH_ERROR, message);
    }

    /**
     * Adds request and application context info to model
     * @param model to add extra information
     */
    public static void addContextInfoToModel(ModelAndView model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();

        // <c:set var="ctx" value="${pageContext.request.contextPath}"/>
        model.addObject("ctx", attr.getRequest().getContextPath());

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        if (principal != null) {
            CMSUser principalUser = principal.getUser();
            model.addObject("principalUser", principalUser);

            // <c:if test="${requestPrincipal.user.role.description eq 'Service Administrator'}">
            if (principalUser.getRole().getDescription() == "Service Administrator") {
                model.addObject("isServiceAdministrator", true);
            }

            // <sec:authentication property="principal.loginDate" var="loginDate"/>
            // <fmt:setLocale value="en_US" scope="session"/>
            // Last login: <fmt:formatDate value="${loginDate}" pattern="EEEE, d MMMM yyyy hh:mm:ss a zzz"/>
            SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, d MMMM yyyy hh:mm:ss a zzz", Locale.US);
            model.addObject("loginDate", dateFormat.format(principal.getLoginDate()));

            // TODO for provider/profile/list template of MyProfileController
            // <sec:authentication property="principal.authenticatedBySystem" var="authenticatedBySystem"/>
            // <sec:authentication property="principal" var="requestPrincipal"/>
            // <spring:eval expression="authenticatedBySystem == T(gov.medicaid.entities.SystemId).CMS_ONLINE" var="isInternalUser" />
            // if (principal.authenticatedBySystem == gov.medicaid.entities.SystemId.CMS_ONLINE) model.addObject("isInternalUser", true);
        }
    }
}
