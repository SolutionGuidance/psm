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
