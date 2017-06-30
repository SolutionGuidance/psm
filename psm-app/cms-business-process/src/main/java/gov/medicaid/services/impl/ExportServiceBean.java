/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.services.impl;

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.binders.FormBinder;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.util.Util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * This class provides an implementation of the ExportService via its Local and Remote interfaces.
 * 
 * <p>
 * <b>Thread Safety</b> This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in
 * the context of being used in a container, it is thread-safe.
 * </p>
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(ExportService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class ExportServiceBean extends BaseService implements ExportService {

    /**
     * Default empty constructor.
     */
    public ExportServiceBean() {
    }

    /**
     * Sets the given table to take an entire page with.
     * 
     * @param table
     *            the table to make full width
     */
    private static void setTableAsFullPage(PdfPTable table) {
        table.getDefaultCell().setBorder(0);
        table.setTotalWidth(72 * 7);
        table.setLockedWidth(true);
    }

    /**
     * Adds a centered cell to the given table.
     * 
     * @param table
     *            the table to add the cell to
     * @param value
     *            the value text
     */
    private static void addCenterCell(PdfPTable table, String value) {
        PdfPCell val = new PdfPCell(
                new Phrase(Util.defaultString(value), FontFactory.getFont(FontFactory.HELVETICA, 7)));
        val.setBorder(Rectangle.NO_BORDER);
        val.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
        table.addCell(val);
    }

    /**
     * Creates a header cell.
     * 
     * @param text
     *            the header text
     * @param colspan
     *            the span of the header
     * @return the generated cell.
     */
    private static PdfPCell createHeaderCell(String text, int colspan) {
        PdfPCell header = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
        header.setBorder(Rectangle.BOTTOM);
        header.setColspan(colspan);
        return header;
    }

    /**
     * Exports the search results into PDF.
     * 
     * @param requests
     *            the list to be exported
     * @param status
     *            the status filter
     * @param outputStream
     *            the stream to export to
     * @throws PortalServiceException
     *             for any errors encountered
     */
    public void export(List<UserRequest> requests, String status, OutputStream outputStream)
            throws PortalServiceException {
        PdfPTable resultTable;
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, outputStream);
            document.open();

            resultTable = new PdfPTable(new float[] { 3, 8, 8, 8, 10, 25, 8, 8, 8 });
            resultTable.getDefaultCell().setBorder(0);
            resultTable.getDefaultCell().setHorizontalAlignment(PdfPCell.ALIGN_CENTER);

            resultTable.setTotalWidth(72 * 7);
            resultTable.setLockedWidth(true);

            resultTable.addCell(createHeaderCell("Enrollments", 9));
            resultTable.completeRow();

            addCenterCell(resultTable, "#");
            addCenterCell(resultTable, "NPI/UMPI");
            addCenterCell(resultTable, "Date Created");
            addCenterCell(resultTable, "Request Type");
            addCenterCell(resultTable, "Provider Type");
            addCenterCell(resultTable, "Provider Name");
            addCenterCell(resultTable, "Risk Level");
            addCenterCell(resultTable, "Status");
            addCenterCell(resultTable, "Status Date");
            resultTable.completeRow();

            int i = 0;
            for (UserRequest userRequest : requests) {
                addCenterCell(resultTable, String.valueOf(++i));
                addCenterCell(resultTable, userRequest.getNpi());
                addCenterCell(resultTable,
                        BinderUtils.formatCalendar(BinderUtils.toCalendar(userRequest.getCreateDate())));
                addCenterCell(resultTable, userRequest.getRequestType());
                addCenterCell(resultTable, userRequest.getProviderType());
                addCenterCell(resultTable, userRequest.getProviderName());
                addCenterCell(resultTable, userRequest.getRiskLevel());
                addCenterCell(resultTable, userRequest.getStatus());
                addCenterCell(resultTable,
                        BinderUtils.formatCalendar(BinderUtils.toCalendar(userRequest.getStatusDate())));
            }

            resultTable.setSpacingAfter(20);
            document.add(resultTable);

            document.close();
        } catch (DocumentException e) {
            throw new PortalServiceException("Export failed, see log for additional details.", e);
        }
    }

    /**
     * Exports the profile into PDF.
     * 
     * @param currentUser
     *            the current user
     * @param enrollment
     *            the enrollment model
     * @param model
     *            the view model
     * @param outputStream
     *            the stream to export to
     * @throws IOException
     *             for read/write errors
     * @throws PortalServiceException
     *             for any other errors encountered
     */
    public void export(CMSUser currentUser, EnrollmentType enrollment, Map<String, Object> model,
            OutputStream outputStream) throws PortalServiceException, IOException {

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, outputStream);
            document.open();
            renderTicket(enrollment, document, model);
            document.close();
        } catch (DocumentException e) {
            throw new PortalServiceException("Export failed, see log for additional details.", e);
        }
    }

    /**
     * Renders the ticket.
     * 
     * @param enrollment
     *            the enrollment
     * @param document
     *            the document to render to
     * @param model
     *            the view model
     * @throws IOException
     *             for read/write errors
     * @throws DocumentException
     *             for PDF related errors
     * @throws PortalServiceException
     *             for any other errors encountered
     */
    private void renderTicket(EnrollmentType enrollment, Document document, Map<String, Object> model)
            throws PortalServiceException, DocumentException, IOException {

        CMSConfigurator config = new CMSConfigurator();
        PresentationService presentationService = config.getPresentationService();
        Map<String, FormBinder> registry = config.getBinderRegistry();
        ViewModel viewModel = presentationService.getProviderViewModel(enrollment.getProviderInformation());

        Map<String, UITabModel> pageModels = viewModel.getTabModels();

        // render all forms from all pages
        for (String page : viewModel.getTabNames()) {
            if (page.equals(ViewStatics.SUMMARY_INFORMATION)) {
                continue;
            }

            PdfPTable pageTitle = new PdfPTable(2);
            setTableAsFullPage(pageTitle);
            pageTitle.addCell(createHeaderCell(page, 2));
            document.add(pageTitle);
            UITabModel pageModel = pageModels.get(page);
            List<String> formNames = pageModel.getFormNames();
            for (String form : formNames) {
                FormBinder binder = registry.get(form);
                if (binder != null) {
                    binder.renderPDF(enrollment, document, model);
                }
            }
        }
    }

}
