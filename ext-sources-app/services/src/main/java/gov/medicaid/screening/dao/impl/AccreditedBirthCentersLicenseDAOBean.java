/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.AccreditedBirthCenter;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.AccreditedBirthCentersLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * This defines the logic for scraping Accredited Birth Centers results.
 * 
 * <p>
 * <strong>Thread Safety:</strong> This is a stateless EJB and is thread-safe.
 * </p>
 * 
 * @author j3_guile
 * @version 1.0
 */
@Stateless
@Local(AccreditedBirthCentersLicenseDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class AccreditedBirthCentersLicenseDAOBean extends BaseDAO implements AccreditedBirthCentersLicenseDAO {
    /**
     * Date format.
     */
    private static final String DATE_FORMAT = "MMMM yyyy";

    /**
     * Default empty constructor.
     */
    public AccreditedBirthCentersLicenseDAOBean() {
    }

    /**
     * This method gets the accredited birth centers.
     * 
     * @return the search result with the accredited birth centers
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<AccreditedBirthCenter> getAccreditedBirthCenters() throws ParsingException, ServiceException {
        String signature = "AccreditedBirthCentersLicenseDAOBean#getAccreditedBirthCenters";
        LogUtil.traceEntry(getLog(), signature, new String[] {}, new Object[] {});

        try {
            SearchResult<AccreditedBirthCenter> results = doSearch();
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (URISyntaxException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (IOException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Searches for all accredited birth centers.
     * 
     * @return the birth centers matched
     * @throws URISyntaxException
     *             if the URL could not be correctly constructed
     * @throws IOException
     *             for any I/O related errors
     * @throws ServiceException
     *             for any other errors encountered
     */
    private SearchResult<AccreditedBirthCenter> doSearch() throws URISyntaxException, IOException, ServiceException {
        List<AccreditedBirthCenter> accreditedBirthCenters = getAllResults();
        SearchResult<AccreditedBirthCenter> allResults = new SearchResult<AccreditedBirthCenter>();
        allResults.setItems(accreditedBirthCenters);
        allResults.setPageNumber(1);
        allResults.setPageSize(0);
        return allResults;
    }

    /**
     * Retrieves all results from the source site.
     * 
     * @return the birth centers matched
     * @throws URISyntaxException
     *             if the URL could not be correctly constructed
     * @throws IOException
     *             for any I/O related errors
     * @throws ServiceException
     *             for any other errors encountered
     */
    private List<AccreditedBirthCenter> getAllResults() throws URISyntaxException, IOException, ServiceException {
        DefaultHttpClient client = new DefaultHttpClient();
        client.setRedirectStrategy(new LaxRedirectStrategy());

        HttpGet getFrontPage = new HttpGet(new URIBuilder(getSearchURL()).build());
        HttpResponse response = client.execute(getFrontPage);

        verifyAndAuditCall(getSearchURL(), response);

        Document page = Jsoup.parse(EntityUtils.toString(response.getEntity()));

        List<AccreditedBirthCenter> allCenters = new ArrayList<AccreditedBirthCenter>();
        Elements rows = page.select("table#wp-table-reloaded-id-1-no-1 tbody tr");
        for (Element row : rows) {
            AccreditedBirthCenter center = parseCenter(row.children());
            if (center != null) {
                allCenters.add(center);
            }
        }
        return allCenters;
    }

    /**
     * Parse the License information.
     * 
     * @param tds
     *            The elements
     * @return parsed license
     */
    private AccreditedBirthCenter parseCenter(Elements tds) {
        AccreditedBirthCenter center = new AccreditedBirthCenter();
        String since = tds.get(0).text();
        Date dateSince = parseDate(since, DATE_FORMAT);
        if (dateSince != null) {
            center.setAccreditedDate(dateSince);
        }
        String fullBirthCenterDetails = tds.get(1).html();

        String[] birthDetailParts = fullBirthCenterDetails.split("<br />");
        center.setName(birthDetailParts[0].replaceAll("\\<.*?>", "").trim());
        center.setBirthCenterAddress(birthDetailParts[1].trim());
        center.setCity(tds.get(2).text());
        center.setState(tds.get(3).text());
        return center;
    }
}
