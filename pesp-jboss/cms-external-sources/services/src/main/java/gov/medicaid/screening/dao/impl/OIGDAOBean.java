/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.ExclusionType;
import gov.medicaid.entities.OIGSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.Specialty;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.OIGDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for scraping OIG exclusion results.
 *
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(OIGDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OIGDAOBean extends BaseDAO implements OIGDAO {

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
     * Host used for search.
     */
    @Resource(name = "mita/config/verificationURL")
    private String verificationURL;

    /**
     * Host used for search.
     */
    @Resource(name = "mita/config/exclusionURL")
    private String exclusionURL;

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * Default empty constructor.
     */
    public OIGDAOBean() {
    }

    /**
     * Searches for excluded providers.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(OIGSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "OIGDataAccessImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null
            || (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getFirstName()) && Util.isBlank(criteria
                .getBusinessName()))) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

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
     * Verifies SSN if valid.
     *
     * @param entityId the entity id
     * @param ssn the ssn
     * @return true if valid, false if not
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public boolean verifySSN(String entityId, String ssn) throws ParsingException, ServiceException {
        String signature = "OIGDataAccessImpl#verifySSN";
        LogUtil.traceEntry(getLog(), signature, new String[]{"entityId", "ssn"}, new Object[]{entityId, ssn});

        if (Util.isBlank(entityId) && Util.isBlank(ssn)) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        try {
            return LogUtil.traceExit(getLog(), signature, checkSSN(entityId, ssn));
        } catch (ClientProtocolException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Retrieves all available exclusion types.
     *
     * @return the exclusion types.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<ExclusionType> getExclusionTypeList() throws ParsingException, ServiceException {
        String signature = "OIGDataAccessImpl#verifySSN";
        LogUtil.traceEntry(getLog(), signature, new String[]{}, new Object[]{});

        try {
            return LogUtil.traceExit(getLog(), signature, getAllExclusions());
        } catch (ClientProtocolException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (URISyntaxException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }

    }

    /**
     * Performs a search for all exclusion types.
     *
     * @return the search result for provider profiles
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private List<ExclusionType> getAllExclusions() throws URISyntaxException, ClientProtocolException, IOException,
        ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();

        HttpGet getSearch = new HttpGet(new URIBuilder(exclusionURL).build());
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(exclusionURL, response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        List<ExclusionType> allExclusions = new ArrayList<ExclusionType>();

        Elements links = page.select("table#CountList tbody tr td a");
        for (Element link : links) {
            ExclusionType exclusionType = new ExclusionType();
            exclusionType.setName(link.text());
            allExclusions.add(exclusionType);
        }
        return allExclusions;
    }

    /**
     * Performs a search for all possible results.
     *
     * @param criteria The search criteria.
     * @return the search result for provider profiles
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ParseException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<ProviderProfile> getAllResults(OIGSearchCriteria criteria) throws URISyntaxException,
        ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getSearch = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        HttpPost search = new HttpPost(new URIBuilder(getSearchURL()).build());
        List<ProviderProfile> allProfiles = new ArrayList<ProviderProfile>();

        HttpEntity entity = postForm(
            getSearchURL(),
            client,
            search,
            new String[][]{{"cmdSubmit", "Search"}, {"txtFirstName1", Util.defaultString(criteria.getFirstName())},
                {"txtLastName1", Util.defaultString(criteria.getLastName())},
                {"txtBusinessName1", Util.defaultString(criteria.getBusinessName())}, {"txtFirstName2", ""},
                {"txtLastName2", ""}, {"txtBusinessName2", ""}, {"txtFirstName3", ""}, {"txtLastName3", ""},
                {"txtBusinessName3", ""}, {"txtFirstName4", ""}, {"txtLastName4", ""}, {"txtBusinessName4", ""},
                {"txtFirstName5", ""}, {"txtLastName5", ""}, {"txtBusinessName5", ""},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        Elements rows = page.select("table#dgResult tr.GridCell");
        for (Element row : rows) {
            if (row.select("td:eq(8)").text().equals("N/A")) {
                String entityId = row.select("td:eq(3) a").first().attr("href");
                entityId = entityId.replaceFirst("javascript:VerifyID\\(", "");
                entityId = entityId.replaceFirst("\\)", "");
                ProviderProfile profile = parseProfile(getDetails(client, entityId));
                profile.setId(Long.parseLong(entityId));
                allProfiles.add(profile);
            } else {
                String entityId = row.select("td:eq(8) a").first().attr("href");
                entityId = entityId.replaceFirst("javascript:VerifyID\\(", "");
                entityId = entityId.replaceFirst("\\)", "");
                ProviderProfile profile = parseProfile(getDetails(client, entityId));
                profile.setId(Long.parseLong(entityId));
                allProfiles.add(profile);
            }
        }

        SearchResult<ProviderProfile> searchResult = new SearchResult<ProviderProfile>();
        searchResult.setItems(allProfiles);
        return searchResult;
    }

    /**
     * Get details page.
     *
     * @param client the default http client
     * @param entityId the entity id
     * @return the details page
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private Document getDetails(DefaultHttpClient client, String entityId) throws ClientProtocolException, IOException,
        ServiceException {
        String detailURL = Util.replaceLastURLPart(getSearchURL(), "Verification.aspx");
        HttpGet getDetail = new HttpGet(detailURL);
        getDetail.setHeader(new BasicHeader("Cookie", "Entity=" + entityId));

        HttpResponse detailsResponse = client.execute(getDetail);
        verifyAndAuditCall(detailURL, detailsResponse);
        return Jsoup.parse(EntityUtils.toString(detailsResponse.getEntity()));
    }

    /**
     * Verifies if the provided SSN is valid for the given entity id.
     *
     * @param entityId the entity id
     * @param ssn the ssn to be verified
     * @return true if valid, false if not
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private boolean checkSSN(String entityId, String ssn) throws IOException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());
        return executeVerification(client, entityId, ssn, getDetails(client, entityId));
    }

    /**
     * Verify if SSN is correct.
     *
     * @param client the default http client
     * @param entityId the entity id
     * @param ssn the ssn to be verified
     * @param profileDetails the details page
     * @return true if verified, false if not
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private boolean executeVerification(DefaultHttpClient client, String entityId, String ssn, Document profileDetails)
        throws ClientProtocolException, IOException, ServiceException {
        HttpPost verifyDetails = new HttpPost(verificationURL);
        verifyDetails.setHeader(new BasicHeader("Cookie", "Entity=" + entityId));

        HttpEntity verifiedEntity = postForm(
            verificationURL,
            client,
            verifyDetails,
            new String[][]{{"cmdVerify", "Verify"}, {"txtIdInput", ssn},
                {"__VIEWSTATE", profileDetails.select("input[name=__VIEWSTATE]").first().val()}}, true);

        Document verifiedDetails = Jsoup.parse(EntityUtils.toString(verifiedEntity));
        String message = verifiedDetails.select("#lblVerifyConfirm").text();
        return message.indexOf("This record does NOT match SSN/EIN") == -1;
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

        // name
        User user = new User();
        profile.setUser(user);
        user.setLastName(page.select("#lblLastName").text());
        user.setFirstName(page.select("#lblFirstName").text());

        // business
        String businessName = page.select("#lblBuzName").text();
        if (!"N/A".equals(businessName)) {
            Business business = new Business();
            profile.setBusiness(business);
            business.setName(businessName);
        }

        // DOB
        Date dob = parseDate(page.select("#lblDOB").text(), DATE_FORMAT);
        if (dob != null) {
            profile.setDob(dob);
        }

        // exclusion type
        ExclusionType exclusionType = new ExclusionType();
        profile.setExclusionType(exclusionType);
        exclusionType.setName(page.select("#lblExclType").text());

        // specialty
        List<Specialty> specialties = new ArrayList<Specialty>();
        Specialty specialty = new Specialty();
        specialties.add(specialty);
        specialty.setName(page.select("#lblSpecialty").text());
        profile.setSpecialties(specialties);

        // address
        Address address = new Address();
        address.setLocation(page.select("#lblAddress").text());
        address.setCity(page.select("#lblCity").text());
        address.setState(page.select("#lblState").text());
        address.setZipcode(page.select("#lblZip").text());
        profile.setAddresses(Arrays.asList(new Address[]{address}));

        Date date = parseDate(page.select("#lblDate").text(), DATE_FORMAT);
        if (date != null) {
            profile.setRequestEffectiveDate(date);
        }

        return profile;
    }

}