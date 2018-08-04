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

package gov.medicaid.interceptors;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Moves flash messages to request scope.
 */
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
