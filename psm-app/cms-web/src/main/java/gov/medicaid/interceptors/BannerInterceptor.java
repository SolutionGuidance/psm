package gov.medicaid.interceptors;

import gov.medicaid.services.BannerService;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BannerInterceptor extends HandlerInterceptorAdapter {
    private final BannerService bannerService;

    public BannerInterceptor(BannerService bannerService) {
        this.bannerService = bannerService;
    }

    @Override
    public void postHandle(
        HttpServletRequest request,
        HttpServletResponse response,
        Object handler,
        ModelAndView modelAndView
    ) throws Exception {
        bannerService.getBannerTextForPage(
            request.getServletPath()
        ).ifPresent(bannerText ->
            modelAndView.addObject(
                "bannerText",
                bannerText
            )
        );
    }
}
