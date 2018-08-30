package gov.medicaid.services;

import java.util.Optional;

public interface BannerService {
    Optional<String> getBannerTextForPage(String servletPath);
}
