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
import gov.medicaid.interceptors.FlashMessageInterceptor;
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
        Object principal = authentication.getPrincipal();
        if (principal instanceof CMSPrincipal) {
            return (CMSPrincipal) principal;
        } else {
            return null;
        }
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
}
