/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Degree;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.MedicalPracticeLicenseSearchCriteria;
import gov.medicaid.entities.MedicalSchool;
import gov.medicaid.entities.PrivatePractice;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.Sex;
import gov.medicaid.entities.Specialty;
import gov.medicaid.entities.SpecialtyType;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.MedicalPracticeLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for searching for Medical Practice Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Local(MedicalPracticeLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class MedicalPracticeLicenseDAOBean extends BaseDAO implements MedicalPracticeLicenseDAO {

    /**
     * Date format for this source.
     */
    private static final String DATE_FORMAT = "MM-dd-yyyy";

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "profile.user.firstName");
            put("lastName", "profile.user.lastName");
            put("licenseType", "type.name");
            put("licenseNumber", "licenseNumber");
            put("originalIssueDate", "originalIssueDate");
            put("expireDate", "expireDate");
            put("status", "status.name");
            put("disciplineBdOrder", "disciplineBdOrder");
            put("correctiveAction", "correctiveAction");
            put("degree", "profile.degree");
            put("medicalSchool", "medicalSchool");
        }
    };

    /**
     * Searches for providers with Medical Practice license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    public SearchResult<License> searchByName(MedicalPracticeLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "MedicalPracticeLicenseDataAccessImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getFirstName())
            && Util.isBlank(criteria.getIdentifier()) && Util.isBlank(criteria.getCity())) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria, true);
            SearchResult<License> results = trimResults(allResults, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());

            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ClientProtocolException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (URISyntaxException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (IOException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        } catch (ParseException e) {
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        }
    }

    /**
     * Searches for providers with Medical Practice license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    public SearchResult<License> searchBySpecialty(MedicalPracticeLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "MedicalPracticeLicenseDataAccessImpl#searchBySpecialty";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (criteria.getSpecialty() == null) {
            throw new ServiceException(ErrorCode.MITA10006.getDesc());
        }

        if (criteria.getSpecialty().getCode() <= 0 && Util.isBlank(criteria.getSpecialty().getName())) {
            throw new ServiceException(ErrorCode.MITA10006.getDesc());
        }

        validateSortOptions(criteria, SORT_COLUMNS);

        try {
            SearchResult<License> allResults = getAllResults(criteria, false);
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
     * @param criteria The search criteria.
     * @param byName flag indicating it is a search by name.
     * @return the search result for licenses
     * @throws URISyntaxException if an error occurs while building the URL.
     * @throws ClientProtocolException if client does not support protocol used.
     * @throws IOException if an error occurs while parsing response.
     * @throws ParseException if an error occurs while parsing response.
     * @throws ServiceException for any other problems encountered
     */
    private SearchResult<License> getAllResults(MedicalPracticeLicenseSearchCriteria criteria, boolean byName)
        throws URISyntaxException, ClientProtocolException, IOException, ParseException, ServiceException {

        DefaultHttpClient client = new DefaultHttpClient();

        URIBuilder builder = new URIBuilder(getSearchURL()).setPath("/BMP/DesktopModules/ServiceForm.aspx");
        String hostId = builder.toString();
        builder.setParameter("svid", "30").setParameter("mid", "176");

        HttpGet httpget = new HttpGet(builder.build());
        HttpResponse landing = client.execute(httpget);
        Document document = Jsoup.parse(EntityUtils.toString(landing.getEntity()));

        HttpPost httppost = new HttpPost(builder.build());

        HttpEntity entity = postForm(hostId, client, httppost,
            new String[][]{{"__EVENTTARGET", byName ? "_ctl7_rblSearchOption_0" : "_ctl7_rblSearchOption_1"},
                {"__EVENTARGUMENT", ""}, {"_ctl7:rblSearchOption", byName ? "Name" : "Specialty"},
                {"__VIEWSTATE", document.select("#Form1 input[name=__VIEWSTATE]").first().val()}}, true);

        document = Jsoup.parse(EntityUtils.toString(entity));
        httppost.releaseConnection();

        if (byName) {
            entity = postForm(
                hostId,
                client,
                httppost,
                new String[][]{{"__EVENTTARGET", ""}, {"__EVENTARGUMENT", ""}, {"_ctl7:cmdSearch", "Search"},
                    {"_ctl7:rblSearchOption", "Name"}, {"_ctl7:txtCity", Util.defaultString(criteria.getCity())},
                    {"_ctl7:txtFirstName", Util.defaultString(criteria.getFirstName())},
                    {"_ctl7:txtLastName", Util.defaultString(criteria.getLastName())},
                    {"_ctl7:txtLicNbr", Util.defaultString(criteria.getIdentifier())},
                    {"__VIEWSTATE", document.select("#Form1 input[name=__VIEWSTATE]").first().val()}}, true);
        } else {

            String code = matchSpecialtyCode(criteria, document);
            entity = postForm(
                hostId,
                client,
                httppost,
                new String[][]{{"__EVENTTARGET", ""}, {"__EVENTARGUMENT", ""}, {"_ctl7:cmdSearchSpecialty", "Search"},
                    {"_ctl7:ddlbSpecialty", code}, {"_ctl7:rblSearchOption", "Specialty"},
                    {"_ctl7:txtSpecialtyCity", Util.defaultString(criteria.getCity())},
                    {"_ctl7:txtSpecialtyZip", Util.defaultString(criteria.getZipcode())},
                    {"__VIEWSTATE", document.select("#Form1 input[name=__VIEWSTATE]").first().val()}}, true);
        }

        // licenses list
        List<License> licenseList = new ArrayList<License>();
        if (entity != null) {
            String result = EntityUtils.toString(entity);
            document = Jsoup.parse(result);
            Elements rows = document
                .select("#_ctl7_grdSearchResults tr.TableItem, #_ctl7_grdSearchResults tr.TableAlternatingItem");
            for (Element row : rows) {
                String href = row.select("a[name=Hyperlink1]").first().attr("href");
                String city = row.select("td:eq(4)").text();

                String detailsLink = getSearchURL() + "/BMP/DesktopModules/" + href.replaceAll(" ", "%20");
                HttpGet detailsGet = new HttpGet(detailsLink);
                HttpResponse detailsResponse = client.execute(detailsGet);
                HttpEntity detailsEntity = detailsResponse.getEntity();
                if (detailsEntity != null) {
                    Document details = Jsoup.parse(EntityUtils.toString(detailsEntity));
                    licenseList.add(parseLicense(city, details));
                }
            }
        }

        SearchResult<License> result = new SearchResult<License>();
        result.setItems(licenseList);
        return result;
    }

    /**
     * Searches for the available specialty options matching the criteria.
     *
     * @param criteria the criteria for specialty search
     * @param document the current page
     * @return the matched code
     * @throws ServiceException if the code provided is not present
     */
    private String matchSpecialtyCode(MedicalPracticeLicenseSearchCriteria criteria, Document document)
        throws ServiceException {
        Elements specialtyOptions = document.select("select#_ctl7_ddlbSpecialty option");
        Specialty specialty = criteria.getSpecialty();
        String code = null;
        boolean found = false;
        for (Element option : specialtyOptions) {
            code = option.attr("value");
            if (Util.isNotBlank(specialty.getName())) { // match the name
                if (specialty.getName().equalsIgnoreCase(option.text())) {
                    if (specialty.getCode() > 0 && Integer.parseInt(code) != specialty.getCode()) {
                        throw new ServiceException(ErrorCode.MITA10007.getDesc());
                    }
                    found = true;
                    break;
                }
            } else { // match only the code
                if (Integer.parseInt(code) == specialty.getCode()) {
                    found = true;
                    break;
                }
            }
        }
        if (!found) {
            throw new ServiceException(ErrorCode.MITA10007.getDesc());
        }
        return code;
    }

    /**
     * Parse the License information.
     *
     * @param city the license provider city
     * @param details the details page
     * @return the parsed license
     */
    private License parseLicense(String city, Document details) {
        License license = new License();
        license.setCity(city);

        ProviderProfile profile = new ProviderProfile();
        license.setProfile(profile);

        String fullName = details.select("#_ctl7_lblName").text();
        User user = new User();
        String[] nameParts = fullName.split(",");
        if (nameParts.length > 0) {
            user.setLastName(nameParts[0].trim());
        }
        if (nameParts.length > 1) {
            user.setFirstName(nameParts[1].trim());
        }
        profile.setUser(user);

        String licenseType = details.select("#_ctl7_ProfileInfoLicense_lblLicType").text();
        LicenseType licType = new LicenseType();
        licType.setName(licenseType);
        license.setType(licType);

        String licenseNo = details.select("#_ctl7_ProfileInfoLicense_lblLicNbr").text();
        license.setLicenseNumber(licenseNo);

        String licensureAddress1 = details.select("#_ctl7_ProfileInfoPublic_lblAddress").text();
        String licensureAddress2 = details.select("#_ctl7_ProfileInfoPublic_lblAddress2").text();
        String licensureCityState = details.select("#_ctl7_ProfileInfoPublic_lblCity").text();
        Address address = new Address();
        address.setLocation(licensureAddress1 + " " + licensureAddress2);
        setCityStateZip(address, licensureCityState);

        String email = details.select("#_ctl7_ProfileInfoPublic_lblEmail").text();
        profile.setContactEmail(email);
        String birthYear = details.select("#_ctl7_ProfileInfoPublic_lblBirthYear").text();
        if (Util.isNotBlank(birthYear)) {
            profile.setDob(new GregorianCalendar(Integer.parseInt(birthYear), Calendar.JANUARY, 1).getTime());
        }

        String gender = details.select("#_ctl7_ProfileInfoPublic_lblGender").text();
        if ("Male".equals(gender)) {
            profile.setSex(Sex.MALE);
        } else if ("Female".equals(gender)) {
            profile.setSex(Sex.FEMALE);
        }

        String expirationDate = details.select("#_ctl7_ProfileInfoLicense_lblExpDate").text();
        String originalIssueDate = details.select("#_ctl7_ProfileInfoLicense_lblGrantDate").text();

        Date issueDate = parseDate(originalIssueDate, DATE_FORMAT);
        if (issueDate != null) {
            license.setOriginalIssueDate(issueDate);
        }

        Date expireDate = parseDate(expirationDate, DATE_FORMAT);
        if (expireDate != null) {
            license.setExpireDate(expireDate);
        }

        String licenseStatus = details.select("#_ctl7_ProfileInfoLicense_lblLicStatus").text();
        LicenseStatus status = new LicenseStatus();
        status.setName(licenseStatus);
        license.setStatus(status);

        String disciplinaryAction = details.select("#_ctl7_ProfileInfoLicense_lblDiscAction").text();
        String correctiveAction = details.select("#_ctl7_ProfileInfoLicense_lblCorrAction").text();

        license.setDiscipline(!"No".equals(disciplinaryAction.trim()));
        license.setCorrectiveAction(!"No".equals(correctiveAction.trim()));

        String medSchool = details.select("#_ctl7_ProfileInfoEducation_lblName").text();
        MedicalSchool medicalSchool = new MedicalSchool();
        medicalSchool.setName(medSchool);
        license.setMedicalSchool(medicalSchool);

        String degree = details.select("#_ctl7_ProfileInfoEducation_lblDegree").text();
        if ("PhD".equals(degree.trim())) {
            profile.setDegree(Degree.DOCTORATE);
        } else if (!Util.isBlank(degree)) {
            profile.setDegree(Degree.MASTER);
        }

        PrivatePractice privatePractice = new PrivatePractice();
        profile.setPrivatePractice(privatePractice);

        String primaryAddressName = details.select("#_ctl7_ProfileInfoPractices_lblPrimaryName").text();
        String primaryAddress1 = details.select("#_ctl7_ProfileInfoPractices_lblPrimaryAddress").text();
        String primaryCityState = details.select("#_ctl7_ProfileInfoPractices_lblPrimaryAddress2").text();
        String primaryPhone = details.select("#_ctl7_ProfileInfoPractices_lblPrimaryPhone").text();
        if (Util.isNotBlank(primaryAddressName) || Util.isNotBlank(primaryAddress1)
            || Util.isNotBlank(primaryCityState)) {
            Address primary = new Address();
            address.setLocation(primaryAddressName + " " + primaryAddress1);
            setCityStateZip(primary, primaryCityState);
            privatePractice.setOfficeAddress(primary);
        }
        privatePractice.setOfficePhoneNumber(primaryPhone);

        String secondaryAddressName = details.select("#_ctl7_ProfileInfoPractices_lblSecondaryName").text();
        String secondaryAddress1 = details.select("#_ctl7_ProfileInfoPractices_lblSecondaryAddress").text();
        String secondaryCityState = details.select("#_ctl7_ProfileInfoPractices_lblSecondaryAddress2").text();
        String secondaryPhone = details.select("#_ctl7_ProfileInfoPractices_lblSecondaryPhone").text();

        if (Util.isNotBlank(secondaryAddressName) || Util.isNotBlank(secondaryAddress1)
            || Util.isNotBlank(secondaryCityState)) {
            Address secondary = new Address();
            address.setLocation(secondaryAddressName + " " + secondaryAddress1);
            setCityStateZip(secondary, secondaryCityState);
            privatePractice.setSecondaryAddress(secondary);
        }

        privatePractice.setSecondaryPhoneNumber(secondaryPhone);

        Elements specialties = details.select("#_ctl7_ProfileInfoSpecialty_dgSpecialty tr:gt(0)");
        List<Specialty> sps = new ArrayList<Specialty>();
        for (Element element : specialties) {
            Specialty sp = new Specialty();
            SpecialtyType spt = new SpecialtyType();
            spt.setName(element.select("td:eq(0)").text());
            sp.setType(spt);
            sp.setName(element.select("td:eq(1)").text());
            sps.add(sp);
        }
        profile.setSpecialties(sps);
        return license;
    }

    /**
     * Parses the city/state and zip information from an address line.
     *
     * @param address the address to set the parsed information to
     * @param fullAddress the address line to parse
     */
    private static void setCityStateZip(Address address, String fullAddress) {
        int citySeparator = fullAddress.indexOf(",");
        if (citySeparator > -1) {
            address.setCity(fullAddress.substring(0, citySeparator));
        }
        int zipSeparator = fullAddress.lastIndexOf(" ");
        if (zipSeparator > -1) {
            address.setZipcode(fullAddress.substring(zipSeparator, fullAddress.length()).trim());
        } else {
            zipSeparator = fullAddress.length();
        }
        address.setState(fullAddress.substring(citySeparator + 1, zipSeparator).trim());
        address.setCountry("US");
    }
}
