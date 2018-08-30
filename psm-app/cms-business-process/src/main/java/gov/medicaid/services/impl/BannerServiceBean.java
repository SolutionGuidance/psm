package gov.medicaid.services.impl;

import gov.medicaid.entities.BannerText;
import gov.medicaid.services.BannerService;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Optional;

@Stateless
public class BannerServiceBean implements BannerService {
    @PersistenceContext(unitName = "cms")
    private EntityManager em;

    @Override
    public Optional<String> getBannerTextForPage(String servletPath) {
        return Optional.ofNullable(
            em.find(BannerText.class, servletPath)
        ).map(BannerText::getPageText);
    }
}
