/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.DentistryLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.DentistryLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
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
 * This defines the logic for searching for Dentistry Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(DentistryLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class DentistryLicenseDAOBean extends BaseDAO implements DentistryLicenseDAO {

    /**
     * Default empty constructor.
     */
    public DentistryLicenseDAOBean() {
    }

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
            put("licenseNumber", "licenseNumber");
        }
    };

    /**
     * The supported license type mappings for this source.
     */
    private static final Map<String, String> TYPES = new HashMap<String, String>() {
        {
            put("4382", "");
            put("5302", "Conscious Sedation");
            put("4371", "Dental Hygienist");
            put("4380", "Dentist");
            put("4378", "Full Faculty Dentist");
            put("5301", "General Anesthesia");
            put("4381", "Guest Dental Hyg");
            put("4374", "Guest Dentist");
            put("4375", "Guest Reg Dental Asst");
            put("4377", "Limited Faculty Dentist");
            put("5403", "Limited General (LGL)");
            put("4376", "Limited Registration");
            put("4372", "Registered Dental Asst");
            put("4379", "Resident Dentist");
            put("5398", "Resident Provider Dental Hygienist");
            put("5399", "Resident Provider Dental Therapist");
            put("4373", "Specialty Dentist");
        }
    };

    /**
     * Date format used by this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * Searches for providers with Dentistry license using the search filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @Override
    public SearchResult<License> search(DentistryLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "DentistryLicenseDataAccessImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getMiddleName())
            && Util.isBlank(criteria.getFirstName()) && Util.isBlank(criteria.getIdentifier())
            && Util.isBlank(criteria.getCity()) && criteria.getLicenseType() == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getLicenseType() != null) {
            // transform the license type mapping
            boolean found = false;
            for (Map.Entry<String, String> type : TYPES.entrySet()) {
                if (type.getValue().equals(criteria.getLicenseType().getName())) {
                    criteria.getLicenseType().setName(type.getKey());
                    found = true;
                    break;
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10009.getDesc());
            }
        } else {
            LicenseType licenseType = new LicenseType();
            licenseType.setName("4382"); // default
            criteria.setLicenseType(licenseType);
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

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
    private SearchResult<License> getAllResults(DentistryLicenseSearchCriteria criteria) throws URISyntaxException,
        ClientProtocolException, IOException, ParseException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getSearch = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getSearch);

        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));
        HttpPost search = new HttpPost(new URIBuilder(getSearchURL()).build());
        List<License> allLicenses = new ArrayList<License>();

        HttpEntity entity = postForm(
            getSearchURL(),
            client,
            search,
            new String[][]{{"vFirstName", Util.defaultString(criteria.getFirstName())},
                {"vMiddleName", Util.defaultString(criteria.getMiddleName())},
                {"vLastName", Util.defaultString(criteria.getLastName())},
                {"vLicenseNumber", Util.defaultString(criteria.getIdentifier())},
                {"vCity", Util.defaultString(criteria.getCity())},
                {"vLicenseType", criteria.getLicenseType().getName()}, {"ObjectTypeID", "1059"}, {"ObjectID", "40"},
                {"__VIEWSTATE", page.select("input[name=__VIEWSTATE]").first().val()},
                {"__EVENTVALIDATION", page.select("input[name=__EVENTVALIDATION]").first().val()}}, true);

        page = Jsoup.parse(EntityUtils.toString(entity));

        Elements detailButtons = page.select("table#DataTable table input[type=button]");
        for (Element detailButton : detailButtons) {
            String url = detailButton.attr("onclick");
            url = url.replaceFirst("javascript:window.location='./", "");
            url = url.substring(0, url.length() - 2);
            url = url.replaceAll(" ", "+"); // replace spaces

            HttpGet getDetail = new HttpGet(Util.replaceLastURLPart(getSearchURL(), url));
            response = client.execute(getDetail);
            verifyAndAuditCall(getSearchURL(), response);
            Document licenseDetails = Jsoup.parse(EntityUtils.toString(response.getEntity()));
            allLicenses.add(parseLicense(licenseDetails));
        }

        SearchResult<License> searchResult = new SearchResult<License>();
        searchResult.setItems(allLicenses);
        return searchResult;
    }

    /**
     * Parses the Dentistry license details page.
     *
     * @param page the details page
     * @return the parsed license details
     * @throws ParsingException if the expected tags were not found
     */
    private License parseLicense(Document page) throws ParsingException {
        License license = new License();
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        String fullName = page.select("#lblName1").text();
        // remove mr. and ms.
        fullName = fullName.replaceFirst("Mr.", "").replaceFirst("Ms.", "").trim();

        User user = new User();
        profile.setUser(user);
        String[] nameParts = fullName.split(" ");
        user.setLastName(nameParts[nameParts.length - 1]);
        if (nameParts.length > 1) {
            user.setFirstName(nameParts[0]);
        }
        // everything else goes to middle name (per site behavior)
        if (nameParts.length > 2) {
            StringBuffer sb = new StringBuffer();
            for (int i = 1; i < nameParts.length - 1; i++) {
                if (sb.length() > 0) {
                    sb.append(" ");
                }
                sb.append(nameParts[i]);
            }
            user.setMiddleName(sb.toString());
        }

        List<Address> addresses = new ArrayList<Address>();
        Address address = new Address();
        addresses.add(address);
        profile.setAddresses(addresses);
        String fullAddress = page.select("#lblMAddress").text();
        String stateAndZip = fullAddress.substring(fullAddress.lastIndexOf(",") + 1, fullAddress.length()).trim();
        String[] szParts = stateAndZip.split(" ");
        address.setState(szParts[0]);
        address.setZipcode(szParts[1]);
        address.setLocation(fullAddress.substring(0, fullAddress.lastIndexOf(",")).trim());

        LicenseType type = new LicenseType();
        license.setType(type);
        type.setName(page.select("#lblLicType").text());
        license.setLicenseNumber(page.select("#lblLicNum").text());

        LicenseStatus status = new LicenseStatus();
        license.setStatus(status);
        status.setName(page.select("#lblLicStatus").text());

        String issueDate = page.select("#lblFirstLicenseDate").text();
        if (Util.isNotBlank(issueDate)) {
            license.setOriginalIssueDate(parseDate(issueDate, DATE_FORMAT));
        }

        String expirationDate = page.select("#lblDateExpire").text();
        if (Util.isNotBlank(expirationDate)) {
            license.setExpireDate(parseDate(expirationDate, DATE_FORMAT));
        }

        Elements additionals = page.select("table#tblAdditional table td");
        license.setCorrectiveAction(Util.defaultString(additionals.get(6).text()).startsWith("[X]"));
        license.setDiscipline(Util.defaultString(additionals.get(7).text()).startsWith("[X]"));

        return license;
    }

}
