/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.NursingLicenseSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.Sex;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.NursingLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
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
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
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
 * This defines the logic for searching for Nursing Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(NursingLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NursingLicenseDAOBean extends BaseDAO implements NursingLicenseDAO {

    /**
     * Represents all matching rows to parse.
     */
    private static final String GRID_ROW_SELECTOR = "#_ctl7_grdSearchResults tr.TableItem, "
        + "#_ctl7_grdSearchResults tr.TableAlternatingItem";

    /**
     * Default empty constructor.
     */
    public NursingLicenseDAOBean() {
    }

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        /**
         * Generated serial version UID.
         */
        private static final long serialVersionUID = 8177400373999035841L;

        {
            put("firstName", "profile.user.firstName");
            put("middleName", "profile.user.middleName");
            put("lastName", "profile.user.lastName");
            put("type", "type.name");
            put("originalIssueDate", "originalIssueDate");
            put("dateOfBirth", "profile.dob");
            put("licenseNumber", "licenseNumber");
        }
    };

    /**
     * The supported license type mappings for this source.
     */
    private static final Map<String, String> TYPES = new HashMap<String, String>() {
        /**
         * Generated serial version UID.
         */
        private static final long serialVersionUID = -4695890753077346179L;

        {
            put("R", "RN");
            put("L", "LPN");
        }
    };

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "MM-dd-yyyy";

    /**
     * Searches for providers with Medical Practice license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByName(NursingLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "NursingLicenseDataAccessImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getFirstName())) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria, true);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ClientProtocolException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (URISyntaxException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (ParseException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Searches for providers with Nursing license using the identifier filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByLicenseNumber(NursingLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "NursingLicenseDataAccessImpl#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getLicenseType() == null || Util.isBlank(criteria.getLicenseType().getName())) {
            throw new ServiceException(ErrorCode.MITA10008.getDesc());
        }

        // transform the license type mapping
        boolean found = false;
        for (Map.Entry<String, String> type : TYPES.entrySet()) {
            if (type.getValue().equals(criteria.getLicenseType().getName())) {
                criteria.getLicenseType().setName(type.getKey());
                found = true;
            }
        }
        if (!found) {
            throw new ServiceException(ErrorCode.MITA10009.getDesc());
        }

        if (Util.isBlank(criteria.getIdentifier())) {
            throw new ServiceException(ErrorCode.MITA10004.getDesc());
        }

        if (!Util.isDigits(criteria.getIdentifier())) {
            throw new ServiceException(ErrorCode.MITA10010.getDesc());
        }

        if (Util.isBlank(criteria.getCheckDigit())) {
            throw new ServiceException(ErrorCode.MITA10011.getDesc());
        }

        if (!Util.isDigits(criteria.getCheckDigit())) {
            throw new ServiceException(ErrorCode.MITA10012.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria, false);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ClientProtocolException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (URISyntaxException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (ParseException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Performs a search for all possible results.
     *
     * @param criteria The search criteria.
     * @param byName flag indicating it is a name search
     * @return the search result for licenses
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ParseException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<License> getAllResults(NursingLicenseSearchCriteria criteria, boolean byName)
        throws URISyntaxException, ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());
        client.setCookieStore(loginAsPublicUser());

        HttpGet getSearch = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getSearch);
        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        HttpPost search = new HttpPost(new URIBuilder(getSearchURL()).build());

        List<License> allLicenses = new ArrayList<License>();

        // switch to search by name screen
        if (byName) {
            HttpEntity entity = postForm(getSearchURL(), client, search, new String[][]{
                {"__EVENTTARGET", "_ctl7_rbtnSearch_1"}, {"__EVENTARGUMENT", ""}, {"_ctl7:ddlbLicenseType", "R"},
                {"_ctl7:rbtnSearch", "2"}, {"_ctl7:txtCheckDigit", ""}, {"_ctl7:txtLicenseNumber", ""},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);

            page = Jsoup.parse(EntityUtils.toString(entity));
            entity = getResultPage(criteria, client, page, search, "_ctl7:cmdSearch", getSearchURL());
            page = Jsoup.parse(EntityUtils.toString(entity));

            // get the data grid entries
            if (page.select("table#_ctl7_grdSearchResults").size() < 1) {
                throw new ParsingException(ErrorCode.MITA50002.getDesc());
            }

            Elements rows = page.select(GRID_ROW_SELECTOR);
            while (rows.size() > 0) {
                for (Element row : rows) {
                    String url = row.select("a").first().attr("href");
                    String licenseNo = row.select("td:eq(4)").text();
                    HttpGet getDetail = new HttpGet(Util.replaceLastURLPart(getSearchURL(), url));
                    response = client.execute(getDetail);
                    verifyAndAuditCall(getSearchURL(), response);
                    Document licenseDetails = Jsoup.parse(EntityUtils.toString(response.getEntity()));
                    allLicenses.add(parseLicense(licenseDetails, licenseNo.substring(0, 1)));
                }
                rows.clear();

                // check for next page
                Element currentPage = page.select("#_ctl7_grdSearchResults tr.TablePager span").first();
                if (getLog() != null) {
                    getLog().log(Level.DEBUG, "Current page is: " + currentPage.text());
                }
                Element pageLink = currentPage.nextElementSibling();
                if (pageLink != null && pageLink.hasAttr("href")) {
                    if (getLog() != null) {
                        getLog().log(Level.DEBUG, "There are more results, getting the next page.");
                    }

                    String target = parseEventTarget(pageLink.attr("href"));
                    entity = getResultPage(criteria, client, page, search, target, getSearchURL());
                    page = Jsoup.parse(EntityUtils.toString(entity));
                    rows = page.select(GRID_ROW_SELECTOR);
                }
            }

        } else { // search by license number (site supports only exact match)

            HttpEntity entity = postForm(getSearchURL(), client, search,
                new String[][]{{"__EVENTTARGET", "_ctl7:cmdSearch"}, {"__EVENTARGUMENT", ""},
                    {"_ctl7:ddlbLicenseType", Util.defaultString(criteria.getLicenseType().getName())},
                    {"_ctl7:rbtnSearch", "1"}, {"_ctl7:txtCheckDigit", Util.defaultString(criteria.getCheckDigit())},
                    {"_ctl7:txtLicenseNumber", Util.defaultString(criteria.getIdentifier())},
                    {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);

            page = Jsoup.parse(EntityUtils.toString(entity));
            if (page.select("span#lblFormTitle").text().equals("License Details")) {
                String prefLicenseType = criteria.getLicenseType().getName();
                allLicenses.add(parseLicense(page, prefLicenseType));
            }
        }

        SearchResult<License> searchResult = new SearchResult<License>();
        searchResult.setItems(allLicenses);
        return searchResult;
    }

    /**
     * Parses the nursing license details page.
     *
     * @param page the details page
     * @param licenseType if user has multiple licenses, this one will be used
     * @return the parsed license details
     * @throws ParsingException if the page does not contain the expected elements
     */
    private License parseLicense(Document page, String licenseType) throws ParsingException {
        if (!page.select("span#lblFormTitle").text().equals("License Details")) {
            throw new ParsingException(ErrorCode.MITA50002.getDesc());
        }

        License license = new License();
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        String fullName = page.select("#_ctl7_lblName").text();

        User user = new User();
        profile.setUser(user);
        String[] nameParts = fullName.split(" ");
        user.setLastName(nameParts[nameParts.length - 1]);
        if (nameParts.length > 1) {
            user.setFirstName(nameParts[0]);
        }
        // everything else goes to middle name (per site behavior)
        if (nameParts.length > 2) {
            StringBuffer sb = new StringBuffer();
            for (int i = 1; i < nameParts.length - 1; i++) {
                if (sb.length() > 0) {
                    sb.append(" ");
                }
                sb.append(nameParts[i]);
            }
            user.setMiddleName(sb.toString());
        }

        String dateOfBirth = page.select("#_ctl7_lblDOB").text();
        if (Util.isNotBlank(dateOfBirth)) {
            profile.setDob(parseDate(dateOfBirth, DATE_FORMAT));
        }

        String gender = page.select("#_ctl7_lblGender").text();
        if (Util.isNotBlank(gender)) {
            if ("Female".equals(gender)) {
                profile.setSex(Sex.FEMALE);
            } else {
                profile.setSex(Sex.MALE);
            }
        }

        Elements licenses = page.select("#_ctl7_dgLicense tr.Normal");
        for (Element row : licenses) {
            String licenseNumber = row.select("td:eq(0)").text();
            if (licenseType != null && !licenseNumber.startsWith(licenseType)) {
                // user has multiple licenses, the results will show this user twice (search by name)
                continue;
            }

            String[] licenseParts = licenseNumber.split(" ");
            LicenseType type = new LicenseType();
            type.setName(TYPES.get(licenseParts[0]) == null ? licenseParts[0] : TYPES.get(licenseParts[0]));
            license.setType(type);
            license.setLicenseNumber(licenseParts[1]);

            String issueDate = row.select("td:eq(1)").text();
            if (Util.isNotBlank(issueDate)) {
                license.setOriginalIssueDate(parseDate(issueDate, DATE_FORMAT));
            }

            String expirationDate = row.select("td:eq(2)").text();
            if (Util.isNotBlank(expirationDate)) {
                license.setExpireDate(parseDate(expirationDate, DATE_FORMAT));
            }
        }
        return license;
    }

    /**
     * This method performs login to the configured site.
     *
     * @return the cookies generated by the login process
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private CookieStore loginAsPublicUser() throws URISyntaxException, ClientProtocolException, IOException,
        ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());

        String loginSite = getLoginURL();
        HttpGet getLogin = new HttpGet(new URIBuilder(loginSite).build());
        HttpResponse response = client.execute(getLogin);
        verifyAndAuditCall(loginSite, response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        // select public user
        HttpPost login = new HttpPost(new URIBuilder(loginSite).build());
        HttpEntity entity = postForm(loginSite, client, login, new String[][]{{"__EVENTTARGET", "_ctl0_rblUserType_2"},
            {"__EVENTARGUMENT", ""}, {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        // enter credentials
        entity = postForm(loginSite, client, login,
            new String[][]{{"__EVENTTARGET", ""}, {"__EVENTARGUMENT", ""}, {"_ctl0:cmdLogin", "Log In"},
                {"_ctl0:rblUserType", "14"}, {"_ctl0:txtEMailAddress", getUsername()},
                {"_ctl0:txtPassword", getPassword()},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        // check that the user was actually logged in
        if (page.select("a#Banner_hlLogoff").size() == 0) {
            throw new ServiceException(ErrorCode.MITA50003.getDesc());
        }
        return client.getCookieStore();
    }

    /**
     * Retrieves the result page for the name query (paginated).
     *
     * @param criteria the search criteria
     * @param client the HTTP client
     * @param page the current page
     * @param search the search URL
     * @param target the paging command
     * @param searchURL the search URL
     * @return the page with the requested paginated results
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private HttpEntity getResultPage(SearchCriteria criteria, DefaultHttpClient client, Document page, HttpPost search,
        String target, String searchURL) throws IOException, ServiceException {
        HttpEntity entity;
        entity = postForm(
            searchURL,
            client,
            search,
            new String[][]{{"__EVENTTARGET", target}, {"__EVENTARGUMENT", ""}, {"_ctl7:rbtnSearch", "2"},
                {"_ctl7:txtFirstName", Util.defaultString(criteria.getFirstName())},
                {"_ctl7:txtLastName", Util.defaultString(criteria.getLastName())},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);
        return entity;
    }
}