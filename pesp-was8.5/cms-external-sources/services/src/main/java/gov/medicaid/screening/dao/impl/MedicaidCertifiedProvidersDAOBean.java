/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.MedicaidCertifiedProviderSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.MedicaidCertifiedProvidersDAO;
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
 * This defines the logic for scraping Medicaid certified providers.
 *
 * <strong>This is an stateless EJB and is thread safe.</strong>
 *
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(MedicaidCertifiedProvidersDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class MedicaidCertifiedProvidersDAOBean extends BaseDAO implements MedicaidCertifiedProvidersDAO {

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("id", "employerId");
            put("adminstrator", "contactName");
            put("phone", "contactPhoneNumber");
            put("fax", "contactFaxNumber");
            put("address", "altAddress1");
        }
    };

    /**
     * Default empty constructor.
     */
    public MedicaidCertifiedProvidersDAOBean() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search result
     * will be empty.
     *
     * @param criteria the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException if the criteria is null, if criteria.pageNumber < 0; if criteria.pageSize < 1
     *             unless criteria.pageNumber <= 0
     * @throws ParsingException - if the parsing of the responses caused an error
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(MedicaidCertifiedProviderSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "MedicaidCertifiedProvidersDAOBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        // make sure we have enough parameters to perform the external search
        validateCriteria(criteria);

        // make sure that the sort column is one of the properties we support
        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<ProviderProfile> allResults = getAllResults(criteria);
            SearchResult<ProviderProfile> results = trimResults(allResults, criteria.getPageSize(),
                criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());
            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Validates the search criteria.
     *
     * @param criteria the search criteria to be validated
     * @throws IllegalArgumentException if any parameter is invalid
     */
    private void validateCriteria(MedicaidCertifiedProviderSearchCriteria criteria) {
        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getPageNumber() < 0 || (criteria.getPageNumber() > 0 && criteria.getPageSize() < 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }

        // provider type is always required
        if (Util.isBlank(criteria.getType()) || "NoProviders".equals(criteria.getType())) {
            throw new IllegalArgumentException(ErrorCode.MITA10031.getDesc());
        }

        // allowed criteria
        String[] allowedCriteria = new String[]{"County", "City", "Name", "All"};
        boolean found = false;
        for (String whichArea : allowedCriteria) {
            if (whichArea.equals(criteria.getCriteria())) {
                found = true;
            }
        }
        if (!found) {
            throw new IllegalArgumentException(ErrorCode.MITA10032.getDesc());
        }

        // value
        if ("County".equals(criteria.getCriteria())
            && (Util.isBlank(criteria.getValue()) || !Util.isDigits(criteria.getValue()) || Integer.parseInt(criteria
                .getValue()) <= 0)) {
            throw new IllegalArgumentException(ErrorCode.MITA10033.getDesc());
        }

        if ("City".equals(criteria.getCriteria()) && Util.isBlank(criteria.getValue())) {
            throw new IllegalArgumentException(ErrorCode.MITA10034.getDesc());
        }

        if ("Name".equals(criteria.getCriteria()) && Util.isBlank(criteria.getValue())) {
            throw new IllegalArgumentException(ErrorCode.MITA10035.getDesc());
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
    private SearchResult<ProviderProfile> getAllResults(MedicaidCertifiedProviderSearchCriteria criteria)
        throws URISyntaxException, IOException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        // we need to get a token from the start page, this will be stored in the client
        HttpGet getFrontPage = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getFrontPage);
        verifyAndAuditCall(getSearchURL(), response);
        EntityUtils.consume(response.getEntity()); // releases the connection

        // our client is now valid, pass the criteria to the search page
        String postSearchURL = Util.replaceLastURLPart(getSearchURL(), "showprovideroutput.cfm");
        HttpPost searchPage = new HttpPost(new URIBuilder(postSearchURL).build());
        HttpEntity entity = postForm(postSearchURL, client, searchPage,
            new String[][]{{"ProviderCatagory", criteria.getType()}, {"WhichArea", criteria.getCriteria()},
                {"Submit", "Submit"},
                {"SelectCounty", "All".equals(criteria.getCriteria()) ? "0" : criteria.getValue()},
                {"CityToFind", "All".equals(criteria.getCriteria()) ? "" : criteria.getValue()},
                {"ProviderToFind", "All".equals(criteria.getCriteria()) ? "" : criteria.getValue()}}, true);

        // this now holds the search results, parse every row
        Document page = Jsoup.parse(EntityUtils.toString(entity));
        List<ProviderProfile> allProviders = new ArrayList<ProviderProfile>();
        Elements rows = page.select("div#body table tbody tr:gt(0)");
        for (Element row : rows) {
            ProviderProfile profile = parseProfile(row.children());
            if (profile != null) {
                allProviders.add(profile);
            }
        }

        SearchResult<ProviderProfile> results = new SearchResult<ProviderProfile>();
        results.setItems(allProviders);
        return results;
    }

    /**
     * Parse the License information.
     *
     * @param tds The elements
     * @return parsed license
     */
    private ProviderProfile parseProfile(Elements tds) {
        ProviderProfile profile = new ProviderProfile();
        String id = tds.get(0).text();
        String fullProviderInfo = tds.get(1).text();
        fullProviderInfo = fullProviderInfo.replaceAll(String.valueOf((char) 160), " ").trim();
        String adminBoundary = "";
        Elements bolds = tds.get(1).children().select("b");
        if (bolds.size() >= 6) {
            adminBoundary = bolds.get(5).text();
        }

        String name = Util.getStringInBetween(fullProviderInfo, "Name:", "Address:");
        String address = Util.getStringInBetween(fullProviderInfo, "Address:", "Phone:");
        String phone = Util.getStringInBetween(fullProviderInfo, "Phone:", "Fax:");
        String fax = Util.getStringInBetween(fullProviderInfo, "Fax:", "Administrator:");
        String administrator = !"".equals(adminBoundary) ? Util.getStringInBetween(fullProviderInfo, "Administrator:",
            adminBoundary) : "";

        // id
        profile.setEmployerId(id);
        // name
        Business business = new Business();
        profile.setBusiness(business);
        business.setName(name);
        // address
        List<Address> addresses = new ArrayList<Address>();
        Address addressObj = new Address();
        addresses.add(addressObj);
        profile.setAddresses(addresses);
        String[] addressParts = address.split(" ");
        if (addressParts.length >= 3) {
            addressObj.setZipcode(addressParts[addressParts.length - 1]);
            addressObj.setState(addressParts[addressParts.length - 3]);
            int index = address.indexOf(addressParts[addressParts.length - 3] + "  "
                + addressParts[addressParts.length - 1]);
            if (index != -1) {
                addressObj.setLocation(address.substring(0, index));
            }
        }
        // phone
        profile.setContactPhoneNumber(phone);
        // fax
        profile.setContactFaxNumber(fax);
        // administrator
        profile.setContactName(administrator);

        return profile;
    }

}
