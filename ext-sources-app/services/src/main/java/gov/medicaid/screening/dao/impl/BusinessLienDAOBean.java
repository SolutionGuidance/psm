/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.BusinessLienSearchCriteria;
import gov.medicaid.entities.BusinessStatus;
import gov.medicaid.entities.BusinessType;
import gov.medicaid.entities.FilingHistory;
import gov.medicaid.entities.FilingStatus;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SearchScope;
import gov.medicaid.screening.dao.BusinessLienDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
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
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for scraping EPLS exclusion results.
 *
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(BusinessLienDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class BusinessLienDAOBean extends BaseDAO implements BusinessLienDAO {

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("businessName", "business.name");
            put("businessType", "business.type.name");
            put("fileNumber", "business.fileNumber");
            put("businessStatus", "business.status.name");
            put("filingDate", "business.filingDate");
            put("renewalDueDate", "business.renewalDueDate");
        }
    };

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * Default empty constructor.
     */
    public BusinessLienDAOBean() {
    }

    /**
     * Searches for MN business and liens by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> searchByName(BusinessLienSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "BusinessLienDataAccessImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getBusinessName())) {
            throw new ServiceException(ErrorCode.MITA10023.getDesc());
        }

        return LogUtil.traceExit(getLog(), signature, search(criteria));
    }

    /**
     * Searches for MN business and liens by file number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> searchByFileNumber(BusinessLienSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "BusinessLienDataAccessImpl#searchByFileNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getFileNumber())) {
            throw new ServiceException(ErrorCode.MITA10024.getDesc());
        }

        return LogUtil.traceExit(getLog(), signature, search(criteria));
    }

    /**
     * Performs the search.
     *
     * @param criteria search criteria
     * @return matched results
     * @throws ServiceException for any other exceptions encountered
     */
    private SearchResult<ProviderProfile> search(BusinessLienSearchCriteria criteria) throws ServiceException {
        String signature = "BusinessLienDataAccessImpl#search";
        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<ProviderProfile> allResults = getAllResults(criteria);
            SearchResult<ProviderProfile> results = trimResults(allResults, criteria.getPageSize(),
                criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());
            logSearchEntry(criteria);
            return results;
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
     * @return the search result for licenses
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ParseException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<ProviderProfile> getAllResults(BusinessLienSearchCriteria criteria) throws URISyntaxException,
        ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getSearch = new HttpGet(new URIBuilder(getSearchURL()).build());
        // to get the cookie
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        String fullSearchURL = getSearchURL() + "/Business/Search";
        HttpPost search = new HttpPost(new URIBuilder(fullSearchURL).build());
        List<ProviderProfile> allProfiles = new ArrayList<ProviderProfile>();

        HttpEntity entity = postForm(
            fullSearchURL,
            client,
            search,
            new String[][]{{"BusinessName", Util.defaultString(criteria.getBusinessName())},
                {"FileNumber", Util.defaultString(criteria.getFileNumber())},
                {"Status", criteria.getFilingStatus() == FilingStatus.INACTIVE ? "Inactive" : "Active"},
                {"Type", criteria.getScope() == SearchScope.CONTAINS ? "Contains" : "BeginsWith"},
                {"submit", "Search"}},
            true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        Elements detailLinks = page.select("table.results tr td a");
        for (Element detailLink : detailLinks) {
            String href = detailLink.attr("href");

            String detailUrl = getSearchURL() + href;
            HttpGet getDetail = new HttpGet(detailUrl);
            response = client.execute(getDetail);
            verifyAndAuditCall(detailUrl, response);
            Document profileDetails = Jsoup.parse(EntityUtils.toString(response.getEntity()));
            allProfiles.add(parseProfile(profileDetails));
        }

        SearchResult<ProviderProfile> searchResult = new SearchResult<ProviderProfile>();
        searchResult.setItems(allProfiles);
        return searchResult;
    }

    /**
     * Parses the excluded provider profile details page.
     *
     * @param page the details page
     * @return the parsed license details
     * @throws ParsingException if the expected tags were not found
     */
    private ProviderProfile parseProfile(Document page) throws ParsingException {
        ProviderProfile profile = new ProviderProfile();

        // business
        String businessName = page.select("#searchItemDetail #recordReview h3").text();
        Business business = new Business();
        profile.setBusiness(business);
        business.setName(businessName);

        Elements detailMaster = page.select("#searchItemDetail #RecordDetailMaster #filingSummary dl");
        // business type
        BusinessType businessType = new BusinessType();
        business.setType(businessType);
        businessType.setName(getValuePairOfLabel(detailMaster, "Business Type"));

        // statute
        business.setStatute(getValuePairOfLabel(detailMaster, "MN Statute"));

        // file number
        business.setFileNumber(getValuePairOfLabel(detailMaster, "File Number"));

        // home jurisdiction
        business.setHomeJurisdiction(getValuePairOfLabel(detailMaster, "Home Jurisdiction"));

        // filing date
        Date filingDate = parseDate(getValuePairOfLabel(detailMaster, "Filing Date"), DATE_FORMAT);
        if (filingDate != null) {
            business.setFilingDate(filingDate);
        }

        // status
        BusinessStatus status = new BusinessStatus();
        status.setName(getValuePairOfLabel(detailMaster, "Status"));
        business.setStatus(status);

        // renewal date
        Date renewalDate = parseDate(getValuePairOfLabel(detailMaster, "Renewal Due Date:"), DATE_FORMAT);
        if (renewalDate != null) {
            business.setRenewalDueDate(renewalDate);
        }

        // registered office address
        business
            .setRegisteredOfficeAddress(parseAddress(getValuePairOfLabel(detailMaster, "Registered Office Address")));

        // registered agents
        ProviderProfile agent = new ProviderProfile();
        List<ProviderProfile> agents = new ArrayList<ProviderProfile>();
        business.setRegisteredAgents(agents);
        agents.add(agent);
        agent.setAgency(getValuePairOfLabel(detailMaster, "Registered Agent(s)"));

        List<FilingHistory> filingHistories = new ArrayList<FilingHistory>();
        business.setFilingHistory(filingHistories);

        Elements fileHistories = page.select("#filing table tr");
        for (Element fileHistory : fileHistories) {
            FilingHistory fh = new FilingHistory();
            Date fileDate = parseDate(fileHistory.select("td.date").text(), DATE_FORMAT);
            if (fileDate != null) {
                fh.setDate(fileDate);
            }
            fh.setDescription(fileHistory.select("td.action").text());
            filingHistories.add(fh);
        }

        return profile;
    }

    /**
     * Get value pair of label element.
     *
     * @param elements group of elements
     * @param label label to look for
     * @return value
     */
    private String getValuePairOfLabel(Elements elements, String label) {
        Element labelElement = elements.select("dt:containsOwn(" + label + ")").first();
        return labelElement != null && labelElement.nextElementSibling() != null ? labelElement.nextElementSibling()
            .text() : "";
    }

    /**
     * Parse the address string.
     *
     * @param fullHtmlAddress Full HTML address
     * @return address
     */
    private Address parseAddress(String fullHtmlAddress) {
        Address address = new Address();
        String[] addressParts = fullHtmlAddress.split("<br />");
        address.setLocation(addressParts[0]);
        if (addressParts.length > 1) { // city, state, zip
            String cityStateZip = addressParts[1].trim();
            String[] cszParts = cityStateZip.split(" ");
            address.setCity(cszParts[0]);
            address.setState(cszParts[1]);
            address.setZipcode(cszParts[2]);
            if (addressParts.length == 3) { // country
                address.setCountry(addressParts[2].trim());
            }
        }
        return address;
    }

}