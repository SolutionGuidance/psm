/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.util;

import com.lowagie.text.FontFactory;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;

import java.util.Map;

/**
 * Common utility methods.
 */
public class PDFHelper {

    /**
     * Creates a header cell.
     *
     * @param text the header text
     * @param colspan the span of the header
     * @return the generated cell.
     */
    public static PdfPCell createHeaderCell(String text, int colspan) {
        PdfPCell header = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
        header.setBorder(Rectangle.BOTTOM);
        header.setColspan(colspan);
        return header;
    }

    /**
     * Sets the given table to take an entire page with.
     *
     * @param table the table to make full width
     */
    public static void setTableAsFullPage(PdfPTable table) {
        table.getDefaultCell().setBorder(0);
        table.setTotalWidth(72 * 7);
        table.setLockedWidth(true);
    }

    /**
     * Retrieves the namespaced attribute.
     *
     * @param model the view model
     * @param ns the namespace
     * @param name the attribute name
     * @return the attribute value
     */
    public static String value(Map<String, Object> model, String ns, String name) {
        Object val = model.get(ns + name);
        if (val == null) {
            return "";
        }
        return String.valueOf(val);
    }

    /**
     * Retrieves the indexed namespaced attribute.
     *
     * @param model the view model
     * @param ns the namespace
     * @param name the attribute name
     * @param idx the parameter index
     * @return the attribute value
     */
    public static String value(Map<String, Object> model, String ns, String name, int idx) {
        return (String) model.get(ns + name + "_" + idx);
    }

    /**
     * Adds a label and value to the given table.
     *
     * @param table the table to add the elements to
     * @param label the label text
     * @param value the value text
     */
    public static void addLabelValueCell(PdfPTable table, String label, String value) {
        if (Util.isNotBlank(value)) {
            addLabel(table, label);
            addCell(table, value);
            table.completeRow();
        }
    }

    /**
     * Adds a label to the given table.
     *
     * @param table the table to add to
     * @param label the label text
     */
    public static void addLabel(PdfPTable table, String label) {
        PdfPCell key = new PdfPCell(new Phrase(Util.defaultString(label), FontFactory.getFont(
            FontFactory.HELVETICA_BOLD, 8)));
        key.setBorder(Rectangle.NO_BORDER);
        table.addCell(key);
    }

    /**
     * Adds a cell to the given table.
     *
     * @param table the table to add the cell to
     * @param value the value text
     */
    public static void addCell(PdfPTable table, String value) {
        PdfPCell val = new PdfPCell(new Phrase(Util.defaultString(value), FontFactory.getFont(
            FontFactory.HELVETICA, 7)));
        val.setBorder(Rectangle.NO_BORDER);
        val.setHorizontalAlignment(PdfPCell.ALIGN_LEFT);
        table.addCell(val);
    }

    /**
     * Adds a centered cell to the given table.
     *
     * @param table the table to add the cell to
     * @param value the value text
     */
    public static void addCenterCell(PdfPTable table, String value) {
        PdfPCell val = new PdfPCell(
            new Phrase(Util.defaultString(value), FontFactory.getFont(FontFactory.HELVETICA, 7)));
        val.setBorder(Rectangle.NO_BORDER);
        val.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
        val.setVerticalAlignment(PdfPCell.ALIGN_CENTER);
        table.addCell(val);
    }

    /**
     * Formats the given flag to either Yes or No.
     *
     * @param val the value to format
     * @return Yes if the argument is true, otherwise No
     */
    public static String formatBoolean(String val) {
        return "Y".equals(val) ? "Yes" : "N".equals(val) ? "No" : "";
    }

    /**
     * Retrieves the namespaced attribute.
     *
     * @param model the view model
     * @param ns    the namespace
     * @param name  the attribute name
     * @return the attribute value
     */
    public static String getBoolean(
            Map<String, Object> model,
            String ns,
            String name
    ) {
        Object val = model.get(ns + name);
        if (val == null) {
            return "";
        }
        return (Boolean) val ? "Yes" : "No";
    }

    /**
     * Formats the address as string.
     *
     * @param model the view model
     * @param ns the namespace
     * @param pref the prefix for the variables
     * @return the formatted representation
     */
    public static String getAddress(Map<String, Object> model, String ns, String pref) {
        String line1;
        String line2;
        String city;
        String state;
        String zip;
        String county;

        if (pref != null) {
            line1 = value(model, ns, pref + "AddressLine1");
            line2 = value(model, ns, pref + "AddressLine2");
            city = value(model, ns, pref + "City");
            state = value(model, ns, pref + "State");
            zip = value(model, ns, pref + "Zip");
            county = value(model, ns, pref + "County");
        } else {
            line1 = value(model, ns, "addressLine1");
            line2 = value(model, ns, "addressLine2");
            city = value(model, ns, "city");
            state = value(model, ns, "state");
            zip = value(model, ns, "zip");
            county = value(model, ns, "county");
        }

        StringBuilder sb = new StringBuilder();
        if (Util.isNotBlank(line1)) {
            sb.append(" ");
        }
        sb.append(line2);
        if (Util.isNotBlank(city)) {
            sb.append(",");
        }
        sb.append(city);
        if (Util.isNotBlank(state)) {
            sb.append(",");
        }
        sb.append(state);
        if (Util.isNotBlank(zip)) {
            sb.append(",");
        }
        sb.append(zip);
        if (Util.isNotBlank(county)) {
            sb.append(",");
        }
        sb.append(county);
        return sb.toString();
    }

    /**
     * Formats the fiscal year as string.
     *
     * @param model the view model
     * @param ns the namespace
     * @return the formatted representation
     */
    public static String getFiscalYear(Map<String, Object> model, String ns) {
        StringBuilder sb = new StringBuilder();
        String fye1 = value(model, ns, "fye1");
        String fye2 = value(model, ns, "fye2");
        sb.append(fye1);
        if (Util.isNotBlank(fye2)) {
            sb.append("/");
        }
        sb.append(fye2);
        return sb.toString();
    }

    /**
     * Formats the phone as string.
     *
     * @param model the view model
     * @param ns the namespace
     * @param name the prefix for the variables
     * @return the formatted representation
     */
    public static String getPhone(Map<String, Object> model, String ns, String name) {
        StringBuilder sb = new StringBuilder();
        String p1 = value(model, ns, name + "1");
        String p2 = value(model, ns, name + "2");
        String p3 = value(model, ns, name + "3");
        String p4 = value(model, ns, name + "4");
        sb.append(p1);
        if (Util.isNotBlank(p2)) {
            sb.append("-");
        }
        sb.append(p2);
        if (Util.isNotBlank(p3)) {
            sb.append("-");
        }
        sb.append(p3);
        if (Util.isNotBlank(p4)) {
            sb.append("ext.");
        }
        sb.append(p4);
        return sb.toString();
    }
}
