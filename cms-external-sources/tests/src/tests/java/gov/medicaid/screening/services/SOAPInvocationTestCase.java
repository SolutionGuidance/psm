package gov.medicaid.screening.services;
/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import junit.framework.TestCase;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.junit.Assert;

/**
 * Base test case for invoking the web services.
 *
 * @author hanshuai
 * @version 1.0
 */
public class SOAPInvocationTestCase extends TestCase {

    /**
     * Folder containing the test requests.
     */
    private final String testFolder;

    /**
     * Test log directory.
     */
    private final String testLogDir;

    /**
     * Default constructor.
     */
    public SOAPInvocationTestCase() {
        try {
            this.testFolder = getProperty("testFolder");
            this.testLogDir = getProperty("testLogDir");
        } catch (Exception e) {
            throw new ExceptionInInitializerError("invalid test configuration");
        }
    }

    /**
     * Invokes the web service using the request provided.
     *
     * @param serviceURL the end point reference
     * @param request the payload
     * @return the response
     * @throws IOException for IO errors while executing the request
     */
    public String invoke(String serviceURL, String request) throws IOException {
        URL url = new URL(serviceURL);
        HttpURLConnection rc = (HttpURLConnection) url.openConnection();
        rc.setRequestMethod("POST");
        rc.setDoOutput(true);
        rc.setDoInput(true);
        rc.setRequestProperty("Content-Type", "text/xml; charset=utf-8");

        int len = request.length();
        rc.setRequestProperty("Content-Length", Integer.toString(len));
        rc.connect();
        OutputStreamWriter out = new OutputStreamWriter(rc.getOutputStream());
        out.write(request, 0, len);
        out.flush();

        InputStreamReader read;
        try {
            read = new InputStreamReader(rc.getInputStream());
        } catch (IOException e) {
            read = new InputStreamReader(rc.getErrorStream());
        }

        try {
            return IOUtils.toString(read);
        } finally {
            read.close();
            rc.disconnect();
        }
    }

    /**
     * Compares the expected xml from the output of the web service.
     *
     * @param url the service end point
     * @param input the request file
     * @param output the expected output file
     * @throws Exception for any errors encountered.
     */
    protected void matchInvoke(String url, String input, String output) throws Exception {
        String request = FileUtils.readFileToString(new File(testFolder + input));
        String expected = FileUtils.readFileToString(new File(testFolder + output));
        String actual = invoke(url, request);

        FileUtils.write(new File(testLogDir + output), prettyPrint(actual));
        Assert.assertEquals("Response did not match", prettyPrint(expected).toLowerCase(), prettyPrint(actual)
            .toLowerCase());
    }

    /**
     * Formats the xml to make sure white spaces are ignored.
     *
     * @param input the xml to format
     * @return the formatted xml
     * @throws Exception for any errors encountered.
     */
    private String prettyPrint(String input) throws Exception {
        Source xmlInput = new StreamSource(new StringReader(input));
        StringWriter stringWriter = new StringWriter();
        StreamResult xmlOutput = new StreamResult(stringWriter);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        transformerFactory.setAttribute("indent-number", 2);
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.transform(xmlInput, xmlOutput);
        return xmlOutput.getWriter().toString();
    }

    /**
     * Retrieves a property from the test configuration.
     *
     * @param string the property name
     * @return the configured property
     * @throws Exception for any errors encountered.
     */
    protected String getProperty(String string) throws Exception {
        Properties props = new Properties();
        props.load(new FileInputStream("/Users/jerrishvarghese/work/cms/coeci-cms/platform/trunk/development/assembly/ext_sources_integration_2/cms-external-sources/build.properties"));
        props.load(new FileInputStream("/Users/jerrishvarghese/work/cms/coeci-cms/platform/trunk/development/assembly/ext_sources_integration_2/cms-external-sources/test.properties"));
        return props.getProperty(string);
    }
}