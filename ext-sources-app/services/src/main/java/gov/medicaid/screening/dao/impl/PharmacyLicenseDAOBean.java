/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.PharmacyLicenseSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.PharmacyLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
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
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for searching for Pharmacy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(PharmacyLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class PharmacyLicenseDAOBean extends BaseDAO implements PharmacyLicenseDAO {

    /**
     * Date format for this source.
     */
    private static final String DATE_FORMAT = "MM/dd/yyyy";

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "profile.user.firstName");
            put("lastName", "profile.user.lastName");
            put("licenseNumber", "licenseNumber");
            put("licenseType", "type.name");
            put("originalIssueDate", "originalIssueDate");
            put("expireDate", "expireDate");
            put("status", "status.name");
            put("discipline", "discipline");
        }
    };

    /**
     * Searches for Pharmacy licenses using the first name, business name, last name or license number.
     *
     * @param criteria The search criteria
     * @return the pharmacy licenses.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    @Override
    public SearchResult<License> search(PharmacyLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "PharmacyLicenseDataAccessImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        String firstNameOrBusinessName = null;
        String lastName = null;
        String licenseNumber = null;

        if (!Util.isBlank(criteria.getIdentifier())) {
            licenseNumber = criteria.getIdentifier();
        } else if (!Util.isBlank(criteria.getFirstName()) || !Util.isBlank(criteria.getLastName())) {
            firstNameOrBusinessName = criteria.getFirstName();
            lastName = criteria.getLastName();
        } else {
            firstNameOrBusinessName = criteria.getBusinessName();
        }

        if (Util.isBlank(firstNameOrBusinessName) && Util.isBlank(lastName) && Util.isBlank(licenseNumber)) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(firstNameOrBusinessName, lastName, licenseNumber);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());
            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
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
     * @param firstOrBusinessName First or Business name.
     * @param lastName Last name.
     * @param licenseNumber License number.
     * @return the search result for licenses
     * @throws URISyntaxException When an error occurs while building the URL.
     * @throws ClientProtocolException When client does not support protocol used.
     * @throws IOException When an error occurs while parsing response.
     * @throws ParseException When an error occurs while parsing response.
     */
    private SearchResult<License> getAllResults(String firstOrBusinessName, String lastName, String licenseNumber)
        throws URISyntaxException, ClientProtocolException, IOException, ParseException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        String path = "/mnbop/GLSuiteWeb/Clients/MNBOPharm/Public/";
        URIBuilder builder = new URIBuilder(getSearchURL()).setPath(path + "LicenseeSearch.aspx");

        HttpGet httpget = new HttpGet(builder.build());
        HttpEntity entity = client.execute(httpget).getEntity();
        Document page = Jsoup.parse(EntityUtils.toString(entity));

        HttpPost httppost = new HttpPost(builder.build());
        List<NameValuePair> parameters = new ArrayList<NameValuePair>();
        parameters.add(new BasicNameValuePair("__VIEWSTATE", page.select("#__VIEWSTATE").first().val()));
        parameters.add(new BasicNameValuePair("__VIEWSTATEENCRYPTED", page.select("#__VIEWSTATEENCRYPTED").first().val()));
        parameters.add(new BasicNameValuePair("__EVENTVALIDATION", page.select("#__EVENTVALIDATION").first().val()));
        parameters.add(new BasicNameValuePair("ObjectID", page.select("#ObjectID").first().val()));
        parameters.add(new BasicNameValuePair("ObjectTypeID", page.select("#ObjectTypeID").first().val()));
        parameters.add(new BasicNameValuePair("waFirstName", Util.defaultString(firstOrBusinessName)));
        parameters.add(new BasicNameValuePair("waLastName", Util.defaultString(lastName)));
        parameters.add(new BasicNameValuePair("waLicenseNumber", Util.defaultString(licenseNumber)));

        httppost.setEntity(new UrlEncodedFormEntity(parameters, Charset.forName("UTF-8")));
        HttpResponse postResponse = client.execute(httppost);

        entity = postResponse.getEntity();
        // licenses list
        List<License> licenseList = new ArrayList<License>();
        if (entity != null) {
            page = Jsoup.parse(EntityUtils.toString(entity));
            Elements trs = page.select("table#DataTable a");
            if (trs != null) {
                for (Element element : trs) {
                    String href = element.attr("href");
                    HttpGet detailsGet = new HttpGet(getSearchURL() + path + href);
                    HttpResponse detailsResponse = client.execute(detailsGet);
                    HttpEntity detailsEntity = detailsResponse.getEntity();
                    if (detailsEntity != null) {
                        Document details = Jsoup.parse(EntityUtils.toString(detailsEntity));
                        licenseList.add(parseLicense(details));
                    }
                }
            }
        }
        SearchResult<License> result = new SearchResult<License>();
        result.setItems(licenseList);
        return result;
    }

    /**
     * Parse License information.
     *
     * @param details The html document.
     * @return the license information
     * @throws ParseException When an error occurs while parsing the dates.
     */
    private License parseLicense(Document details) throws ParseException {
        String name = details.select("span#lblName2").text();
        String address = details.select("span#lblAddress").text();
        String licenseType = details.select("span#lblLicenseType").text();
        String licenseNumber = details.select("span#lblLicenseNumber").text();
        String licenseStatus = details.select("span#lblLicenseStatus").text();
        String originalIssueDate = details.select("span#lblOriginalIssueDate").text();
        String expirationDate = details.select("span#lblExpirationDate").text();
        String disciplinaryAction = details.select("span#lblDisciplinaryAction").text();

        License license = new License();
        license.setLicenseNumber(licenseNumber);
        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        User user = new User();
        if (name.lastIndexOf(" ") > -1) {
            String firstName = name.substring(0, name.lastIndexOf(" ")).trim();
            String lastName = name.substring(name.lastIndexOf(" "), name.length()).trim();
            user.setFirstName(firstName);
            user.setLastName(lastName);
        } else {
            user.setLastName(name);
        }

        List<Address> addresses = new ArrayList<Address>();
        addresses.add(parseAddress(address.trim()));
        profile.setAddresses(addresses);
        profile.setUser(user);

        LicenseType licType = new LicenseType();
        licType.setName(licenseType);
        license.setType(licType);

        Date issueDate = parseDate(originalIssueDate, DATE_FORMAT);
        if (issueDate != null) {
            license.setOriginalIssueDate(issueDate);
        }
        Date expireDate = parseDate(expirationDate, DATE_FORMAT);
        if (expireDate != null) {
            license.setExpireDate(expireDate);
        }
        LicenseStatus status = new LicenseStatus();
        status.setName(licenseStatus);
        license.setStatus(status);

        license.setDiscipline(!"No".equals(disciplinaryAction.trim()));
        return license;
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
}