/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.verification;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.IOUtils;

/**
 * Base client for verification services.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class BaseSOAPClient {

    /**
     * Used to adapt the request to the target service.
     */
    private final String requestXSLT;

    /**
     * Used to adapt the response from the target service.
     */
    private final String responseXSLT;

    /**
     * Assigns the given values to the field with the same name.
     * @param requestXSLT the path to the request XSLT file
     * @param responseXSLT the path to the response XSLT file
     */
    protected BaseSOAPClient(String requestXSLT, String responseXSLT) {
        this.requestXSLT = requestXSLT;
        this.responseXSLT = responseXSLT;
    }

    /**
     * Transforms the given request.
     * @param xsltFile the transformation file to use
     * @param request the request to be transformed
     * @return the transformation result
     * @throws TransformerException for any transformation errors
     */
    protected String transform(String xsltFile, String request) throws TransformerException {
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer = tFactory.newTransformer(new StreamSource(getClass().getResourceAsStream(xsltFile)));
        StringWriter writer = new StringWriter();
        transformer.transform(new StreamSource(new StringReader(request)), new StreamResult(writer));
        return writer.toString();
    }

    /**
     * Invokes the web service using the request provided.
     *
     * @param serviceURL the end point reference
     * @param original the payload
     * @return the response
     * @throws IOException for IO errors while executing the request
     * @throws TransformerException for any transformation errors
     */
    protected String invoke(String serviceURL, String original) throws IOException, TransformerException {
        URL url = new URL(serviceURL);
        HttpURLConnection rc = (HttpURLConnection) url.openConnection();
        rc.setRequestMethod("POST");
        rc.setDoOutput(true);
        rc.setDoInput(true);
        rc.setRequestProperty("Content-Type", "text/xml; charset=utf-8");

        System.out.println("before transform:" + original);
        String request = transform(requestXSLT, original);
        System.out.println("after transform:" + request);

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
            String response = IOUtils.toString(read);
            System.out.println("actual result:" + response);
            String transformedResponse = transform(responseXSLT, response);
            System.out.println("transformed result:" + transformedResponse);
            return transformedResponse;
        } finally {
            read.close();
            rc.disconnect();
        }
    }

}
