/*
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

import gov.medicaid.interceptors.HandlebarsInterceptor;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.logging.Level;
import java.util.logging.Logger;

@ControllerAdvice
public class ErrorController {
    private final Logger logger = Logger.getLogger(getClass().getName());

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(
            HttpServletRequest request,
            Exception ex
    ) {
        logger.log(Level.SEVERE, ex, () -> String.format(
                "Exception caught by Spring while handling %s request to %s",
                request.getMethod(),
                request.getRequestURL().toString()
        ));

        ModelAndView view = new ModelAndView("error");
        view.addObject("exception", ExceptionUtils.getStackTrace(ex));
        HandlebarsInterceptor.addCommonVariables(request, view);
        return view;
    }
}
