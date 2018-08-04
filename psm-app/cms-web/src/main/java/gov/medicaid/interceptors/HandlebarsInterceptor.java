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

package gov.medicaid.interceptors;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.security.CMSPrincipal;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import java.text.SimpleDateFormat;
import java.util.Locale;

import static gov.medicaid.entities.SystemId.CMS_ONLINE;

public class HandlebarsInterceptor extends HandlerInterceptorAdapter {
    @Override
    public void postHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler,
            ModelAndView modelAndView
    ) throws Exception {
        if (modelAndView == null ||
                modelAndView.getViewName().startsWith("redirect:")) {
            return;
        }

        addCommonVariables(request, modelAndView);
    }

    public static void addCommonVariables(
            @NotNull HttpServletRequest request,
            @NotNull ModelAndView modelAndView
    ) {
        // <c:set var="ctx" value="${pageContext.request.contextPath}"/>
        modelAndView.addObject("ctx", request.getContextPath());

        modelAndView.addObject("csrf", request.getAttribute("_csrf"));

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        if (principal != null) {
            CMSUser principalUser = principal.getUser();
            modelAndView.addObject("principalUser", principalUser);

            String roleDescription = principalUser.getRole().getDescription();

            // <c:if test="${requestPrincipal.user.role.description eq 'Service Administrator'}">
            if ("Service Administrator".equals(roleDescription)) {
                modelAndView.addObject(
                        "isServiceAdministrator",
                        true
                );
            } else if ("System Administrator".equals(roleDescription)) {
                modelAndView.addObject(
                        "isSystemAdministrator",
                        true
                );
            }

            if (CMS_ONLINE.equals(principal.getAuthenticatedBySystem())) {
                modelAndView.addObject(
                        "isInternalUser",
                        true
                );
            }

            // <sec:authentication property="principal.loginDate" var="loginDate"/>
            // <fmt:setLocale value="en_US" scope="session"/>
            // Last login: <fmt:formatDate value="${loginDate}" pattern="EEEE, d MMMM yyyy hh:mm:ss a zzz"/>
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "EEEE, d MMMM yyyy hh:mm:ss a zzz",
                    Locale.US
            );
            modelAndView.addObject(
                    "loginDate",
                    dateFormat.format(principal.getLoginDate())
            );
        }
    }
}
