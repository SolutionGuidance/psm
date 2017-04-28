/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.HealthOccupationsProgramCredentialSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.HealthOccupationsProgramCredentialDAO;
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
 * This defines the logic for scraping Health Occupations Program Credential results.
 *
 * <p>
 * <code>Thread Safety</code> This is stateless EJB and is thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@Stateless
@Local(HealthOccupationsProgramCredentialDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class HealthOccupationsProgramCredentialDAOBean extends BaseDAO implements
    HealthOccupationsProgramCredentialDAO {

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "user.firstName");
            put("middleName", "user.middleName");
            put("lastName", "user.lastName");
            put("credential", "credentials");
        }
    };

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * Default empty constructor.
     */
    public HealthOccupationsProgramCredentialDAOBean() {
    }

    /**
     * Searches for health occupations program credentials.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the criteria is null
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(HealthOccupationsProgramCredentialSearchCriteria criteria)
        throws ServiceException {
        String signature = "HealthOccupationsProgramCredentialDAOBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        // site allows blank search so no other validations are performed
        try {
            SearchResult<ProviderProfile> allResults = getAllResults(criteria);
            SearchResult<ProviderProfile> results = trimResults(allResults, criteria.getPageSize(),
                criteria.getPageNumber(), SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());
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
     * @param criteria The search criteria.
     * @return the search result for licenses
     *
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ParseException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<ProviderProfile> getAllResults(HealthOccupationsProgramCredentialSearchCriteria criteria)
        throws URISyntaxException, ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getSearch = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(getSearchURL(), response);
        EntityUtils.consume(response.getEntity());

        String fullSearchURL = Util.replaceLastURLPart(getSearchURL(), "credential_search.do");
        HttpPost search = new HttpPost(new URIBuilder(fullSearchURL).build());
        List<ProviderProfile> allProfiles = new ArrayList<ProviderProfile>();

        HttpEntity entity = postForm(
            fullSearchURL,
            client,
            search,
            new String[][]{{"city", Util.defaultString(criteria.getCity())},
                {"credentialNumber", Util.defaultLongString(criteria.getCredentialNumber())},
                {"firstName", Util.defaultString(criteria.getFirstName())},
                {"lastName", Util.defaultString(criteria.getLastName())},
                {"county", getDefaultValue(criteria.getCounty())},
                {"credentialStatus", getDefaultValue(criteria.getStatus())},
                {"credentialType", getDefaultValue(criteria.getOccupationType())},
                {"discipline", getDefaultValue(criteria.getDiscipline())},
                {"state", getDefaultValue(criteria.getState())}, {"p_action", "search"}}, false);

        Document page = Jsoup.parse(EntityUtils.toString(entity));

        Elements rows = page.select("table.formTable tr:gt(0)");
        for (Element row : rows) {
            allProfiles.add(parseProfile(row.children()));
        }

        SearchResult<ProviderProfile> searchResult = new SearchResult<ProviderProfile>();
        searchResult.setItems(allProfiles);
        return searchResult;
    }

    /**
     * Get default dropdown value if provided is empty.
     *
     * @param value the value to be checked
     * @return default value if parameter is empty
     */
    private String getDefaultValue(String value) {
        return Util.defaultString(value).equals("") ? "ALL" : value;
    }

    /**
     * Get default value for lookup entity.
     *
     * @param lookupEntity the lookup entity
     * @return default value if lookup entity is null
     * @param <T> the type of the entity
     */
    private <T extends LookupEntity> String getDefaultValue(T lookupEntity) {
        return lookupEntity == null ? "ALL" : getDefaultValue(lookupEntity.getName());
    }

    /**
     * Parses the provider profile from the table rows.
     *
     * @param columns the grid columns
     * @return the parsed license details
     * @throws ParsingException if the expected tags were not found
     */
    private ProviderProfile parseProfile(Elements columns) throws ParsingException {
        ProviderProfile profile = new ProviderProfile();

        // Name
        String fullName = columns.get(0).text();
        User user = new User();
        profile.setUser(user);
        String[] nameParts = fullName.split(",");
        user.setLastName(nameParts[0]);

        if (nameParts.length > 1) {
            String[] firstNameParts = nameParts[1].trim().split(" ");
            if (firstNameParts.length == 1) {
                user.setFirstName(nameParts[1].trim());
            }
            // everything else goes to middle name (per site behavior)
            if (firstNameParts.length > 1) {
                user.setFirstName(firstNameParts[0]);
                StringBuffer sb = new StringBuffer();
                for (int i = 1; i <= firstNameParts.length - 1; i++) {
                    if (sb.length() > 0) {
                        sb.append(" ");
                    }
                    sb.append(firstNameParts[i]);
                }
                user.setMiddleName(sb.toString());
            }
        }

        // Credential
        profile.setCredentials(columns.get(1).text());

        // For now place information in License
        List<License> licenses = new ArrayList<License>();
        License license = new License();
        licenses.add(license);
        profile.setLicenses(licenses);

        // Occupation Type
        LicenseType type = new LicenseType();
        license.setType(type);
        type.setName(columns.get(2).text());

        // Credential Status
        LicenseStatus status = new LicenseStatus();
        license.setStatus(status);
        status.setName(columns.get(3).text());

        // Discipline
        license.setDiscipline(!"NO".equals(columns.get(4).text()));

        // Expiration date
        Date expirationDate = parseDate(columns.get(5).text(), DATE_FORMAT);
        if (expirationDate != null) {
            license.setExpireDate(expirationDate);
        }
        // address
        List<Address> addresses = new ArrayList<Address>();
        addresses.add(parseAddress(columns.get(6).text()));
        profile.setAddresses(addresses);

        return profile;
    }

    /**
     * Parse the address string.
     *
     * @param fullHtmlAddress Full HTML address
     * @return address
     */
    private Address parseAddress(String fullHtmlAddress) {
        Address address = new Address();
        String[] addressParts = fullHtmlAddress.split(",");
        if (addressParts.length == 2) { // city, state
            address.setCity(addressParts[0]);
            String stateZipParts = addressParts[1].replaceAll(String.valueOf((char) 160), " ").trim(); // clean the
                                                                                                       // string
            String[] stateZip = Util.cleanArray(stateZipParts.split(" "));
            address.setState(stateZip[0]);
            if (stateZip.length > 1) { // zip
                address.setZipcode(stateZip[1]);
            }
        }
        return address;
    }
}