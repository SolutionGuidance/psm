/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByNameCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.PodiatricMedicineLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for scraping Podiatric Medicine Licenses results.
 *
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(PodiatricMedicineLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PodiatricMedicineLicenseDAOBean extends BaseDAO implements PodiatricMedicineLicenseDAO {

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("licenseNumber", "licenseNumber");
            put("firstName", "profile.user.firstName");
            put("middleName", "profile.user.middleName");
            put("lastName", "profile.user.lastName");
        }
    };

    /**
     * Default empty constructor.
     */
    public PodiatricMedicineLicenseDAOBean() {
    }

    /**
     * Searches for Podiatric Medicine Licenses by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws IllegalArgumentException If criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws IllegalArgumentException If no name criteria is provided
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByName(PodiatricMedicineLicenseSearchByNameCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "PodiatricMedicineLicenseDAOBean#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getPageNumber() < 0 || (criteria.getPageNumber() > 0 && criteria.getPageSize() < 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }

        if (Util.isBlank(criteria.getLastName())) {
            throw new IllegalArgumentException(ErrorCode.MITA10001.getDesc());
        }

        return LogUtil.traceExit(getLog(), signature, doSearch(criteria, criteria.getLastName()));
    }

    /**
     * Searches for Podiatric Medicine Licenses by license number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws IllegalArgumentException If criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws IllegalArgumentException if no license criteria is provider
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByLicenseNumber(PodiatricMedicineLicenseSearchByLicenseNumberCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "PodiatricMedicineLicenseDAOBean#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getPageNumber() < 0 || (criteria.getPageNumber() > 0 && criteria.getPageSize() < 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }

        if (criteria.getLicenseNumber() <= 0) {
            throw new IllegalArgumentException(ErrorCode.MITA10004.getDesc());
        }

        return LogUtil.traceExit(getLog(), signature, doSearch(criteria, Long.toString(criteria.getLicenseNumber())));
    }

    /**
     * Performs the search.
     *
     * @param searchCriteria the search criteria
     * @param criteria the criteria to be used for searching
     * @return matched results
     * @throws ServiceException for any other exceptions encountered
     */
    private SearchResult<License> doSearch(SearchCriteria searchCriteria, String criteria) throws ServiceException {
        String signature = "PodiatricMedicineLicenseDAOBean#doSearch";

        validateSortOptions(searchCriteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria);
            SearchResult<License> results = trimResults(allResults, searchCriteria.getPageSize(),
                searchCriteria.getPageNumber(), SORT_COLUMNS.get(searchCriteria.getSortColumn()),
                searchCriteria.getSortOrder());
            logSearchEntry(searchCriteria);
            return results;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Retrieves all results from the source site.
     *
     * @param criteria the search criteria.
     * @return the providers matched
     * @throws URISyntaxException if the URL could not be correctly constructed
     * @throws IOException for any I/O related errors
     * @throws ServiceException for any other errors encountered
     */
    private SearchResult<License> getAllResults(String criteria) throws URISyntaxException, IOException,
        ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getFrontPage = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getFrontPage);

        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        HttpPost getSearchPage = new HttpPost(new URIBuilder(getSearchURL()).build());
        HttpEntity entity = postForm(
            getSearchURL(),
            client,
            getSearchPage,
            new String[][]{{"_ctl2:dropAgencyCode", "H7Q"}, {"_ctl2:btnLogin", "Login"},
                {"__VIEWSTATE", page.select("#__aspnetForm input[name=__VIEWSTATE]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        HttpPost search = new HttpPost(new URIBuilder(getSearchURL()).build());
        entity = postForm(getSearchURL(), client, search, new String[][]{{"_ctl2:txtCriteria", criteria},
            {"_ctl2:btnSearch", "Search"},
            {"__VIEWSTATE", page.select("#__aspnetForm input[name=__VIEWSTATE]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        List<License> allLicenses = new ArrayList<License>();
        Elements rows = page.select("table#_ctl2_dgrdResults tr.DataGrid");
        for (Element row : rows) {
            License license = parseLicense(row.children());
            if (license != null) {
                allLicenses.add(license);
            }
        }
        SearchResult<License> results = new SearchResult<License>();
        results.setItems(allLicenses);
        return results;
    }

    /**
     * Parse the License information.
     *
     * @param tds The elements
     * @return parsed license
     */
    private License parseLicense(Elements tds) {
        String licenseNumber = tds.get(1).text();
        String name = tds.get(2).text().trim();
        if (licenseNumber.trim().length() == 0 || "No verifications found".equals(name)) {
            return null;
        }

        License license = new License();
        license.setLicenseNumber(licenseNumber);
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        User user = parsePersonName(name);
        profile.setUser(user);

        return license;
    }
}
