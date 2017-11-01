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

            // <c:if test="${requestPrincipal.user.role.description eq 'Service Administrator'}">
            if ("Service Administrator".equals(principalUser.getRole().getDescription())) {
                modelAndView.addObject(
                        "isServiceAdministrator",
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

            // TODO for provider/profile/list template of MyProfileController
            // <sec:authentication property="principal.authenticatedBySystem" var="authenticatedBySystem"/>
            // <sec:authentication property="principal" var="requestPrincipal"/>
            // <spring:eval expression="authenticatedBySystem == T(gov.medicaid.entities.SystemId).CMS_ONLINE" var="isInternalUser" />
            // if (principal.authenticatedBySystem == gov.medicaid.entities.SystemId.CMS_ONLINE) model.addObject("isInternalUser", true);
        }
    }
}
