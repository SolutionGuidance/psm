/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicensedProviderSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
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
 * This defines the logic for scraping licensed providers.
 * 
 * <strong>This is an stateless EJB and is thread safe.</strong>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
public class LicensedProviderCommonDAO extends BaseProviderScreeningDAO {

    /**
     * The supported columns for this implementation.
     */
    @SuppressWarnings("serial")
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("name", "business.name");
            put("zipcode", "addresses[0].zipcode");
            put("state", "addresses[0].state");
            put("county", "addresses[0].county");
            put("city", "addresses[0].city");
            put("state", "addresses[0].state");
            put("location", "addresses[0].location");
            put("phone", "contactPhoneNumber");
            put("licenseNumber", "licenses[0].licenseNumber");
        }
    };

    /**
     * Default empty constructor.
     */
    public LicensedProviderCommonDAO() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search
     * result will be empty.
     * 
     * @param signature
     *            the method signature.
     * @param criteria
     *            the search criteria
     * @param providerName
     *            the provider name.
     * @return the search result with the matched providers
     * @throws IllegalArgumentException
     *             if the criteria is null, if criteria.pageNumber < 0; if criteria.pageSize < 1 unless
     *             criteria.pageNumber <= 0
     * @throws ParsingException
     *             - if the parsing of the responses caused an error
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<ProviderProfile> search(String signature, LicensedProviderSearchCriteria criteria,
            String providerName) throws ParsingException, ServiceException {
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        // make sure we have enough parameters to perform the external search
        validateCriteria(criteria);

        // make sure that the sort column is one of the properties we support
        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<ProviderProfile> allResults = getAllResults(criteria, providerName);
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
    private void validateCriteria(LicensedProviderSearchCriteria criteria) {
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
     * @param providerName the provider name.
     * @return the providers matched
     * @throws URISyntaxException
     *             if the URL could not be correctly constructed
     * @throws IOException
     *             for any I/O related errors
     * @throws ParsingException
     *             if any error occurs when parsing
     * @throws ServiceException
     *             for any other errors encountered
     */
    private SearchResult<ProviderProfile> getAllResults(LicensedProviderSearchCriteria criteria,
            String providerName) throws URISyntaxException, IOException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());
        HttpGet httpGet = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(httpGet);
        verifyAndAuditCall(getSearchURL(), response);
        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        
        HttpPost httpPost = new HttpPost(new URIBuilder(getSearchURL() + "Search.aspx").build());
        HttpEntity entity = postForm(getSearchURL() + "Search.aspx", client, httpPost,
                new String[][]{
                {"txtProgramName", Util.defaultString(criteria.getName())},
                {"ddlCity", Util.defaultAllString(criteria.getCity())},
                {"ddlCounty", Util.defaultAllString(criteria.getCounty())},
                {"ddlState", Util.defaultAllString(criteria.getState())},
                {"txtZipCode", Util.defaultString(criteria.getZip())},
                {"ddlTypeOfService", providerName},
                {"txtLicenseNumber", Util.defaultLongString(criteria.getLicenseNumber())},
                {"btnSearch", "Next"},
                {"__VIEWSTATE", page.select("#__VIEWSTATE").val()},
                {"__EVENTVALIDATION", page.select("#__EVENTVALIDATION").val()}
        }, true);
        
        page = Jsoup.parse(EntityUtils.toString(entity));

        List<ProviderProfile> allProviders = new ArrayList<ProviderProfile>();
        Elements elements = page.select("table#outer_content_table table");
        if(elements.size()%2 != 1) {
            throw new ParsingException("The table number is not correct");
        }
        try {
            for (int i = 1; i < elements.size(); i += 2) {
                allProviders.add(parseProfile(elements.get(i), elements.get(i + 1)));
            }
        } catch (Throwable e) {
            throw new ParsingException("Failed to parse the html", e);
        }

        SearchResult<ProviderProfile> results = new SearchResult<ProviderProfile>();
        results.setItems(allProviders);
        return results;
    }

    /**
     * Parse the ProviderProfile information.
     * 
     * @param header
     *            the header element
     * @param body
     *            the body element
     * @throws ParsingException
     *             if any error occurs when parsing
     * @return parsed ProviderProfile
     */
    private ProviderProfile parseProfile(Element header, Element body) throws ParsingException {
        try {
            String name = header.select("a").html();
            String str1 = body.select("td").get(0).html();
            String str2 = body.select("td").get(1).html();

            String licenseNumber = Util.getStringInBetween(str2, "License number:", "<br />");
            String[] sp = str1.split("<br />");
            String address = "", phone = "", county = "", city = "", state = "", zipcode = "";
            address = sp[0].trim();
            if (sp.length > 3) {
                phone = sp[2].trim();
            }
            county = sp[sp.length - 1].trim();
            sp = sp[1].trim().split(",");
            city = sp[0].trim();
            sp = sp[1].trim().split(" ");
            state = sp[0].trim();
            zipcode = sp[1].trim();
            ProviderProfile profile = new ProviderProfile();
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
            addressObj.setCounty(county);
            addressObj.setState(state);
            addressObj.setLocation(address);
            addressObj.setZipcode(zipcode);

            // phone
            profile.setContactPhoneNumber(phone);

            // license
            List<License> licenses = new ArrayList<License>();
            License licenseObj = new License();
            licenses.add(licenseObj);
            profile.setLicenses(licenses);
            licenseObj.setLicenseNumber(licenseNumber);
            profile.setProviderType(getProviderType());
            return profile;
        } catch (Throwable e) {
            throw new ParsingException("Failed to parse the html", e);
        }
    }
}
