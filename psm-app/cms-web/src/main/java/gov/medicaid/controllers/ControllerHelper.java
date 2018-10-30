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

package gov.medicaid.controllers;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.interceptors.FlashMessageInterceptor;
import gov.medicaid.security.CMSPrincipal;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Math.max;
import static java.lang.Math.min;

/**
 * Utility class for front end controllers.
 */
public class ControllerHelper {

    static final int MAX_PAGE_LINKS_TO_SHOW = 4;
    private static final int PREVIOUS_PAGES_TO_SHOW = 2;

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

    public static void addPaginationLinks(SearchResult<?> results, ModelAndView mv) {
        int pageNumber = results.getPageNumber();
        int totalPages = results.getTotalPages();

        mv.addObject("thereArePages", totalPages > 0);
        mv.addObject("currentPage", pageNumber);

        int firstPage = getFirstPage(pageNumber, totalPages);
        int lastPage = min(firstPage + MAX_PAGE_LINKS_TO_SHOW, totalPages);

        List<Integer> prevPages = new ArrayList<>();
        List<Integer> nextPages = new ArrayList<>();
        for (Integer i = firstPage; i <= lastPage; i++) {
            if (i < pageNumber) {
                prevPages.add(i);
            } else if (i > pageNumber) {
                nextPages.add(i);
            }
        }
        mv.addObject("prevPages", prevPages);
        mv.addObject("nextPages", nextPages);
    }

    public static void addPaginationDetails(SearchResult<?> results, ModelAndView mv) {
        int pageNumber = results.getPageNumber();
        int pageSize = results.getPageSize();
        int itemsOnPage = results.getTotalItems();
        int lastItemOfPreviousPage = (pageNumber - 1) * pageSize;

        mv.addObject(
                "pageStartItem",
                itemsOnPage == 0 ? 0 : lastItemOfPreviousPage + 1
        );
        mv.addObject(
                "pageEndItem",
                lastItemOfPreviousPage + itemsOnPage
        );
        mv.addObject(
                "pageSize" + String.valueOf(pageSize),
                true
        );
        mv.addObject(
                "totalItems",
                results.getTotal()
        );
    }

    private static int getFirstPage(int pageNumber, int totalPages) {
        int firstPage;
        if (nearEndOfPages(pageNumber, totalPages)) {
            firstPage = totalPages - MAX_PAGE_LINKS_TO_SHOW;
        } else {
            firstPage = pageNumber - PREVIOUS_PAGES_TO_SHOW;
        }
        return max(1, firstPage);
    }

    private static boolean nearEndOfPages(int pageNumber, int totalPages) {
        final int MAX_FIRST_PAGE = totalPages - MAX_PAGE_LINKS_TO_SHOW;
        return pageNumber > MAX_FIRST_PAGE;
    }
}
