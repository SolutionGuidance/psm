/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.ResultLogEntry;
import gov.medicaid.entities.SearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SortOrder;
import gov.medicaid.entities.User;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.StatsTrackerService;
import gov.medicaid.screening.services.impl.LogUtil;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.BasicClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.topcoder.util.log.Log;

/**
 * This is the base class for license data access, it contains definitions for common properties and functions.
 * 
 * <strong>This is an abstract class, but defines no mutable properties and is therefore thread-safe, however subclasses
 * may behave differently.</strong>
 * 
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class BaseDAO {
    /**
     * Class logger.
     */
    private final Log log = LogUtil.getLog(getClass().getName());

    /**
     * Flag that indicates if logging is enabled.
     */
    @Resource(name = "mita/config/LoggingOn")
    private boolean loggingOn = true;

    /**
     * Persistence context.
     */
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * Used to update site statistics.
     */
    @EJB
    private StatsTrackerService statsTrackerService;

    /**
     * Host used for search.
     */
    @Resource(name = "mita/config/URL")
    private String searchURL;

    /**
     * Login URL.
     */
    @Resource(name = "mita/config/loginURL")
    private String loginURL;

    /**
     * Username.
     */
    @Resource(name = "mita/config/username")
    private String username;

    /**
     * Password.
     */
    @Resource(name = "mita/config/password")
    private String password;

    /**
     * Default empty constructor.
     */
    protected BaseDAO() {
    }

    /**
     * Trim the results.
     * 
     * @param allResults
     *            All the search results.
     * @param pageSize
     *            The page size requested
     * @param pageNumber
     *            The page number requested
     * @param sortColumn
     *            the sort column
     * @param sortOrder
     *            the sort order
     * @param <T>
     *            the type of the results
     * @return trimmed results
     * @throws ServiceException
     *             for any errors encountered
     */
    @SuppressWarnings("unchecked")
    protected <T extends Object> SearchResult<T> trimResults(SearchResult<T> allResults, int pageSize, int pageNumber,
            String sortColumn, SortOrder sortOrder) throws ServiceException {
        if (pageNumber > 0 && pageSize < 1) {
            throw new ServiceException(ErrorCode.MITA10002.getDesc());
        }

        if (sortColumn != null) {
            Collections.sort(allResults.getItems(), new BeanComparator(sortColumn));
            if (sortOrder == SortOrder.DESC) {
                Collections.reverse(allResults.getItems());
            }
        }

        // trim result
        List<T> trimmedResults = new ArrayList<T>();
        List<T> allResultsList = allResults.getItems();
        if (pageNumber > 0) {
            if (allResultsList != null && !allResultsList.isEmpty()) {
                int fromIndex = pageSize * (pageNumber - 1);
                int toIndex = Math.min(fromIndex + pageSize, allResultsList.size());
                trimmedResults.addAll(allResultsList.subList(fromIndex, toIndex));
            }
        } else {
            trimmedResults.addAll(allResultsList);
        }

        SearchResult<T> result = new SearchResult<T>();
        result.setPageNumber(pageNumber);
        result.setPageSize(pageSize);
        result.setItems(trimmedResults);
        result.setTotal(allResultsList.size());
        if (pageSize > 0) {
            result.setTotalPages((int) Math.ceil((double) allResultsList.size() / pageSize));
        } else {
            result.setTotalPages(allResultsList.isEmpty() ? 0 : 1);
        }
        return result;
    }

    /**
     * Parse a string date into a date object.
     * 
     * @param date
     *            The string date.
     * @param format
     *            the date format expected
     * @return Date object.
     */
    protected Date parseDate(String date, String format) {
        if (date != null && date.trim().length() > 0) {
            try {
                return new SimpleDateFormat(format).parse(date);
            } catch (ParseException e) {
                // ignore
            }
        }
        return null;
    }

    /**
     * Gets the value of the field <code>log</code>.
     * 
     * @return the log
     */
    public Log getLog() {
        if (loggingOn) {
            return log;
        }

        return null;
    }

    /**
     * Logs the executed search.
     * 
     * @param criteria
     *            the criteria used for the search.
     * @throws ServiceException
     *             if saving the log entry fails
     */
    protected void logSearchEntry(SearchCriteria criteria) throws ServiceException {
        ResultLogEntry entry = new ResultLogEntry();
        entry.setCriteria(criteria);
        statsTrackerService.saveLoggedEntry(entry);
    }

    /**
     * Posts the Datagrid form.
     * 
     * @param hostId
     *            the unique host identifier
     * @param client
     *            the client to use
     * @param httppost
     *            the postback resource
     * @param postFragments
     *            the fragments to include
     * @param multipartForm
     *            to use multipart or regular form entity
     * @return the response entity
     * @throws ClientProtocolException
     *             for protocol connection error
     * @throws IOException
     *             for IO related errors
     * @throws ServiceException
     *             if the post execution leads to an error
     */
    protected HttpEntity postForm(String hostId, DefaultHttpClient client, HttpPost httppost, String[][] postFragments,
            boolean multipartForm) throws ClientProtocolException, IOException, ServiceException {
        HttpEntity entity = null;
        if (multipartForm) {
            MultipartEntity multiPartEntity = new MultipartEntity();
            for (String[] params : postFragments) {
                multiPartEntity.addPart(params[0], new StringBody(params[1]));
            }
            entity = multiPartEntity;
        } else {
            List<NameValuePair> parameters = new ArrayList<NameValuePair>();
            for (String[] params : postFragments) {
                parameters.add(new BasicNameValuePair(params[0], params[1]));
            }
            entity = new UrlEncodedFormEntity(parameters);
        }
        httppost.setEntity(entity);
        HttpResponse postResponse = client.execute(httppost);

        verifyAndAuditCall(hostId, postResponse);
        return postResponse.getEntity();
    }

    /**
     * Ensures only readable responses continue to process.
     * 
     * @param hostId
     *            the site host identifier
     * @param response
     *            the execution response
     * @throws ServiceException
     *             if the response is not OK or a redirect.
     */
    protected void verifyAndAuditCall(String hostId, HttpResponse response) throws ServiceException {
        statsTrackerService.updateSourceStats(hostId, response.getStatusLine().getStatusCode());

        int status = response.getStatusLine().getStatusCode();
        if (status != HttpStatus.SC_OK && status != HttpStatus.SC_MOVED_TEMPORARILY
                && status != HttpStatus.SC_MOVED_PERMANENTLY) {
        	try {
				EntityUtils.consume(response.getEntity());
			} catch (IOException e) {
				// ignore
			}
            throw new ServiceException(ErrorCode.MITA50001.getDesc());
        }
    }

    /**
     * Validates the sort column requested.
     * 
     * @param criteria
     *            the requested criteria
     * @param sortColumns
     *            the allowed sort columns
     * @throws ServiceException
     *             for any errors encountered
     */
    protected void validateSortOptions(SearchCriteria criteria, Map<String, String> sortColumns)
            throws ServiceException {
        if (criteria.getSortColumn() != null && criteria.getSortColumn().trim().length() == 0) {
            if (!sortColumns.keySet().contains(criteria.getSortColumn())) {
                throw new ServiceException(ErrorCode.MITA10003.getDesc());
            }
        }
    }

    /**
     * Gets the value of the field <code>searchURL</code>.
     * 
     * @return the searchURL
     */
    public String getSearchURL() {
        return searchURL != null ? searchURL : jndiGet("java:comp/env/mita/config/URL");
    }

    /**
     * Checks if the container properly initialized the injected fields.
     * 
     * @throws ConfigurationException
     *             if any injected field is null
     */
    @PostConstruct
    protected void init() {
        if (statsTrackerService == null) {
            throw new ConfigurationException("The statsTrackerService must be configured.");
        }

        if (Util.isBlank(searchURL)) {
            throw new ConfigurationException("The searchURL must be configured.");
        }

        if (entityManager == null) {
            throw new ConfigurationException("The entityManager must be configured.");
        }
    }

    /**
     * Gets the value of the field <code>entityManager</code>.
     * 
     * @return the entityManager
     */
    public EntityManager getEntityManager() {
        return entityManager;
    }

    /**
     * Trusts the source by default.
     * 
     * @return lax SSL connection manager
     * @throws ServiceException
     *             when an error occurred while setting up SSL connection details
     */
    protected ClientConnectionManager getLaxSSLConnectionManager() throws ServiceException {
        try {
            X509TrustManager tm = new X509TrustManager() {
                /**
                 * Returns null.
                 */
                public X509Certificate[] getAcceptedIssuers() {
                    return null;
                }

                /**
                 * Does nothing.
                 * 
                 * @param chain
                 *            not used
                 * @param authType
                 *            not used
                 */
                public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }

                /**
                 * Does nothing.
                 * 
                 * @param chain
                 *            not used
                 * @param authType
                 *            not used
                 */
                public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }
            };

            SSLContext sslcontext = SSLContext.getInstance("TLS");
            sslcontext.init(null, new TrustManager[] { tm }, null);
            SSLSocketFactory sf = new SSLSocketFactory(sslcontext);
            Scheme https = new Scheme("https", 443, sf);
            Scheme http = new Scheme("http", 80, PlainSocketFactory.getSocketFactory());
            SchemeRegistry sr = new SchemeRegistry();
            sr.register(https);
            sr.register(http);
            return new BasicClientConnectionManager(sr);
        } catch (NoSuchAlgorithmException e) {
            LogUtil.traceError(getLog(), "BaseDAO#getLaxSSLConnectionManager", e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (KeyManagementException e) {
            LogUtil.traceError(getLog(), "BaseDAO#getLaxSSLConnectionManager", e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Parses the provider name.
     * 
     * @param name
     *            the full name
     * @return the parsed provider name
     */
    protected User parsePersonName(String name) {
        User user = new User();
        String[] nameParts = name.split(",");
        if (nameParts.length > 0) {
            user.setLastName(nameParts[0].trim());
        }
        if (nameParts.length > 1) {
            String firstName = nameParts[1].trim();
            String[] firstNameParts = firstName.split(" ");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < firstNameParts.length; i++) {
                String string = firstNameParts[i];
                if (firstNameParts.length > 1 && i == firstNameParts.length - 1) {
                    // if there are more than 2 names, the last is middle name
                    user.setMiddleName(string);
                } else {
                    if (sb.length() > 0) {
                        sb.append(" ");
                    }
                    sb.append(string);
                }
            }
            user.setFirstName(sb.toString());
        }
        return user;
    }

    /**
     * Parses the event target for the JavaScript post back command.
     * 
     * @param postBackJS
     *            the JavaScript command
     * @return the event target
     * @throws ParsingException
     *             if the event target was not found.
     */
    protected String parseEventTarget(String postBackJS) throws ParsingException {
        Pattern pattern = Pattern.compile(".*'(_.*)',");
        Matcher matcher = pattern.matcher(postBackJS);
        boolean matchFound = matcher.find();
        if (matchFound) {
            return matcher.group(1).replaceAll("\\$", ":");
        } else {
            throw new ParsingException(ErrorCode.MITA50002.getDesc());
        }
    }

    /**
     * Gets the value of the field <code>loginURL</code>.
     * 
     * @return the loginURL
     */
    protected String getLoginURL() {
        return loginURL != null ? loginURL : jndiGet("java:comp/env/mita/config/loginURL");
    }

    /**
     * Gets the value of the field <code>username</code>.
     * 
     * @return the username
     */
    protected String getUsername() {
        return username != null ? username : jndiGet("java:comp/env/mita/config/username");
    }

    /**
     * Gets the value of the field <code>password</code>.
     * 
     * @return the password
     */
    protected String getPassword() {
        return password != null ? password : jndiGet("java:comp/env/mita/config/password");
    }

    protected String jndiGet(String name) {
        try {
            return (String) new InitialContext().lookup(name);
        } catch (NamingException e) {
            return null;
        }
    }
}