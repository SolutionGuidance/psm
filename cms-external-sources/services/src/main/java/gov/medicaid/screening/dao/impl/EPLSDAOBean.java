/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.Action;
import gov.medicaid.entities.Address;
import gov.medicaid.entities.AgencyIdentifier;
import gov.medicaid.entities.Business;
import gov.medicaid.entities.EPLSSearchCriteria;
import gov.medicaid.entities.NPIType;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.Reference;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.User;
import gov.medicaid.screening.dao.EPLSDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
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
import org.apache.http.impl.client.DefaultHttpClient;
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
@Local(EPLSDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class EPLSDAOBean extends BaseDAO implements EPLSDAO {

    /**
     * The supported columns for this implementation.
     */
    private static final Map<String, String> SORT_COLUMNS = new HashMap<String, String>() {
        {
            put("firstName", "user.firstName");
            put("middleName", "user.middleName");
            put("lastName", "user.lastName");
        }
    };

    /**
     * Default empty constructor.
     */
    public EPLSDAOBean() {
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
    public SearchResult<ProviderProfile> search(EPLSSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "EPLSDataAccessImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        // at least part of the name should be provided(otherwise there are too many results)
        if (Util.isBlank(criteria.getFirstName()) && Util.isBlank(criteria.getLastName())
            && Util.isBlank(criteria.getName())) {
            throw new ServiceException(ErrorCode.MITA10022.getDesc());
        }

        if (criteria.getNpiType() != null) {
            if (criteria.getNpiType() == NPIType.INDIVIDUAL) {
                if (Util.isBlank(criteria.getFirstName()) && Util.isBlank(criteria.getLastName())) {
                    throw new ServiceException(ErrorCode.MITA10022.getDesc());
                }
            } else {
                if (Util.isBlank(criteria.getName())) {
                    throw new ServiceException(ErrorCode.MITA10022.getDesc());
                }
            }
        }

        SearchResult<ProviderProfile> results;
        try {
            results = getAllResults(criteria);
            results = trimResults(results, criteria.getPageSize(), criteria.getPageNumber(),
                SORT_COLUMNS.get(criteria.getSortColumn()), criteria.getSortOrder());
            logSearchEntry(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Performs the actual search.
     *
     * @param criteria the filters
     * @return the mapped results
     * @throws IOException if any IO error is encountered
     * @throws ServiceException for any other errors
     */
    private SearchResult<ProviderProfile> getAllResults(EPLSSearchCriteria criteria) throws IOException,
        ServiceException {
        DefaultHttpClient client = new DefaultHttpClient(getLaxSSLConnectionManager());

        HttpGet getSearch = new HttpGet(getSearchURL());
        HttpResponse response = client.execute(getSearch);
        verifyAndAuditCall(getSearchURL(), response);
        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        // validate search parameters with the source lists
        matchStateOption(page, criteria);
        matchCountryOption(page, criteria);
        matchAgencyOption(page, criteria);
        matchReciprocalOption(page, criteria);
        matchProcurementOption(page, criteria);
        matchNonProcurementOption(page, criteria);
        matchExclusionTypeOption(page, criteria);

        HttpPost search = new HttpPost(getSearchURL());
        HttpEntity entity = postForm(getSearchURL(), client, search, buildParameters(criteria), true);

        // get the xml report
        page = Jsoup.parse(EntityUtils.toString(entity));
        Elements records = page.select("record");
        List<ProviderProfile> allProviders = new ArrayList<ProviderProfile>();
        for (Element record : records) {
            allProviders.add(parseProfile(record));
        }
        SearchResult<ProviderProfile> results = new SearchResult<ProviderProfile>();
        results.setItems(allProviders);
        return results;
    }

    /**
     * Accepts numeric code or state name for filtering US states.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided state id is not a valid code for the state
     */
    private void matchStateOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getUsState())) {
            Elements usStateOptions = page.select("select[name=state]").get(0).select("option");
            boolean found = false;
            for (Element option : usStateOptions) {
                if (Util.isDigits(criteria.getUsState())) {
                    if (option.attr("value").equals(criteria.getUsState())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().split(" ")[0].equals(criteria.getUsState())) {
                        found = true;
                        criteria.setUsState(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10015.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or country name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for the country
     */
    private void matchCountryOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getCountry())) {
            Elements options = page.select("select[name=state]").get(1).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(criteria.getCountry())) {
                    if (option.attr("value").equals(criteria.getCountry())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().split(" ")[0].equals(criteria.getCountry())) {
                        found = true;
                        criteria.setCountry(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10016.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or agency name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for an agency
     */
    private void matchAgencyOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getAgency())) {
            Elements options = page.select("select[name=agency]").get(0).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(criteria.getAgency())) {
                    if (option.attr("value").equals(criteria.getAgency())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().equals(criteria.getAgency())) {
                        found = true;
                        criteria.setAgency(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10017.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or reciprocal name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for CT code (reciprocal)
     */
    private void matchReciprocalOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getReciprocalCode())) {
            Elements options = page.select("select[name=ctcode]").get(0).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(criteria.getReciprocalCode())) {
                    if (option.attr("value").equals(criteria.getReciprocalCode())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().equals(criteria.getReciprocalCode())) {
                        found = true;
                        criteria.setReciprocalCode(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10018.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or procurement name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for CT code (procurement)
     */
    private void matchProcurementOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getProcurementCode())) {
            Elements options = page.select("select[name=ctcode]").get(1).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(criteria.getProcurementCode())) {
                    if (option.attr("value").equals(criteria.getProcurementCode())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().equals(criteria.getProcurementCode())) {
                        found = true;
                        criteria.setProcurementCode(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10019.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or non-procurement name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for CT code (non-procurement)
     */
    private void matchNonProcurementOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (Util.isNotBlank(criteria.getNonProcurementCode())) {
            Elements options = page.select("select[name=ctcode]").get(2).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(criteria.getNonProcurementCode())) {
                    if (option.attr("value").equals(criteria.getNonProcurementCode())) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().equals(criteria.getNonProcurementCode())) {
                        found = true;
                        criteria.setNonProcurementCode(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10020.getDesc());
            }
        }
    }

    /**
     * Accepts numeric code or exclusion name for filtering.
     *
     * @param page the current page.
     * @param criteria the search criteria
     * @throws ServiceException if the provided value is not a valid code for exclusion name
     */
    private void matchExclusionTypeOption(Document page, EPLSSearchCriteria criteria) throws ServiceException {
        if (criteria.getExclusionType() != null && Util.isNotBlank(criteria.getExclusionType().getName())) {
            String value = criteria.getExclusionType().getName();
            Elements options = page.select("select[name=exclusion]").get(0).select("option");
            boolean found = false;
            for (Element option : options) {
                if (Util.isDigits(value)) {
                    if (option.attr("value").equals(value)) {
                        found = true;
                        break;
                    }
                } else {
                    if (option.text().equals(value)) {
                        found = true;
                        criteria.getExclusionType().setName(option.attr("value"));
                        break;
                    }
                }
            }
            if (!found) {
                throw new ServiceException(ErrorCode.MITA10021.getDesc());
            }
        }
    }

    /**
     * Parses the profile from the given record.
     *
     * @param record the record to parse
     * @return the mapped profile
     */
    private ProviderProfile parseProfile(Element record) {
        ProviderProfile prof = new ProviderProfile();

        if (record.select("Name").size() > 0) {
            Business business = new Business();
            business.setName(record.select("Name").first().text());
            prof.setBusiness(business);
        } else {
            User user = new User();
            prof.setUser(user);
            user.setPrefix(record.select("Prefix").text().trim());
            user.setFirstName(record.select("First").text().trim());
            user.setMiddleName(record.select("Middle").text().trim());
            user.setLastName(record.select("Last").text().trim());
            user.setSuffix(record.select("Suffix").text().trim());
        }

        if (record.select("DUNS").size() > 0) {
            String strDuns = record.select("DUNS").first().text();
            if (Util.isDigits(strDuns)) {
                prof.setDuns(Long.parseLong(strDuns));
            }
        }

        // http://apps.topcoder.com/forums/?module=Thread&threadID=759419&start=0&mc=10#1597113

        // change/move #altAddress1 and #altAddress2 into single ProviderProfile#List<Address>
        List<Address> addresses = new ArrayList<Address>();
        Elements allAddresses = record.select("Address");
        for (Element add : allAddresses) {
            Address address = new Address();
            if (add.select("Street1").size() > 0) {
                address.setLocation(add.select("Street1").first().text());
            }
            if (add.select("City").size() > 0) {
                address.setCity(add.select("City").first().text());
            }
            if (add.select("ZIP").size() > 0) {
                address.setZipcode(add.select("ZIP").first().text());
            }
            if (add.select("State").size() > 0) {
                address.setState(add.select("State").first().text());
            }
            addresses.add(address);
        }
        prof.setAddresses(addresses);

        // add List<Reference> field to ProviderProfile and have Reference to hold Reference related fields.
        // <References><Reference>Jones-Price, Antoinette (Primary Record)</Reference></References>
        Elements allReferences = record.select("Reference");
        if (!allReferences.isEmpty()) {
            prof.setReferences(new ArrayList<Reference>());
            for (Element ref : allReferences) {
                Reference reference = new Reference();
                reference.setName(ref.text());
                prof.getReferences().add(reference);
            }
        }

        // add new Entities List<Action> and List<AgencyIdentifier> and have the relevant fields in respective entities.
        Elements allActions = record.select("Action");
        if (!allActions.isEmpty()) {
            prof.setActions(new ArrayList<Action>());
            for (Element act : allActions) {
                Action action = new Action();
                action.setActionDate(parseDate(act.select("ActionDate").text(), "dd-MMM-yyyy"));
                action.setTermDate(parseDate(act.select("TermDate").text(), "dd-MMM-yyyy"));
                action.setCtCode(act.select("CTCode").text());
                action.setAgencyComponent(act.select("AgencyComponent").text());
                action.setCreateDate(parseDate(act.select("EPLSCreateDate").text(), "dd-MMM-yyyy"));
                prof.getActions().add(action);
            }
        }

        Elements allAgencies = record.select("AgencyIdentifier");
        if (!allAgencies.isEmpty()) {
            prof.setAgencyIdentifiers(new ArrayList<AgencyIdentifier>());
            for (Element act : allAgencies) {
                AgencyIdentifier agency = new AgencyIdentifier();
                agency.setType(act.select("Type").text());
                agency.setValue(act.select("Value").text());
                prof.getAgencyIdentifiers().add(agency);
            }
        }

        return prof;
    }

    /**
     * Builds the search parameters for the EPLS search.
     *
     * @param criteria the criteria filter
     * @return the parameters to send
     */
    private String[][] buildParameters(EPLSSearchCriteria criteria) {
        List<String[]> params = new ArrayList<String[]>();
        params.add(new String[]{"active_date1_day", Util.parseDay(criteria.getActionDateFrom(), "-1")});
        params.add(new String[]{"active_date1_month", Util.parseMonth(criteria.getActionDateFrom(), "-1")});
        params.add(new String[]{"active_date1_year", Util.parseYear(criteria.getActionDateFrom(), "-1")});
        params.add(new String[]{"active_date2_day", Util.parseDay(criteria.getActionDateTo(), "-1")});
        params.add(new String[]{"active_date2_month", Util.parseMonth(criteria.getActionDateTo(), "-1")});
        params.add(new String[]{"active_date2_year", Util.parseYear(criteria.getActionDateTo(), "-1")});
        params.add(new String[]{"check_search", ""});
        params.add(new String[]{"create_date1_day", Util.parseDay(criteria.getCreateDateFrom(), "-1")});
        params.add(new String[]{"create_date1_month", Util.parseMonth(criteria.getCreateDateFrom(), "-1")});
        params.add(new String[]{"create_date1_year", Util.parseYear(criteria.getCreateDateFrom(), "-1")});
        params.add(new String[]{"create_date2_day", Util.parseDay(criteria.getCreateDateTo(), "-1")});
        params.add(new String[]{"create_date2_month", Util.parseMonth(criteria.getCreateDateTo(), "-1")});
        params.add(new String[]{"create_date2_year", Util.parseYear(criteria.getCreateDateTo(), "-1")});
        params.add(new String[]{"dosearch", "Search"});
        params.add(new String[]{"first", Util.defaultString(criteria.getFirstName())});
        params.add(new String[]{"last", Util.defaultString(criteria.getLastName())});
        params.add(new String[]{"full_name", Util.defaultString(criteria.getName())});
        params.add(new String[]{"modify_date1_day", Util.parseDay(criteria.getModifyDateFrom(), "-1")});
        params.add(new String[]{"modify_date1_month", Util.parseMonth(criteria.getModifyDateFrom(), "-1")});
        params.add(new String[]{"modify_date1_year", Util.parseYear(criteria.getModifyDateFrom(), "-1")});
        params.add(new String[]{"modify_date2_day", Util.parseDay(criteria.getModifyDateTo(), "-1")});
        params.add(new String[]{"modify_date2_month", Util.parseMonth(criteria.getModifyDateTo(), "-1")});
        params.add(new String[]{"modify_date2_year", Util.parseYear(criteria.getModifyDateTo(), "-1")});
        params.add(new String[]{"exclusion",
            criteria.getExclusionType() == null ? "" : Util.defaultString(criteria.getExclusionType().getName())});
        if (Util.isNotBlank(criteria.getReciprocalCode())) {
            params.add(new String[]{"ctcode", criteria.getReciprocalCode()});
        }
        if (Util.isNotBlank(criteria.getProcurementCode())) {
            params.add(new String[]{"ctcode", criteria.getProcurementCode()});
        }
        if (Util.isNotBlank(criteria.getNonProcurementCode())) {
            params.add(new String[]{"ctcode", criteria.getNonProcurementCode()});
        }
        if (Util.isNotBlank(criteria.getAgency())) {
            params.add(new String[]{"agency", criteria.getAgency()});
        }
        if (Util.isNotBlank(criteria.getUsState())) {
            params.add(new String[]{"state", criteria.getUsState()});
        }
        if (Util.isNotBlank(criteria.getCountry())) {
            params.add(new String[]{"state", criteria.getCountry()});
        }
        params.add(new String[]{"start", "current"});
        params.add(new String[]{"status", "current"});
        params.add(new String[]{"term_date1_day", Util.parseDay(criteria.getTerminationDateFrom(), "-1")});
        params.add(new String[]{"term_date1_month", Util.parseMonth(criteria.getTerminationDateFrom(), "-1")});
        params.add(new String[]{"term_date1_year", Util.parseYear(criteria.getTerminationDateFrom(), "-1")});
        params.add(new String[]{"term_date2_day", Util.parseDay(criteria.getTerminationDateTo(), "-1")});
        params.add(new String[]{"term_date2_month", Util.parseMonth(criteria.getTerminationDateTo(), "-1")});
        params.add(new String[]{"term_date2_year", Util.parseYear(criteria.getTerminationDateTo(), "-1")});
        params.add(new String[]{"getreport", "true"});
        params.add(new String[]{"xml", "true"});

        if (criteria.getNpiType() != null) {
            if (criteria.getNpiType() == NPIType.INDIVIDUAL) {
                params.add(new String[]{"classification", "0"});
            } else {
                params.add(new String[]{"classification", "1"}); // firm
                params.add(new String[]{"classification", "2"}); // vessel
                params.add(new String[]{"classification", "3"}); // entity
            }
        }

        return params.toArray(new String[0][params.size()]);
    }
}