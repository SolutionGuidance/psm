/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.ChiropracticLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.Sex;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.ChiropracticLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for searching for Chiropractic Licenses.
 * 
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(ChiropracticLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ChiropracticLicenseDAOBean extends BaseDAO implements ChiropracticLicenseDAO {

    /**
     * Host used for denied list.
     */
    @Resource(name = "mita/config/disciplineURL")
    private String disciplineURL;

    /**
     * Default empty constructor.
     */
    public ChiropracticLicenseDAOBean() {
    }

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "profile.user.firstName");
            put("middleName", "profile.user.middleName");
            put("lastName", "profile.user.lastName");
            put("type", "type.name");
            put("originalIssueDate", "originalIssueDate");
            put("expireDate", "expireDate");
            put("renewalDate", "renewalDate");
            put("licenseNumber", "licenseNumber");
        }
    };

    /**
     * The supported license type mappings for this source.
     */
    private static final Map<String, String> TYPES = new HashMap<String, String>() {
        {
            put("byLname", "Search By Name");
            put("bySoundex", "   Sounding Like   ");
            put("byCity", "   Search By City  ");
            put("byZIP", "   Search By ZIP   ");
        }
    };

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "M/d/yy";

    /**
     * Searches for providers with Chiropractic license using the name filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<License> searchByLastName(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseDataAccessImpl#searchByLastName";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getLastName())) {
            throw new ServiceException(ErrorCode.MITA10001.getDesc());
        }

        SearchResult<License> results = search(criteria, "byLname");
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Searches for providers with Chiropractic license using the city filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<License> searchByCity(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseDataAccessImpl#searchByCity";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getCity())) {
            throw new ServiceException(ErrorCode.MITA10013.getDesc());
        }

        SearchResult<License> results = search(criteria, "byCity");
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Searches for providers with Chiropractic license using the zipcode filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<License> searchByZipCode(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseDataAccessImpl#searchByZipCode";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getZipCode())) {
            throw new ServiceException(ErrorCode.MITA10014.getDesc());
        }

        SearchResult<License> results = search(criteria, "byZIP");
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Searches for providers with Chiropractic license using the sounds like name filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<License> searchBySoundingLikeLastName(ChiropracticLicenseSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = "ChiropracticLicenseDataAccessImpl#searchBySoundingLikeLastName";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getLastName())) {
            throw new ServiceException(ErrorCode.MITA10001.getDesc());
        }

        SearchResult<License> results = search(criteria, "bySoundex");
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Retrieves all licensees that have disciplinary action record from the source site.
     * 
     * @param criteria
     *            the pagination criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<License> getDeniedList(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {

        if (criteria == null) {
            // pagination info should be included
            throw new ServiceException(ErrorCode.MITA10002.getDesc());
        }

        try {
            SearchResult<License> allResults = getAllDisciplinedResults();
            trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(), null, null);
            return allResults;
        } catch (ClientProtocolException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (URISyntaxException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (IOException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (ParseException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        }
    }

    /**
     * Executes the search of the given type.
     * 
     * @param criteria
     *            the search criteria
     * @param type
     *            the search type
     * @return the search results
     * @throws PersistenceException
     *             if any data access
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    private SearchResult<License> search(ChiropracticLicenseSearchCriteria criteria, String type)
            throws ParsingException, ServiceException, PersistenceException {

        validateSortOptions(criteria, SORT_COLUMNS);

        try {

            SearchResult<License> allResults = getAllResults(criteria, type);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                    SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

            logSearchEntry(criteria);
            return results;
        } catch (ClientProtocolException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (URISyntaxException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (ParseException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Performs a search for all possible results.
     * 
     * @param criteria
     *            The search criteria.
     * @param searchType
     *            the type of search to execute.
     * @return the search result for licenses
     * 
     * @throws URISyntaxException
     *             if an error occurs while building the URL.
     * @throws ClientProtocolException
     *             if client does not support protocol used.
     * @throws IOException
     *             if an error occurs while parsing response.
     * @throws ParseException
     *             if an error occurs while parsing response.
     * @throws ServiceException
     *             for any other problems encountered
     */
    private SearchResult<License> getAllResults(ChiropracticLicenseSearchCriteria criteria, String searchType)
            throws URISyntaxException, ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        URIBuilder uriBuilder = new URIBuilder(getSearchURL());
        uriBuilder.addParameter("strName", Util.defaultString(criteria.getLastName()));
        uriBuilder.addParameter("strSoundex", Util.defaultString(criteria.getLastName()));
        uriBuilder.addParameter("strCity", Util.defaultString(criteria.getCity()));
        uriBuilder.addParameter("strZIP", Util.defaultString(criteria.getZipCode()));
        uriBuilder.addParameter(searchType, TYPES.get(searchType));

        HttpGet search = new HttpGet(uriBuilder.build());
        HttpResponse response = client.execute(search);
        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        List<License> allLicenses = new ArrayList<License>();

        Elements rows = page.select("tr:gt(0)");
        for (Element row : rows) {
            String href = row.select("a").first().attr("href"); // detail link
            String licenseType = row.select("td:eq(2)").text();

            HttpGet getDetails = new HttpGet(Util.replaceLastURLPart(uriBuilder.build().toString(), href));
            response = client.execute(getDetails);
            verifyAndAuditCall(getSearchURL(), response);

            page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
            allLicenses.add(parseLicense(page, licenseType));
        }

        SearchResult<License> searchResult = new SearchResult<License>();
        searchResult.setItems(allLicenses);
        return searchResult;
    }

    /**
     * Retrieves all the practioners from the disciplined list.
     * 
     * @return the list of practitioners in the disciplined list
     * 
     * @throws URISyntaxException
     *             if an error occurs while building the URL.
     * @throws ClientProtocolException
     *             if client does not support protocol used.
     * @throws IOException
     *             if an error occurs while parsing response.
     * @throws ParseException
     *             if an error occurs while parsing response.
     * @throws ServiceException
     *             for any other problems encountered
     */
    private SearchResult<License> getAllDisciplinedResults() throws URISyntaxException, ClientProtocolException,
            IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet search = new HttpGet(new URIBuilder(getDisciplineURL()).build());
        HttpResponse response = client.execute(search);
        verifyAndAuditCall(getDisciplineURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        List<License> allLicenses = new ArrayList<License>();

        Elements rows = page.select("blockquote table tr:gt(0)");
        for (Element row : rows) {
            String fullname = row.select("td:eq(0)").text();
            License license = new License();
            ProviderProfile profile = new ProviderProfile();
            license.setProfile(profile);
            profile.setUser(parseDeniedListFullname(fullname));
            LicenseStatus status = new LicenseStatus();
            String action = row.select("td:eq(1)").text();
            status.setName(action);
            String date = row.select("td:eq(2)").text();
            status.setDate(parseDate(date, DATE_FORMAT));
            license.setStatus(status);
            allLicenses.add(license);
        }

        SearchResult<License> searchResult = new SearchResult<License>();
        searchResult.setItems(allLicenses);
        return searchResult;
    }

    /**
     * This parses the given fullname with specific rules to the denied list.
     * 
     * @param fullname
     *            the fullname to parse
     * @return the person name entity.
     */
    private static User parseDeniedListFullname(String fullname) {
        User user = new User();
        fullname = fullname.replaceAll("\\(.*\\)", ""); // remove extra comments
        String[] nameParts = fullname.split(",");
        if (nameParts.length > 0) {
            user.setLastName(nameParts[0].trim());
        }
        if (nameParts.length > 1) {
            String firstName = nameParts[1].trim();
            String[] firstNameParts = firstName.split(" ");
            StringBuilder sb = new StringBuilder();
            for (String string : firstNameParts) {
                if (string.endsWith(".")) {
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

    /**
     * Parses the Chiropractic license details page.
     * 
     * @param page
     *            the details page
     * @param licenseType
     *            if user has multiple licenses, this one will be used
     * @return the parsed license details
     * @throws ParsingException
     *             if the expected tags were not found
     */
    private License parseLicense(Document page, String licenseType) throws ParsingException {
        License license = new License();
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        User user = new User();
        profile.setUser(user);
        Elements tables = page.select("table");
        for (Element cell : tables.get(0).select("td")) {
            if (cell.text().equals("First Name")) {
                user.setFirstName(cell.nextElementSibling().text());
            } else if (cell.text().equals("Middle Name")) {
                user.setMiddleName(cell.nextElementSibling().text());
            } else if (cell.text().equals("Last Name")) {
                user.setLastName(cell.nextElementSibling().text());
            } else if (cell.text().equals("Gender")) {
                String gender = cell.nextElementSibling().text();
                if (Util.isNotBlank(gender)) {
                    if ("M".equalsIgnoreCase(gender)) {
                        profile.setSex(Sex.MALE);
                    } else {
                        profile.setSex(Sex.FEMALE);
                    }
                }
            }
        }

        List<Address> addresses = new ArrayList<Address>();
        Address address = new Address();
        addresses.add(address);
        profile.setAddresses(addresses);
        StringBuffer locBuffer = new StringBuffer();
        for (Element cell : tables.get(1).select("td")) {
            if (cell.text().equals("Address Line1")) {
                locBuffer.insert(0, cell.nextElementSibling().text() + " ");
            } else if (cell.text().equals("Address Line2")) {
                locBuffer.append(cell.nextElementSibling().text());
            } else if (cell.text().equals("City")) {
                address.setCity(cell.nextElementSibling().text());
            } else if (cell.text().equals("State")) {
                address.setState(cell.nextElementSibling().text());
            } else if (cell.text().equals("ZIP")) {
                address.setZipcode(cell.nextElementSibling().text());
            } else if (cell.text().equals("Phone Number")) {
                profile.setContactPhoneNumber(cell.nextElementSibling().text());
            }
        }
        address.setLocation(locBuffer.toString().trim());

        for (Element row : tables.get(2).select("tr")) {
            String lType = row.select("td:eq(0)").text();
            if (licenseType != null && !lType.startsWith(licenseType)) {
                // user has multiple licenses, the results will show this user twice (search by name)
                continue;
            }

            LicenseType type = new LicenseType();
            type.setName(row.select("td:eq(0)").text());
            license.setType(type);
            license.setLicenseNumber(row.select("td:eq(1)").text());

            LicenseStatus status = new LicenseStatus();
            status.setName(row.select("td:eq(2)").text());
            license.setStatus(status);

            String issueDate = row.select("td:eq(3)").text();
            if (Util.isNotBlank(issueDate)) {
                license.setOriginalIssueDate(parseDate(issueDate, DATE_FORMAT));
            }

            String renewalDate = row.select("td:eq(4)").text();
            if (Util.isNotBlank(renewalDate)) {
                license.setRenewalDate(parseDate(renewalDate, DATE_FORMAT));
            }

            String expirationDate = row.select("td:eq(5)").text();
            if (Util.isNotBlank(expirationDate)) {
                license.setExpireDate(parseDate(expirationDate, DATE_FORMAT));
            }
        }
        return license;
    }

    public String getDisciplineURL() {
        return disciplineURL != null ? disciplineURL : jndiGet("java:comp/env/mita/config/disciplineURL");
    }
}