/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.PharmacySearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.PharmacyLicensingDAO;
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
import org.jsoup.select.Elements;

/**
 * This class provides an EJB implementation of the PharmacyLicensingDAO interface. It is a stateless, local
 * bean.
 * 
 * <p>
 * <strong>Thread Safety:</strong> This bean is mutable and not thread-safe as it deals with non-thread-safe
 * entities. However, in the context of being used in a container, it is thread-safe.
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@Stateless
@Local(PharmacyLicensingDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PharmacyLicensingDAOBean extends BaseProviderScreeningDAO implements PharmacyLicensingDAO {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PharmacyLicensingDAOBean.class.getName();

    /**
     * The supported columns for this implementation.
     */
    @SuppressWarnings("serial")
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("name", "business.name");
            put("zipcode", "addresses[0].zipcode");
            put("state", "addresses[0].state");
            put("city", "addresses[0].city");
            put("state", "addresses[0].state");
            put("location", "addresses[0].location");
            put("phone", "contactPhoneNumber");
        }
    };

    /**
     * Default empty constructor.
     */
    public PharmacyLicensingDAOBean() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search
     * result will be empty.
     * 
     * @param criteria
     *            the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException
     *             if the criteria is null, if criteria.pageNumber < 0; if criteria.pageSize < 1 unless
     *             criteria.pageNumber <= 0
     * @throws ParsingException
     *             if the parsing of the responses caused an error
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(PharmacySearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = CLASS_NAME + "#search(PharmacySearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        // make sure we have enough parameters to perform the external search
        validateCriteria(criteria);

        // make sure that the sort column is one of the properties we support
        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<ProviderProfile> allResults = getAllResults(criteria);
            SearchResult<ProviderProfile> results = trimResults(allResults, criteria.getPageSize(),
                    criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()),
                    criteria.getSortOrder());
            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            throw e;
        } catch (Throwable e) {
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Validates the search criteria.
     * 
     * @param criteria
     *            the search criteria to be validated
     * @throws IllegalArgumentException
     *             if any parameter is invalid
     */
    private void validateCriteria(PharmacySearchCriteria criteria) {
        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getPageNumber() < 0 || (criteria.getPageNumber() > 0 && criteria.getPageSize() < 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }
    }

    /**
     * Retrieves all results from the source site.
     * 
     * @param criteria
     *            the search criteria.
     * @return the providers matched
     * @throws URISyntaxException
     *             if the URL could not be correctly constructed
     * @throws IOException
     *             for any I/O related errors
     * @throws ServiceException
     *             for any other errors encountered
     */
    private SearchResult<ProviderProfile> getAllResults(PharmacySearchCriteria criteria)
            throws URISyntaxException, IOException, ServiceException {
        String indexPage = getSearchURL() + "index.aspx";
        String searchPage = getSearchURL() + "search.aspx";
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());
        HttpGet httpGet = new HttpGet(new URIBuilder(indexPage).build());
        HttpResponse response = client.execute(httpGet);
        verifyAndAuditCall(indexPage, response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        HttpPost httpPost = new HttpPost(new URIBuilder(indexPage).build());
        HttpEntity entity = postForm(indexPage, client, httpPost, new String[][] { { "ddlCategory", "57" },
                { "btnSearch", "Next" }, { "__VIEWSTATE", page.select("#__VIEWSTATE").val() },
                { "__EVENTVALIDATION", page.select("#__EVENTVALIDATION").val() } }, true);

        page = Jsoup.parse(EntityUtils.toString(entity));
        httpPost = new HttpPost(new URIBuilder(searchPage).build());
        entity = postForm(searchPage, client, httpPost,
                new String[][] {
                        // for "Pharmacy"
                        { "ddlCategory", "57" },
                        // for "Pharmacy"
                        { "ddlSubCategory", "86" },
                        { "txtProvider", Util.defaultString(criteria.getName()) },
                        { "txtAddress", Util.defaultString(criteria.getAddress()) },
                        { "txtCity", Util.defaultString(criteria.getCity()) },
                        { "ddlState", Util.defaultString(criteria.getState()) },
                        { "ddlCounty", Util.defaultString(criteria.getCounty()) },
                        { "txtZip", Util.defaultString(criteria.getZip()) }, { "btnSearch", "btnSearch" },
                        { "__VIEWSTATE", page.select("#__VIEWSTATE").val() },
                        { "__EVENTVALIDATION", page.select("#__EVENTVALIDATION").val() } }, true);

        page = Jsoup.parse(EntityUtils.toString(entity));
        Elements elements = page.select("form#form1 table table tr:gt(3) td");
        List<ProviderProfile> allProviders = new ArrayList<ProviderProfile>();
        for(String line : elements.html().split("<p>|</p>")) {
            if(line.trim().length() != 0) {
                String[] sp = line.trim().split("<b>|</b>|<br />");
                List<String> row = new ArrayList<String>();
                for(String line2 : sp) {
                    if(line2.trim().length() != 0) {
                        row.add(line2);
                    }
                }
                allProviders.add(parseProfile(row));
            }
        }

        SearchResult<ProviderProfile> results = new SearchResult<ProviderProfile>();
        results.setItems(allProviders);
        return results;
    }
    
    /**
     * Parse the ProviderProfile information.
     * 
     * @param row
     *            The elements
     * @throws ParsingException
     *             if any error occurs when parsing
     * @return parsed ProviderProfile
     */
    public ProviderProfile parseProfile(List<String> row) throws ParsingException {
        try {
            int phoneIndex = -1;
            for (int i = 0; i < row.size(); i++) {
                if (row.get(i).startsWith("(")) {
                    phoneIndex = i;
                    break;
                }
            }
            ProviderProfile profile = new ProviderProfile();
            int index = 0;
            String name = row.get(index++);
            String address = row.get(index++);
            // The address may have two columns.
            if (index + 1 < phoneIndex || (phoneIndex == -1 && index + 1 < row.size())) {
                address += " " + row.get(index++);
            }
            String address2 = row.get(index++);
            // phone may be empty
            String phone = "", city, state, zip;
            if (phoneIndex != -1) {
                phone = row.get(phoneIndex);
            }

            String[] sp = address2.split(",");
            city = sp[0].trim();
            sp = sp[1].trim().split(" ");
            state = sp[0].trim();
            zip = sp[1].trim();

            // name
            Business business = new Business();
            profile.setBusiness(business);
            business.setName(name);

            // address
            List<Address> addresses = new ArrayList<Address>();
            Address addressObj = new Address();
            addresses.add(addressObj);
            profile.setAddresses(addresses);
            addressObj.setCity(city);
            addressObj.setZipcode(zip);
            addressObj.setState(state);
            addressObj.setLocation(address);

            // phone
            profile.setContactPhoneNumber(phone);
            profile.setProviderType(getProviderType());
            return profile;
        } catch (Throwable e) {
            throw new ParsingException("Failed to parse the html", e);
        }
    }
}