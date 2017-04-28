/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.NPIResult;
import gov.medicaid.screening.dao.NPINumberLookupDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * This defines the logic for searching for NPI record.
 *
 * @author flexme
 * @version 1.0
 */
@Stateless
@Local(NPINumberLookupDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NPINumberLookupDAOBean extends BaseDAO implements NPINumberLookupDAO {
    /**
     * Empty constructor.
     */
    public NPINumberLookupDAOBean() {
    }

    /**
     * Search the NPI record using the NPI number.
     *
     * @param npi the NPI number.
     * @return the NPI record result.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public NPIResult getNPINumber(String npi) throws ParsingException, ServiceException {
        String signature = "NPINumberLookupDAOBean#getNPINumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"npi"}, new Object[]{npi});

        NPIResult result = null;
        DefaultHttpClient client = new DefaultHttpClient();
        try {
            HttpPost search = new HttpPost(new URIBuilder(getSearchURL() + "/getResults.php").build());
            HttpEntity entity = postForm(
                    getSearchURL(),
                    client,
                    search,
                    new String[][]{{"npi", npi}},
                    false);

            Document page = Jsoup.parse(EntityUtils.toString(entity));
            Elements table = page.select("table");
            if (table.size() != 1) {
                throw new ParsingException(ErrorCode.MITA50002.getDesc());
            }

            Elements trs = table.get(0).select("tr");
            if (trs.size() > 1) {
                result = new NPIResult();
                Elements tds = trs.get(1).children();
                result.setNpi(npi);
                int curInd = 1;
                result.setLastName(getText(tds.get(curInd++)));
                result.setPrefix(getText(tds.get(curInd++)));
                result.setFirstNames(getText(tds.get(curInd++)));
                result.setState(getText(tds.get(curInd++)));
                result.setZip(getText(tds.get(curInd++)));
            }

            return LogUtil.traceExit(getLog(), signature, result);
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
     * Gets the trimmed text of the element.
     *
     * @param element the lement.
     * @return the trimmed text of the element.
     */
    private String getText(Element element) {
        if (element == null) {
            return null;
        }
        String text = element.text().replace(Jsoup.parse("&nbsp;").text(), " ");
        return text.trim();
    }
}
