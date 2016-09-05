/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.OptometryLicenseSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.OptometryLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
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
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for searching for Optometry Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(OptometryLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class OptometryLicenseDAOBean extends BaseDAO implements OptometryLicenseDAO {

    /**
     * Date format for this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "profile.user.firstName");
            put("lastName", "profile.user.lastName");
            put("licenseNumber", "licenseNumber");
            put("licenseType", "type.name");
            put("licenseNumber", "licenseNumber");
            put("originalIssueDate", "originalIssueDate");
            put("expireDate", "expireDate");
            put("status", "status.name");
            put("statusDate", "status.date");
            put("disciplineBdOrder", "disciplineBdOrder");
            put("correctiveAction", "correctiveAction");
        }
    };

    /**
     * Search optometry license by name.
     *
     * @param criteria The search criteria
     * @return optometry licenses
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByName(OptometryLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "OptometryLicenseDataAccessImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getLastName() == null || criteria.getLastName().trim().length() == 0) {
            throw new ServiceException(ErrorCode.MITA10001.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        SearchResult<License> allResults = doSearch(criteria.getLastName());
        SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
            SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

        logSearchEntry(criteria);
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Search optometry license by license number.
     *
     * @param criteria The search criteria
     * @return optometry licenses
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByLicenseNumber(OptometryLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "OptometryLicenseDataAccessImpl#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getIdentifier() == null || criteria.getIdentifier().trim().length() == 0) {
            throw new ServiceException(ErrorCode.MITA10004.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        SearchResult<License> results = trimResults(doSearch(criteria.getIdentifier()), criteria.getPageSize(),
            criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

        logSearchEntry(criteria);
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Performs the search.
     *
     * @param identifier The value to look for.
     * @return all licenses
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    private SearchResult<License> doSearch(String identifier) throws ServiceException, ParsingException {
        try {
            return getAllResults(identifier);
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
     * @param identifier The value to be searched.
     * @return the search result for licenses
     * @throws URISyntaxException When an error occurs while building the URL.
     * @throws ClientProtocolException When client does not support protocol used.
     * @throws IOException When an error occurs while parsing response.
     * @throws ParseException When an error occurs while parsing response.
     * @throws PersistenceException for database related errors
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<License> getAllResults(String identifier) throws URISyntaxException, ClientProtocolException,
        IOException, ParseException, PersistenceException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        URIBuilder builder = new URIBuilder(getSearchURL()).setPath("/Default.aspx");
        String hostId = builder.build().toString();
        builder.setParameter("tabid", "799");

        HttpGet httpget = new HttpGet(builder.build());
        HttpResponse landing = client.execute(httpget);
        Document document = Jsoup.parse(EntityUtils.toString(landing.getEntity()));

        HttpPost httppost = new HttpPost(builder.build());
        HttpEntity entity = postForm(
            hostId,
            client,
            httppost,
            new String[][]{{"_ctl0:_ctl1:_ctl0:txtCriteria", identifier}, {"_ctl0:_ctl1:_ctl0:btnSubmit", "Search"},
                {"__EVENTTARGET", ""}, {"__EVENTARGUMENT", ""},
                {"__VIEWSTATE", document.select("#Form input[name=__VIEWSTATE]").first().val()}}, true);

        // licenses list
        List<License> licenseList = new ArrayList<License>();
        while (entity != null) {
            String result = EntityUtils.toString(entity);
            document = Jsoup.parse(result);

            Elements trs = document.select("table.Datagrid tr");
            if (trs != null) {
                for (Element element : trs) {
                    String cssClass = element.attr("class");
                    if (!"DatagridHeaderStyle".equals(cssClass.trim()) && element.children().size() == 8) {
                        Elements tds = element.children();
                        licenseList.add(parseLicense(tds));
                    }
                }
            }

            // done, check if there are additional results
            entity = null;
            Elements elements = document.getElementsByTag("a");
            for (Element element : elements) {
                if (element.text().equals("Next >>")) {
                    entity = postForm(hostId, client, httppost, new String[][]{
                        {"_ctl0:_ctl1:_ctl0:txtCriteria", identifier},
                        {"__EVENTTARGET", "_ctl0:_ctl1:_ctl0:dgrdLicensee:_ctl29:_ctl1"}, {"__EVENTARGUMENT", ""},
                        {"__VIEWSTATE", document.select("#Form input[name=__VIEWSTATE]").first().val()}}, true);
                    break;
                }
            }
        }

        SearchResult<License> result = new SearchResult<License>();
        result.setItems(licenseList);
        return result;
    }

    /**
     * Parse the License information.
     *
     * @param tds The elements
     * @return parsed license
     * @throws ParseException When an error occurs while parsing the date.
     */
    private License parseLicense(Elements tds) throws ParseException {
        String licenseNumber = tds.get(0).text();
        String name = tds.get(1).text();
        String originalIssueDate = tds.get(2).child(0).text();
        String expirationDate = tds.get(3).child(0).text();
        String statusDate = tds.get(4).child(0).text();
        String disciplineBdOrder = tds.get(5).child(0).text();
        String correctiveAction = tds.get(6).child(0).text();

        License license = new License();
        license.setLicenseNumber(licenseNumber);
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        User user = new User();
        String[] nameParts = name.split(",");
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
        profile.setUser(user);

        Date issueDate = parseDate(originalIssueDate, DATE_FORMAT);
        if (issueDate != null) {
            license.setOriginalIssueDate(issueDate);
        }
        Date expireDate = parseDate(expirationDate, DATE_FORMAT);
        if (expireDate != null) {
            license.setExpireDate(expireDate);
        }

        LicenseStatus status = new LicenseStatus();
        int statusEndIndex = statusDate.length();
        if (statusDate.indexOf("/") != -1) {
            statusEndIndex = statusDate.indexOf("/") - 2;
            String strDate = statusDate.substring(statusEndIndex, statusDate.length());
            license.setStatusDate(parseDate(strDate, DATE_FORMAT));
        }
        status.setName(statusDate.substring(0, statusEndIndex));
        license.setStatus(status);

        license.setDisciplineBdOrder(!"No".equals(disciplineBdOrder.trim()));
        license.setCorrectiveAction(!"No".equals(correctiveAction.trim()));
        return license;
    }
}