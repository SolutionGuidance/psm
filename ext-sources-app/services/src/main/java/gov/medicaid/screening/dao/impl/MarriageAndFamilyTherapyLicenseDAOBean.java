/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.MarriageAndFamilyTherapyLicenseCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SortOrder;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.MarriageAndFamilyTherapyLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
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

import org.apache.commons.beanutils.BeanComparator;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the actual logic of searching for Marriage and Family Therapy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(MarriageAndFamilyTherapyLicenseDAO.class)
@TransactionManagement(value = TransactionManagementType.CONTAINER)
@TransactionAttribute(value = TransactionAttributeType.REQUIRED)
public class MarriageAndFamilyTherapyLicenseDAOBean extends BaseDAO implements MarriageAndFamilyTherapyLicenseDAO {

    /**
     * License criteria.
     */
    private static final String LICENSE_CRITERIA = "License";

    /**
     * Last Name criteria.
     */
    private static final String LAST_NAME_CRITERIA = "[Last Name]";

    /**
     * Simple date formatter.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "profile.user.firstName");
            put("middleName", "profile.user.middleName");
            put("lastName", "profile.user.lastName");
            put("licenseType", "type.name");
            put("originalIssueDate", "originalIssueDate");
            put("expireDate", "expireDate");
            put("ceDate", "ceDate");
            put("status", "status.name");
            put("statusDate", "status.date");
            put("discipline", "discipline");
            put("correctiveAction", "correctiveAction");
        }
    };

    /**
     * Searches for providers with Marriage and Family therapy license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the argument is null
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    public SearchResult<License> searchByName(MarriageAndFamilyTherapyLicenseCriteria criteria)
        throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseDataAccessImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        if (criteria == null) {
            throw new IllegalArgumentException("criteria must not be null.");
        }

        try {
            if (criteria.getLastName() == null || criteria.getLastName().trim().length() == 0) {
                throw new ServiceException(ErrorCode.MITA10001.getDesc());
            }

            validateSortOptions(criteria, SORT_COLUMNS);

            SearchResult<License> results = performSearch(LAST_NAME_CRITERIA, criteria.getLastName(), getSearchURL(),
                criteria.getPageSize(), criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()),
                criteria.getSortOrder());

            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Searches for providers with Marriage and Family therapy license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the argument is null
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    public SearchResult<License> searchByLicenseNumber(MarriageAndFamilyTherapyLicenseCriteria criteria)
        throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseDataAccessImpl#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        if (criteria == null) {
            throw new IllegalArgumentException("criteria must not be null.");
        }

        try {
            if (criteria.getIdentifier() == null || criteria.getIdentifier().trim().length() == 0) {
                throw new ServiceException(ErrorCode.MITA10004.getDesc());
            }

            validateSortOptions(criteria, SORT_COLUMNS);

            SearchResult<License> results = performSearch(LICENSE_CRITERIA, criteria.getIdentifier(), getSearchURL(),
                criteria.getPageSize(), criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()),
                criteria.getSortOrder());

            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Performs search by Name or License number.
     *
     * @param criteria The search criteria.
     * @param identifier The search identifier.
     * @param host The host
     * @param pageSize The page size requested
     * @param pageNumber The page number requested
     * @param sortColumn the sort column
     * @param sortOrder the sort order
     * @return search results - licenses.
     * @throws PersistenceException When an error occurs while trying to persist statistics.
     * @throws ServiceException When an error occurs while trying to perform search.
     */
    @SuppressWarnings("unchecked")
    private SearchResult<License> performSearch(String criteria, String identifier, String host, int pageSize,
        int pageNumber, String sortColumn, SortOrder sortOrder) throws PersistenceException, ServiceException {
        String signature = "BaseLicenseDataAccessImpl#performSearch";
        try {
            if (pageNumber > 0 && pageSize < 1) {
                throw new ServiceException(ErrorCode.MITA10002.getDesc());
            }

            SearchResult<License> allResults = getAllResults(criteria, identifier, host, 1);
            if (sortColumn != null) {
                Collections.sort(allResults.getItems(), new BeanComparator(sortColumn));
                if (sortOrder == SortOrder.DESC) {
                    Collections.reverse(allResults.getItems());
                }
            }

            // trim result
            List<License> trimmedResults = new ArrayList<License>();
            List<License> allResultsList = allResults.getItems();

            if (pageNumber > 0) {
                if (allResultsList != null && !allResultsList.isEmpty()) {
                    int fromIndex = Math.min(pageSize * (pageNumber - 1), allResultsList.size() - 1);
                    int toIndex = Math.min(fromIndex + pageSize, allResultsList.size());
                    trimmedResults.addAll(allResultsList.subList(fromIndex, toIndex));
                }
            } else {
                trimmedResults.addAll(allResultsList);
            }

            SearchResult<License> result = new SearchResult<License>();
            result.setPageNumber(pageNumber);
            result.setPageSize(pageSize);
            result.setItems(trimmedResults);
            result.setTotal(allResultsList.size());

            int totalPages;
            if (pageSize > 0) {
                totalPages = (int) Math.ceil((double) allResultsList.size() / pageSize);
            } else {
                totalPages = allResultsList.isEmpty() ? 0 : 1;
            }
            result.setTotalPages(totalPages);
            return result;
        } catch (PersistenceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50000.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50002.getDesc(), e);
        } catch (URISyntaxException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50002.getDesc(), e);
        } catch (ParseException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50002.getDesc(), e);
        }
    }

    /**
     * Performs a search for all possible results.
     *
     * @param criteria The search criteria.
     * @param identifier The value to be searched.
     * @param host The host where to perform search.
     * @param pageNumber The page number requested
     * @return the search result for licenses
     * @throws URISyntaxException When an error occurs while building the URL.
     * @throws IOException When an error occurs while parsing response.
     * @throws ParseException When an error occurs while parsing response.
     * @throws PersistenceException if any db related error is encountered
     * @throws ServiceException When an error occurs while trying to perform search.
     */
    private SearchResult<License> getAllResults(String criteria, String identifier, String host, int pageNumber)
        throws URISyntaxException, ParseException, PersistenceException, IOException, ServiceException {
        HttpClient client = new DefaultHttpClient();
        URIBuilder builder = new URIBuilder(host).setPath("/search.asp");
        String hostId = builder.build().toString();

        builder.setParameter("qry", criteria).setParameter("crit", identifier).setParameter("p", "s")
            .setParameter("rsp", pageNumber + "");

        URI uri = builder.build();
        HttpGet httpget = new HttpGet(uri);

        SearchResult<License> searchResults = new SearchResult<License>();

        HttpResponse response = client.execute(httpget);
        int statusCode = response.getStatusLine().getStatusCode();
        if (statusCode == HttpStatus.SC_OK) {

            HttpEntity entity = response.getEntity();
            SearchResult<License> nextResults = null;
            // licenses list
            List<License> licenseList = new ArrayList<License>();
            if (entity != null) {
                String result = EntityUtils.toString(entity);
                Document document = Jsoup.parse(result);
                Elements trs = document.select("tr[bgcolor]");
                for (Element tr : trs) {
                    Elements tds = tr.children();
                    licenseList.add(parseLicenseInfo(tds));
                }
                // check if there is next page
                Element next = document.select("a:containsOwn(Next)").first();
                if (next != null) {
                    nextResults = getAllResults(criteria, identifier, host, pageNumber + 1);
                }
                if (nextResults != null) {
                    licenseList.addAll(nextResults.getItems());
                }
            }

            searchResults.setItems(licenseList);
        }
        verifyAndAuditCall(hostId, response);

        return searchResults;
    }

    /**
     * Parse License info from list of TD elements.
     *
     * @param tds The TD elements.
     * @return License object
     * @throws ParseException When an error occurs while parsing date.
     */
    private License parseLicenseInfo(Elements tds) throws ParseException {
        License license = new License();
        license.setLicenseNumber(tds.get(0).html());

        ProviderProfile profile = new ProviderProfile();
        User user = new User();
        user.setFirstName(tds.get(1).html());
        user.setMiddleName(tds.get(2).html());
        user.setLastName(tds.get(3).html());
        profile.setUser(user);
        license.setProfile(profile);

        LicenseType licenseType = new LicenseType();
        licenseType.setName(tds.get(4).html());
        license.setType(licenseType);

        Date issueDate = parseDate(tds.get(5).html(), DATE_FORMAT);
        if (issueDate != null) {
            license.setOriginalIssueDate(issueDate);
        }
        Date expireDate = parseDate(tds.get(6).html(), DATE_FORMAT);
        if (expireDate != null) {
            license.setExpireDate(expireDate);
        }
        LicenseStatus status = new LicenseStatus();
        status.setName(tds.get(7).html());
        license.setStatus(status);
        Date statusDate = parseDate(tds.get(8).html(), DATE_FORMAT);
        if (statusDate != null) {
            status.setDate(statusDate);
        }

        license.setDiscipline(!"No".equals(tds.get(9).html()));
        license.setCorrectiveAction(!"No".equals(tds.get(10).html()));
        return license;
    }
}