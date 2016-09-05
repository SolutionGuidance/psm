/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * Moves flash messages to request scope.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Controller
public class FlashMessageInterceptor implements HandlerInterceptor {

    /**
     * Attribute name for ERROR message.
     */
    public static final String FLASH_ERROR = "flash_error";

    /**
     * Attribute name for INFO message.
     */
    public static final String FLASH_INFO = "flash_info";

    /**
     * Attribute name for INFO message.
     */
    public static final String FLASH_POPUP = "flash_popup";


    /**
     * Empty constructor.
     */
    public FlashMessageInterceptor() {
    }

    /**
     * Moves session scoped flash message to request.
     *
     * @param request the current request
     * @param response not used
     * @param handler not used
     * @return true
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        Object attribute = request.getSession().getAttribute(FLASH_INFO);
        if (attribute != null) {
            request.setAttribute(FLASH_INFO, attribute);
            request.getSession().removeAttribute(FLASH_INFO);
        }

        attribute = request.getSession().getAttribute(FLASH_ERROR);
        if (attribute != null) {
            request.setAttribute(FLASH_ERROR, attribute);
            request.getSession().removeAttribute(FLASH_ERROR);
        }

        attribute = request.getSession().getAttribute(FLASH_POPUP);
        if (attribute != null) {
            request.setAttribute(FLASH_POPUP, attribute);
            request.getSession().removeAttribute(FLASH_POPUP);
        }

        return true;
    }

    /**
     * Empty implementation.
     *
     * @param request not used
     * @param response not used
     * @param handler not used
     * @param exception not used
     */
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
        Exception exception) {
    }

    /**
     * Empty implementation.
     *
     * @param request not used
     * @param response not used
     * @param handler not used
     * @param mv not used
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv) {
    }
}
