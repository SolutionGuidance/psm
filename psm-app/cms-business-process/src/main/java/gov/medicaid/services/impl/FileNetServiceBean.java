/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.entities.BinaryContent;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.License;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.FileNetService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.IOUtils;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * This service copies the license files uploaded during enrollment for FileNet.
 *
 * @author cyberjag
 * @version 1.0
 */
@Stateless
@Local(FileNetService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class FileNetServiceBean extends BaseService implements FileNetService {

    /**
     * Represents the filenet folder.
     */
    private String fileNetFolder;

    /**
     * Represents the export PDF Folder.
     */
    private String exportPDFFolder;

    @EJB
    private ProviderEnrollmentService providerEnrollmentService;

    /**
     * This method checks that all required injection fields are in fact provided.
     */
    @PostConstruct
    protected void init() {
        super.init();
        CMSConfigurator config = new CMSConfigurator();
        if (fileNetFolder == null) {
            fileNetFolder = config.getFileNetFolder();
        }
        if (exportPDFFolder == null) {
            exportPDFFolder = config.getExportPDFFolder();
        }
    }

    /**
     * Export the files after enrollment process is completed.
     *
     * @param model
     *            enrollment model
     * @param ticketId
     *            the ticket id
     * @throws PortalServiceException
     *             if any error occurs
     */
    @Override
    public void exportFiles(EnrollmentProcess model, long ticketId) throws PortalServiceException {
        // 1. Create the folder
        File folder = new File(fileNetFolder, UUID.randomUUID().toString());
        folder.mkdir();

        // 2. Copy the Provider PDF and save it to FileNet folder
        ProviderInformationType provider = XMLUtility.nsGetProvider(model);
        File pdfFile = new File(exportPDFFolder, String.valueOf(ticketId));
        BufferedInputStream input = null;
        BufferedOutputStream output = null;
        try {
            output = new BufferedOutputStream(new FileOutputStream(new File(folder.getAbsolutePath(), "Profile.pdf")));
            input = new BufferedInputStream(new FileInputStream(pdfFile));
            IOUtils.copy(input, output);
        } catch (IOException e) {
            throw new PortalServiceException("Failed to create file for FileNet", e);
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException e) {
                    // ignore
                }
            }
            if (output != null) {
                try {
                    output.close();
                } catch (IOException e) {
                    // ignore
                }
            }
        }

        Enrollment enrollment = providerEnrollmentService.getTicketDetails(getSystemUser(), ticketId);
        List<gov.medicaid.entities.Document> attachments = enrollment.getDetails().getAttachments();

        for (gov.medicaid.entities.Document attachment : attachments) {

            BinaryContent content = getEm().find(BinaryContent.class, attachment.getContentId());

            try {
                // 3. Copy the file from DB and save it to FileNet folder
                File file = new File(folder.getAbsolutePath(), attachment.getFilename());
                output = new BufferedOutputStream(new FileOutputStream(file));
                input = new BufferedInputStream(content.getContent().getBinaryStream());
                IOUtils.copy(input, output);

                // 4. Create the XML for the file
                Map<String, String> attributes = new LinkedHashMap<String, String>();
                attributes.put("Document Class", "Provider Enrollment");
                attributes.put("Provider Type", provider.getProviderType());
                if (provider.getApplicantInformation().getOrganizationInformation() != null) {
                    // org provider
                    Organization organization = (Organization) enrollment.getDetails().getEntity();
                    attributes.put("FEIN", organization.getFein());
                    attributes.put("Provider Name", organization.getLegalName());
                    attributes.put("Sub Provider Type", organization.getProviderSubType());
                    attributes.put("Provider Identifier", String.valueOf(organization.getId()));
                } else {
                    // ind provider
                    Person person = (Person) enrollment.getDetails().getEntity();
                    attributes.put("NPI", person.getNpi());
                    attributes.put("SSN", person.getSsn());
                    attributes.put("Provider Name",
                            person.getFirstName() + " " + person.getMiddleName() + " " + person.getLastName());
                    attributes.put("Provider Identifier", String.valueOf(person.getId()));
                }

                License license = (License) getEm().createQuery("from License l where l.attachmentId = :id")
                        .setParameter("id", attachment.getId()).getResultList().get(0);
                attributes.put("In State", license.getIssuingUSState());
                attributes.put("PE Document Type", attachment.getType());
                attributes.put("License Name", license.getType().getDescription());
                String documentName = System.currentTimeMillis() + "_" + attachment.getFilename().toLowerCase()
                        + ".xml";
                attributes.put("Document Name", documentName);
                SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
                attributes.put("Document Date", format.format(license.getOriginalIssueDate()));

                createXML(new File(folder.getAbsolutePath(), documentName), attributes);
            } catch (FileNotFoundException e) {
                throw new PortalServiceException("Failed to create file for FileNet", e);
            } catch (IOException e) {
                throw new PortalServiceException("Failed to create file for FileNet", e);
            } catch (SQLException e) {
                throw new PortalServiceException("Failed to create file for FileNet", e);
            } finally {
                if (input != null) {
                    try {
                        input.close();
                    } catch (IOException e) {
                        // ignore
                    }
                }
                if (output != null) {
                    try {
                        output.close();
                    } catch (IOException e) {
                        // ignore
                    }
                }
            }
        }
    }

    /**
     * Creates the XML.
     *
     * @param outFile
     *            the output file handler
     * @param attributes
     *            the content
     * @throws PortalServiceException
     *             if any error occurs
     */
    private void createXML(File outFile, Map<String, String> attributes) throws PortalServiceException {
        try {
            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

            // root elements
            Document doc = docBuilder.newDocument();
            Element rootElement = doc.createElement("Document");
            doc.appendChild(rootElement);
            for (String key : attributes.keySet()) {
                Element indexVal = doc.createElement("Indexvalue");
                Attr attr = doc.createAttribute("name");
                attr.setValue(key);
                indexVal.setAttributeNode(attr);
                if (attributes.get(key) != null) {
                    indexVal.appendChild(doc.createTextNode(attributes.get(key)));
                }
                rootElement.appendChild(indexVal);
            }
            // write the content into xml file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(outFile);

            transformer.transform(source, result);

        } catch (ParserConfigurationException e) {
            throw new PortalServiceException("Failed to create FileNet xml", e);
        } catch (TransformerException e) {
            throw new PortalServiceException("Failed to create FileNet xml", e);
        }

    }
}
