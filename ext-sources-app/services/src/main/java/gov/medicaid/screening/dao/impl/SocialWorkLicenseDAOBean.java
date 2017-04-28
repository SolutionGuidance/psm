/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseLevel;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SocialWorkCriteria;
import gov.medicaid.entities.SocialWorkLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.SocialWorkLicenseSearchByNameCriteria;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.SocialWorkLicenseDAO;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

import com.topcoder.util.log.Level;

/**
 * This defines the logic for scraping Social Work Licenses results.
 *
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(SocialWorkLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class SocialWorkLicenseDAOBean extends BaseDAO implements SocialWorkLicenseDAO {

    /**
     * The date format used by this source.
     */
    private static final String DATE_FORMAT = "MM-dd-yyyy";

    /**
     * The css selector for search results.
     */
    private static final String RESULT_ROWS_SELECTOR = "table#_ctl7_grdSearchResults tr.TableItem, "
        + "table#_ctl7_grdSearchResults tr.TableAlternatingItem";

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
    public SocialWorkLicenseDAOBean() {
    }

    /**
     * This method gets the applicable licenses that meet the search criteria, which only focuses on the name of the
     * licensee. If none available, the search result will be empty..
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByName(SocialWorkLicenseSearchByNameCriteria criteria) throws ServiceException {
        String signature = "SocialWorkLicenseDAOBean#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getPageNumber() < 0 || (criteria.getPageNumber() > 0 && criteria.getPageSize() < 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }

        if (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getFirstName())) {
            throw new IllegalArgumentException(ErrorCode.MITA10022.getDesc());
        }

        return LogUtil.traceExit(getLog(), signature, doSearch(criteria));
    }

    /**
     * Searches for Podiatric Medicine Licenses by license number.
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByLicenseNumber(SocialWorkLicenseSearchByLicenseNumberCriteria criteria)
        throws ServiceException {
        String signature = "SocialWorkLicenseDAOBean#searchByLicenseNumber";
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

        return LogUtil.traceExit(getLog(), signature, doSearch(criteria));
    }

    /**
     * Performs the search.
     *
     * @param searchCriteria the search criteria
     * @return matched results
     * @throws ServiceException for any other exceptions encountered
     */
    private SearchResult<License> doSearch(SocialWorkCriteria searchCriteria) throws ServiceException {
        String signature = "PodiatricMedicineLicenseDAOBean#doSearch";

        validateSortOptions(searchCriteria, SORT_COLUMNS);
        try {
            SearchResult<License> allResults = getAllResults(searchCriteria);
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
     * @param searchCriteria the search criteria.
     * @return the providers matched
     * @throws URISyntaxException if the URL could not be correctly constructed
     * @throws IOException for any I/O related errors
     * @throws ServiceException for any other errors encountered
     */
    private SearchResult<License> getAllResults(SocialWorkCriteria searchCriteria) throws URISyntaxException,
        IOException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getSearchPage = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getSearchPage);
        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        String licenseNo = "";
        if (searchCriteria instanceof SocialWorkLicenseSearchByLicenseNumberCriteria) {
            licenseNo = "" + ((SocialWorkLicenseSearchByLicenseNumberCriteria) searchCriteria).getLicenseNumber();
        }
        String level = "none";
        if (searchCriteria.getLevel() != null) {
            level = Util.defaultString(searchCriteria.getLevel().getName());
        }

        HttpPost search = new HttpPost(new URIBuilder(getSearchURL()).build());
        HttpEntity entity = postForm(getSearchURL(), client, search,
            buildParams(searchCriteria, page, licenseNo, level, null), true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        List<License> allLicenses = new ArrayList<License>();
        // check if detail page (single match)
        if (page.select("#lblFormTitle").text().equals("License Details")) {
            allLicenses.add(parseLicenseDetail(page));
        } else {

            Elements rows = page.select(RESULT_ROWS_SELECTOR);
            while (rows.size() > 0) {
                for (Element row : rows) {
                    License license = parseLicense(row.children());
                    if (license != null) {
                        allLicenses.add(license);
                    }
                }
                rows.clear();

                // check for next page
                Element currentPage = page.select("#_ctl7_grdSearchResults tr.TablePager span").first();
                getLog().log(Level.DEBUG, "Current page is: " + currentPage.text());
                Element pageLink = currentPage.nextElementSibling();
                if (pageLink != null && pageLink.hasAttr("href")) {
                    getLog().log(Level.DEBUG, "There are more results, getting the next page.");

                    String target = parseEventTarget(pageLink.attr("href"));
                    entity = postForm(getSearchURL(), client, search,
                        buildParams(searchCriteria, page, licenseNo, level, target), true);
                    page = Jsoup.parse(EntityUtils.toString(entity));
                    rows = page.select(RESULT_ROWS_SELECTOR);
                }
            }
        }

        SearchResult<License> results = new SearchResult<License>();
        results.setItems(allLicenses);
        return results;
    }

    /**
     * Builds the query parameters for the search, page navigation.
     *
     * @param searchCriteria the search criteria
     * @param page the current page
     * @param licenseNo the license filter
     * @param level the level filter
     * @param target the target event
     * @return the parameters for the paginated search
     */
    private String[][] buildParams(SocialWorkCriteria searchCriteria, Document page, String licenseNo, String level,
        String target) {
        List<String[]> params = new ArrayList<String[]>();
        params.add(new String[]{"__EVENTARGUMENT", ""});
        params.add(new String[]{"__EVENTTARGET", Util.defaultString(target)});
        if (Util.isBlank(target)) {
            params.add(new String[]{"_ctl7:cmdSearch", "Search"});
        }
        params.add(new String[]{"_ctl7:ddlbLicenseType", level});
        params.add(new String[]{"_ctl7:txtCity", Util.defaultString(searchCriteria.getCity())});
        params.add(new String[]{"_ctl7:txtCounty", Util.defaultString(searchCriteria.getCounty())});
        params.add(new String[]{"_ctl7:txtFirstName", Util.defaultString(searchCriteria.getFirstName())});
        params.add(new String[]{"_ctl7:txtLastName", Util.defaultString(searchCriteria.getLastName())});
        params.add(new String[]{"_ctl7:txtLicenseNumber", licenseNo});
        params.add(new String[]{"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()});
        return (String[][]) params.toArray(new String[params.size()][0]);
    }

    /**
     * Parses the event target for the JavaScript post back command.
     *
     * @param postBackJS the JavaScript command
     * @return the event target
     * @throws ParsingException if the event target was not found.
     */
    protected String parseEventTarget(String postBackJS) throws ParsingException {
        Pattern pattern = Pattern.compile(".*'(_.*)',");
        Matcher matcher = pattern.matcher(postBackJS);
        boolean matchFound = matcher.find();
        if (matchFound) {
            return matcher.group(1).replaceAll("\\$", ":");
        } else {
            throw new ParsingException(ErrorCode.MITA50002.getDesc());
        }
    }

    /**
     * Parse the License information from the search grid results.
     *
     * @param tds The elements
     * @return parsed license
     */
    private License parseLicense(Elements tds) {
        License license = new License();
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        String name = tds.get(1).text().trim();
        profile.setUser(parsePersonName(name));

        String licenseNumber = tds.get(2).text();
        license.setLicenseNumber(licenseNumber);

        String licenseLevel = tds.get(3).text();
        if (Util.isNotBlank(licenseLevel)) {
            LicenseLevel level = new LicenseLevel();
            level.setName(licenseLevel);
            license.setLevel(level);
        }

        String city = tds.get(4).text();
        license.setCity(city);

        String licenseStatus = tds.get(6).text();
        if (Util.isNotBlank(licenseStatus)) {
            LicenseStatus status = new LicenseStatus();
            status.setName(licenseStatus);
            license.setStatus(status);
        }
        return license;
    }

    /**
     * When there is exactly one match, the details page is displayed instead of the grid. This parses the details from
     * that page.
     *
     * @param page the license details page
     * @return the parsed license
     */
    private License parseLicenseDetail(Document page) {
        License license = new License();
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        String name = page.select("#_ctl7_lblName").text();

        profile.setUser(parsePersonDetailName(name));

        String licenseNumber = page.select("#_ctl7_lblLicNumber").text();
        license.setLicenseNumber(licenseNumber);

        String licenseLevel = page.select("#_ctl7_lblLicLevel").text();
        if (Util.isNotBlank(licenseLevel)) {
            LicenseLevel level = new LicenseLevel();
            level.setName(licenseLevel);
            license.setLevel(level);
        }

        String city = page.select("#_ctl7_lblWorkCity").text();
        license.setCity(city);

        String licenseStatus = page.select("#_ctl7_lblLicStatus").text();
        if (Util.isNotBlank(licenseStatus)) {
            LicenseStatus status = new LicenseStatus();
            status.setName(licenseStatus);
            license.setStatus(status);
        }

        // per reviewer include originalIssueDate,expireDate,correctiveAction,discipline
        String issueDate = page.select("#_ctl7_lblIssueDate").text();
        if (Util.isNotBlank(issueDate)) {
            license.setOriginalIssueDate(parseDate(issueDate, DATE_FORMAT));
        }

        String expireDate = page.select("#_ctl7_lblExpDate").text();
        if (Util.isNotBlank(expireDate)) {
            license.setExpireDate(parseDate(expireDate, DATE_FORMAT));
        }

        String correctiveAction = page.select("#_ctl7_lblCorrectiveAction").text();
        if (Util.isNotBlank(correctiveAction)) {
            license.setCorrectiveAction(!"No".equals(correctiveAction));
        }

        String disciplineAction = page.select("#_ctl7_lblDisciplineAction").text();
        if (Util.isNotBlank(disciplineAction)) {
            license.setDiscipline(!"No".equals(disciplineAction));
        }
        return license;
    }

    /**
     * Parses the provider name from the person detail format.
     *
     * @param name the full name
     * @return the parsed provider name
     */
    private User parsePersonDetailName(String name) {
        User user = new User();
        String[] nameParts = name.split(" ");
        if (nameParts.length > 0) {
            user.setLastName(nameParts[nameParts.length - 1].trim());
        }

        if (nameParts.length > 1) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < nameParts.length - 1; i++) {
                String string = nameParts[i];
                if (nameParts.length > 2 && i == nameParts.length - 2) {
                    // if there are more than 2 names, the second to the last is middle name
                    user.setMiddleName(string);
                } else {
                    if (sb.length() > 0) {
                        sb.append(" ");
                    }
                    sb.append(string);
                }
            }
            user.setFirstName(sb.toString());
        }
        return user;
    }
}
