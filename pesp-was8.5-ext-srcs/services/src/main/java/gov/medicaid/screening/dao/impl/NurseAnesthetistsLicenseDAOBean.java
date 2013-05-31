/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.NurseAnesthetistsSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.NurseAnesthetistsLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

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
 * This defines the logic for scraping EPLS exclusion results.
 *
 * <p>
 * <code>Thread Safety</code> This is stateless EJB and is thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@Stateless
@Local(NurseAnesthetistsLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NurseAnesthetistsLicenseDAOBean extends BaseDAO implements NurseAnesthetistsLicenseDAO {

    /**
     * Date format used by the source site.
     */
    private static final String DATE_FORMAT = "MM-dd-yyyy";

    /**
     * Default empty constructor.
     */
    public NurseAnesthetistsLicenseDAOBean() {
    }

    /**
     * Searches for Nurse Anesthetists license.
     *
     * @param criteria the search criteria
     * @return the matched profile
     * @throws IllegalArgumentException if the criteria is null
     * @throws IllegalArgumentException if the last 4 digits of the SSN is not provided
     * @throws IllegalArgumentException if the AANA number is not provided
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public ProviderProfile search(NurseAnesthetistsSearchCriteria criteria) throws ServiceException {
        String signature = "NurseAnesthetistsLicenseDAOBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getSsn() == null || !criteria.getSsn().matches(".*[0-9]{4}$")) {
            throw new IllegalArgumentException(ErrorCode.MITA10025.getDesc());
        }

        if (criteria.getAanaNumber() <= 0) {
            throw new IllegalArgumentException(ErrorCode.MITA10026.getDesc());
        }

        try {
            ProviderProfile result = getProviderProfile(criteria);
            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, result);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Performs the call to the source site, exact match is expected given the parameters.
     *
     * @param criteria the search criteria
     * @return the matched result, null if not found
     * @throws IOException if an I/O error is encountered
     * @throws URISyntaxException if the site URL cannot properly be created
     * @throws ServiceException for any other exceptions encountered
     */
    private ProviderProfile getProviderProfile(NurseAnesthetistsSearchCriteria criteria) throws ServiceException,
        IOException, URISyntaxException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        String searchURL = getSearchURL();
        HttpGet getSearch = new HttpGet(new URIBuilder(searchURL).build());
        HttpResponse response = client.execute(getSearch);
        verifyAndAuditCall(searchURL, response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        HttpPost search = new HttpPost(new URIBuilder(searchURL).build());

        String searchType = "Lookup Certification Status";

        String last4 = criteria.getSsn().substring(criteria.getSsn().length() - 4);
        HttpEntity entity = postForm(searchURL, client, search, new String[][]{{"__EVENTARGUMENT", ""},
            {"__EVENTTARGET", ""}, {"__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val()},
            {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()},
            {"ctl00$PageContent$CertRecert$btnLookup", searchType},
            {"ctl00$PageContent$CertRecert$txtAANANumber", "" + criteria.getAanaNumber()},
            {"ctl00$PageContent$CertRecert$txtSSNLast4", "" + last4}}, true);
        
       
        

        page = Jsoup.parse(EntityUtils.toString(entity));
        Elements message = page.select("#ctl00_PageContent_ucCredentialsControl_lblErrorMessage");
        if (message.size() > 0) {
            if (message.text().startsWith("No individual with a social security number")) {
                // no match, return null
                return null;
            }
        }

        if (criteria.isRecertification()) {
            searchType = "Lookup Recertification Status";
            entity = postForm(searchURL, client, search, new String[][]{{"__EVENTARGUMENT", ""}, {"__EVENTTARGET", ""},
                {"__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val()},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()},
                {"ctl00$PageContent$CertRecert$btnSwapDisplayMode", searchType}}, true);
            page = Jsoup.parse(EntityUtils.toString(entity));
        }
        return parseProvider(page);
    }

    /**
     * Parses the provider details from the response.
     *
     * @param page the response page
     * @return the parsed provider details
     * @throws ParsingException if the page is not of the expected format
     */
    private ProviderProfile parseProvider(Document page) throws ParsingException {
        ProviderProfile profile = new ProviderProfile();
        String fullName = page.select("#ctl00_PageContent_CertRecert_lblMemberName").text();
        if (Util.isBlank(fullName)) { // this should always be present
            throw new ParsingException(ErrorCode.MITA50002.getDesc());
        }
        profile.setUser(parseName(fullName));

        ArrayList<License> licenses = new ArrayList<License>();
        License license = new License();
        licenses.add(license);
        profile.setLicenses(licenses);

        String issueDate = page.select("#ctl00_PageContent_CertRecert_lblInitialCertificationDate").text();
        if (Util.isNotBlank(issueDate)) {
            license.setOriginalIssueDate(parseDate(issueDate, DATE_FORMAT));
        }
        String renewalDate = page.select("#ctl00_PageContent_CertRecert_lblRecertBeginDate").text();
        if (Util.isNotBlank(renewalDate)) {
            license.setRenewalDate(parseDate(renewalDate, DATE_FORMAT));
        }

        String renewalEndDate = page.select("#ctl00_PageContent_CertRecert_lblRecertEndDate").text();
        if (Util.isNotBlank(renewalEndDate)) {
            license.setRenewalDate(parseDate(renewalEndDate, DATE_FORMAT));
        }
        String status = page.select("#ctl00_PageContent_CertRecert_lblRecertStatus").text();
        if (Util.isNotBlank(status)) {
            LicenseStatus licenseStatus = new LicenseStatus();
            licenseStatus.setName(status);
            license.setStatus(licenseStatus);
        }

        String licenseName = page.select("#ctl00_PageContent_CertRecert_lblAnesthesiaProgramName").text();
        if (Util.isNotBlank(licenseName)) {
            LicenseType type = new LicenseType();
            type.setName(licenseName);
            license.setType(type);
        }

        String licenseNo = page.select("#ctl00_PageContent_CertRecert_lblAANANumber").text();
        license.setLicenseNumber(licenseNo);

        String address = page.select("#ctl00_PageContent_CertRecert_lblMemberResidence").text();
        if (Util.isNotBlank(address)) {
            List<Address> addresses = new ArrayList<Address>();
            addresses.add(parseAddress(address));
            profile.setAddresses(addresses);
        }

        return profile;
    }

    /**
     * Parse full address.
     *
     * @param fullAddress The full address.
     * @return the address object.
     */
    private static Address parseAddress(String fullAddress) {
        Address address = new Address();
        int citySeparator = fullAddress.indexOf(",");
        if (citySeparator > -1) {
            address.setCity(fullAddress.substring(0, citySeparator));
        }
        address.setZipcode(fullAddress.substring(fullAddress.lastIndexOf(" "), fullAddress.length()).trim());
        address.setState(fullAddress.substring(citySeparator + 1, fullAddress.lastIndexOf(" ")).trim());
        address.setCountry("US");
        return address;
    }

    /**
     * Parses the full name into a User object.
     *
     * @param fullName the full name displayed on the site
     * @return the parsed name
     */
    private User parseName(String fullName) {
        fullName = fullName.substring(0, fullName.indexOf(",")); // remove certificate title
        User user = new User();
        Stack<String> nameParts = new Stack<String>();
        for (String string : fullName.split(" ")) {
            nameParts.push(string);
        }
        user.setLastName(nameParts.pop());
        if (nameParts.size() > 1) {
            user.setMiddleName(nameParts.pop());
        }
        StringBuffer sb = new StringBuffer();
        while (!nameParts.isEmpty()) {
            sb.insert(0, nameParts.pop() + " ");
        }
        user.setFirstName(sb.toString().trim());
        return user;
    }
}