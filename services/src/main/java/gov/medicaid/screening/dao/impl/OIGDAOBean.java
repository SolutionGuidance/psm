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
     *
     * @deprecated not updated in new site layout.
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Deprecated
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
     *
     * @deprecated not updated in new site layout.
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Deprecated
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
     *
     * @deprecated not updated in new site layout.
     */
    @Deprecated
    private List<ExclusionType> getAllExclusions() throws URISyntaxException, ClientProtocolException, IOException,
        ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();

        HttpGet getSearch = new HttpGet(new URIBuilder(getExclusionURL()).build());
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(getExclusionURL(), response);

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

        boolean entitySearch = (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getFirstName()));

        HttpEntity entity = null;
        if (!entitySearch) {
            entity = postForm(getSearchURL(), client, search, new String[][] { { "__EVENTARGUMENT", "" },
                    { "__EVENTTARGET", "" },
                    { "__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val() },
                    { "__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val() },
                    { "ctl00$cpExclusions$ibSearchSP.x", "0" }, { "ctl00$cpExclusions$ibSearchSP.y", "0" },
                    { "ctl00$cpExclusions$txtSPLastName", Util.defaultString(criteria.getLastName()) },
                    { "ctl00$cpExclusions$txtSPFirstName", Util.defaultString(criteria.getFirstName()) } }, false);
        } else {
            HttpEntity searchEntity = postForm(getSearchURL(), client, search, new String[][] {
                    { "__EVENTARGUMENT", "" }, { "__EVENTTARGET", "ctl00$cpExclusions$Linkbutton1" },
                    { "__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val() },
                    { "__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val() },
                    { "ctl00$cpExclusions$txtSPLastName", "" }, { "ctl00$cpExclusions$txtSPFirstName", "" } }, false);

            page = Jsoup.parse(EntityUtils.toString(searchEntity));

            entity = postForm(getSearchURL(), client, search, new String[][] { { "__EVENTARGUMENT", "" },
                    { "__EVENTTARGET", "" },
                    { "__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val() },
                    { "__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val() },
                    { "ctl00$cpExclusions$ibSearchSP.x", "0" }, { "ctl00$cpExclusions$ibSearchSP.y", "0" },
                    { "ctl00$cpExclusions$txtSBName", Util.defaultString(criteria.getBusinessName()) } }, false);
        }

        page = Jsoup.parse(EntityUtils.toString(entity));

        Elements rows;
        int ssnColumnIndex;
        if (!entitySearch) {
            rows = page.select("table#ctl00_cpExclusions_gvEmployees tr:gt(0)");
            ssnColumnIndex = 7;
        } else {
            rows = page.select("table#ctl00_cpExclusions_gvBusiness tr:gt(0)");
            ssnColumnIndex = 5;
        }

        for (Element row : rows) {
            String href;
            if (row.select("td:eq(" + ssnColumnIndex + ")").text().equals("N/A")) {
                href = row.select("td:eq(0) a").first().attr("href");
            } else {
                href = row.select("td:eq(" + ssnColumnIndex + ") a").first().attr("href");
            }

            href = href.replaceFirst("javascript:__doPostBack\\('", "");
            href = href.replaceFirst("',''\\)", "");

            ProviderProfile profile = parseProfile(getDetails(client, href, page));
            String entityId = href.substring(0, href.lastIndexOf('$'));
            entityId = entityId.substring(entityId.lastIndexOf('$') + 4);
            profile.setId(Long.parseLong(entityId) - 2);
            allProfiles.add(profile);
        }

        SearchResult<ProviderProfile> searchResult = new SearchResult<ProviderProfile>();
        searchResult.setItems(allProfiles);
        return searchResult;
    }


    /**
     * Get details page.
     *
     * @param client the default http client
     * @param target the target PostBack
     * @param searchPage the search page
     * @return the details page
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private Document getDetails(DefaultHttpClient client, String target, Document searchPage) throws ClientProtocolException, IOException,
        ServiceException {
        String detailURL = Util.replaceLastURLPart(getSearchURL(), "SearchResults.aspx");
        HttpPost getDetail = new HttpPost(detailURL);
        HttpEntity entity = null;
        try {
        	entity = postForm(detailURL, client, getDetail, new String[][] { { "__EVENTARGUMENT", "" },
                { "__EVENTTARGET", target },
                { "__EVENTVALIDATION", searchPage.select("input[name=__EVENTVALIDATION]").first().val() },
                { "__VIEWSTATE", searchPage.select("input[name=__VIEWSTATE]").first().val() } }, false);

        } catch (ServiceException e) {
        	try {
				// try https redirection before throwing exception
				detailURL = Util.replaceLastURLPart(getSearchURL(),
						"Verify.aspx");
				detailURL = detailURL.replaceFirst("http", "https");
				HttpGet getDetails = new HttpGet(
						new URIBuilder(detailURL).build());
				HttpResponse response = client.execute(getDetails);
				verifyAndAuditCall(detailURL, response);
				entity = response.getEntity();

			} catch (Exception e1) {
				throw new ServiceException(ErrorCode.MITA50001.getDesc(), e1);
        	}
        }
        return Jsoup.parse(EntityUtils.toString(entity));
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
     *
     * @deprecated not updated in new site layout.
     */
    @Deprecated
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
     *
     * @deprecated not updated in new site layout.
     */
    @Deprecated
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
     *
     * @deprecated not updated in new site layout.
     */
    @Deprecated
    private boolean executeVerification(DefaultHttpClient client, String entityId, String ssn, Document profileDetails)
        throws ClientProtocolException, IOException, ServiceException {
        HttpPost verifyDetails = new HttpPost(getVerificationURL());
        verifyDetails.setHeader(new BasicHeader("Cookie", "Entity=" + entityId));

        HttpEntity verifiedEntity = postForm(
            getVerificationURL(),
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
        user.setLastName(page.select("th:containsOwn(Last Name) + td").text());
        user.setFirstName(page.select("th:containsOwn(First Name) + td").text());

        // business
        String businessName = page.select("th:containsOwn(Entity) + td").text();
        if (!"N/A".equals(businessName)) {
            Business business = new Business();
            profile.setBusiness(business);
            business.setName(businessName);
        }

        // DOB
        Date dob = parseDate(page.select("th:has(acronym:containsOwn(DOB)) + td").text(), DATE_FORMAT);
        if (dob != null) {
            profile.setDob(dob);
        }

        // exclusion type
        ExclusionType exclusionType = new ExclusionType();
        profile.setExclusionType(exclusionType);
        exclusionType.setName(page.select("th:containsOwn(Excl. Type) + td").text());

        // specialty
        List<Specialty> specialties = new ArrayList<Specialty>();
        Specialty specialty = new Specialty();
        specialties.add(specialty);
        specialty.setName(page.select("th:containsOwn(Specialty) + td").text());
        profile.setSpecialties(specialties);

        // address
        Elements addrElement = page.select("th:containsOwn(Address) + td");
        String addr = addrElement.text();
        Element addrNextRow = addrElement.parents().first().nextElementSibling();
        if ("".equals(addrNextRow.select("th").text())) {
            addr += " " + addrNextRow.select("td").text();
        }
        Address address = new Address();
        address.setLocation(addr);
        profile.setAddresses(Arrays.asList(new Address[]{address}));

        Date date = parseDate(page.select("th:containsOwn(Excl. Date) + td").text(), DATE_FORMAT);
        if (date != null) {
            profile.setRequestEffectiveDate(date);
        }

        return profile;
    }

    public String getExclusionURL() {
        return exclusionURL != null ? exclusionURL : jndiGet("java:comp/env/mita/config/exclusionURL");
    }
    
    public String getVerificationURL() {
        return verificationURL != null ? verificationURL : jndiGet("java:comp/env/mita/config/verificationURL");
    }
}