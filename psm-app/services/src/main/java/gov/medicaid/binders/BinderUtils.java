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

package gov.medicaid.binders;

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.entities.Address;
import gov.medicaid.services.util.Util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Utility methods for binding data.
 */
public class BinderUtils {

    /**
     * Empty strings.
     */
    private static final String[] EMPTY_STRINGS = new String[] {"", "", "", ""};

    /**
     * Default date format.
     */
    private static final String MM_DD_YYYY = "MM/dd/yyyy";

    /**
     * Default timestamp format.
     */
    private static final String TS_FMT = "MM/dd/yyyy hh:mm a";

    /**
     * Private constructor.
     */
    private BinderUtils() {
    }

    /**
     * Binds the given parameter as a calendar.
     *
     * @param parameter the value to convert
     * @return the converted value
     * @throws BinderException if the value is not in the expected format
     */
    public static Calendar getAsCalendar(String parameter) throws BinderException {
        if (Util.isBlank(parameter)) {
            return null;
        }
        SimpleDateFormat df = new SimpleDateFormat(MM_DD_YYYY);
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(df.parse(parameter));
        } catch (ParseException e) {
            throw new BinderException("Could not covert value to a valid date: " + parameter);
        }

        if (!parameter.equals(df.format(cal.getTime()))) {
            throw new BinderException("Could not covert value to a valid date: " + parameter);
        }
        return cal;
    }

    /**
     * Retrieves the full name of the given individual.
     *
     * @param individual the individual
     * @return the concatenated first and last name
     */
    public static String getFullName(IndividualApplicantType individual) {
        return (individual.getFirstName() + " " + individual.getLastName()).trim();
    }

    /**
     * Converts the given calendar to a string.
     *
     * @param value the value to convert
     * @return the formatted date
     */
    public static String formatCalendar(Calendar value) {
        if (value == null) {
            return "";
        }
        return formatDate(value.getTime());
    }

    /**
     * Converts the given date to a string.
     *
     * @param value the value to convert
     * @return the formatted date
     */
    public static String formatDate(Date value) {
        if (value == null) {
            return "";
        }
        return new SimpleDateFormat(MM_DD_YYYY).format(value);
    }

    /**
     * Retrieves the given object as long.
     *
     * @param objectId the object id
     * @return the long value
     */
    public static long getAsLong(String objectId) {
        if (objectId == null) {
            return 0;
        }

        try {
            return Long.parseLong(objectId);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    /**
     * Retrieves the given object as double.
     *
     * @param objectId the object id
     * @return the long value
     */
    public static double getAsDouble(String objectId) {
        if (objectId == null) {
            return 0;
        }

        try {
            return Double.parseDouble(objectId);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    /**
     * Converts the calendar value to a date.
     *
     * @param value the value to convert
     * @return the converted value
     */
    public static Date toDate(Calendar value) {
        if (value == null) {
            return null;
        }
        return value.getTime();
    }

    /**
     * Converts the given date to a calendar.
     *
     * @param value the value to convert
     * @return the converted value
     */
    public static Calendar toCalendar(Date value) {
        if (value == null) {
            return null;
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(value);
        return cal;
    }

    /**
     * Splits the phone number into the required UI parts.
     *
     * @param phoneNumber the number to be split
     * @return the split number
     */
    public static String[] splitPhone(String phoneNumber) {
        if (Util.isBlank(phoneNumber)) {
            return EMPTY_STRINGS;
        }

        phoneNumber = phoneNumber.replaceAll(" ext ", "ext");
        int start = 0;
        int first = phoneNumber.indexOf(" ");
        if (first < 0) {
            return new String[] {phoneNumber.substring(start), "", "", ""};
        }

        int second = phoneNumber.indexOf("-", first + 1);
        if (second < 0) {
            return new String[] {phoneNumber.substring(start, first), phoneNumber.substring(first + 1), "", ""};
        }

        int third = phoneNumber.indexOf("ext", second + 1);
        if (third < 0) {
            return new String[] {phoneNumber.substring(start, first), phoneNumber.substring(first + 1, second),
                phoneNumber.substring(second + 1), ""};
        }

        return new String[] {phoneNumber.substring(start, first), phoneNumber.substring(first + 1, second),
            phoneNumber.substring(second + 1, third), phoneNumber.substring(third + 3)};
    }

    /**
     * Rebuilds the phone from the given parts.
     *
     * @param p1 the first part
     * @param p2 the second part
     * @param p3 the third part
     * @param p4 the extension part
     * @return the rebuilt number
     */
    public static String concatPhone(String p1, String p2, String p3, String p4) {
        StringBuffer sb = new StringBuffer();
        if (Util.isNotBlank(p1)) {
            sb.append(p1.trim());
        }
        sb.append(" ");
        if (Util.isNotBlank(p2)) {
            sb.append(p2.trim());
        }
        sb.append("-");
        if (Util.isNotBlank(p3)) {
            sb.append(p3.trim());
        }
        if (Util.isNotBlank(p4)) {
            sb.append(" ext ");
            sb.append(p4.trim());
        }

        if (" -".equals(sb.toString())) {
            return null;
        }
        return sb.toString();
    }

    /**
     * Rebuilds the fiscal from the given parts.
     *
     * @param p1 the first part
     * @param p2 the second part
     * @return the rebuilt fiscal year
     */
    public static String concatFiscalYearEnd(String p1, String p2) {
        StringBuffer sb = new StringBuffer();
        if (Util.isNotBlank(p1)) {
            sb.append(p1);
        }
        sb.append("/");
        if (Util.isNotBlank(p2)) {
            sb.append(p2);
        }
        if ("/".equals(sb.toString())) {
            return null;
        }
        return sb.toString();
    }

    /**
     * Splits the fiscal year into the required UI parts.
     *
     * @param fiscalYearEnd the fiscal year to be split
     * @return the split number
     */
    public static String[] splitFiscalYear(String fiscalYearEnd) {
        if (Util.isBlank(fiscalYearEnd)) {
            return EMPTY_STRINGS;
        }

        int start = 0;
        int first = fiscalYearEnd.indexOf("/");
        return new String[] {fiscalYearEnd.substring(start, first), fiscalYearEnd.substring(first + 1)};
    }

    /**
     * Maps the given address to HBM.
     *
     * @param xbAddress the address to be converted
     * @return the converted address
     */
    public static Address bindAddress(AddressType xbAddress) {
        if (xbAddress == null) {
            return null;
        }
        Address hbAddress = new Address();
        hbAddress.setAttentionTo(xbAddress.getAttentionTo());
        hbAddress.setLine1(xbAddress.getAddressLine1());
        hbAddress.setLine2(xbAddress.getAddressLine2());
        hbAddress.setCity(xbAddress.getCity());
        hbAddress.setState(xbAddress.getState());
        hbAddress.setZipcode(xbAddress.getZipCode());
        hbAddress.setCounty(xbAddress.getCounty());
        return hbAddress;
    }

    /**
     * Maps the given address to XML.
     *
     * @param hbAddress the address to be converted
     * @return the converted address
     */
    public static AddressType bindAddress(Address hbAddress) {
        if (hbAddress == null) {
            return null;
        }

        AddressType xbAddress = new AddressType();
        xbAddress.setAttentionTo(hbAddress.getAttentionTo());
        xbAddress.setAddressLine1(hbAddress.getLine1());
        xbAddress.setAddressLine2(hbAddress.getLine2());
        xbAddress.setCity(hbAddress.getCity());
        xbAddress.setState(hbAddress.getState());
        xbAddress.setZipCode(hbAddress.getZipcode());
        xbAddress.setCounty(hbAddress.getCounty());
        return xbAddress;
    }

    /**
     * Formats the given value as a timestamp.
     *
     * @param value the value to format
     * @return the formatted string value
     */
    public static String formatCalendarTS(Calendar value) {
        if (value == null) {
            return "";
        }
        return new SimpleDateFormat(TS_FMT).format(value.getTime());
    }

    /**
     * Clones the given object.
     *
     * @param obj the object to clone
     * @param <T> the type to be cloned
     * @return the clone
     */
    @SuppressWarnings("unchecked")
    public static <T extends Serializable> T clone(T obj) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(baos);
            oos.writeObject(obj);

            ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
            ObjectInputStream ois = new ObjectInputStream(bais);
            return (T) ois.readObject();
        } catch (IOException e) {
            throw new IllegalStateException("Could not clone profile.", e);
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Could not clone profile.", e);
        }
    }

    /**
     * Replaces a document from the attachment set.
     * @param attachments the attachment set
     * @param id the id of the document
     * @param value the name of the document
     */
    public static void replaceDocument(AttachedDocumentsType attachments, String id, String value) {
        List<DocumentType> toRemove = new ArrayList<DocumentType>();
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType doc : attachment) {
            if (id.equals(doc.getObjectId())) {
                doc.setName(value);
            } else if (value.equals(doc.getName())) {
                toRemove.add(doc);
            }
        }
        attachments.getAttachment().removeAll(toRemove);
    }

    /**
     * Unbinds uploaded files from this request.
     *
     * @param attachments the current attachment list
     * @param attachmentObjectId the attachment to be unbound
     */
    public static void unbindAttachment(AttachedDocumentsType attachments, String attachmentObjectId) {
        List<DocumentType> attachment = attachments.getAttachment();
        synchronized (attachment) {
            for (Iterator<DocumentType> iter = attachment.iterator(); iter.hasNext();) {
                DocumentType doc = (DocumentType) iter.next();
                if (attachmentObjectId.equals(doc.getObjectId())) {
                    iter.remove();
                    break;
                }
            }
        }
    }

    /**
     * Unbinds uploaded files from this request.
     *
     * @param attachments the current attachment list
     * @param attachmentObjectId the attachment to be unbound
     */
    public static void unbindAttachmentByName(AttachedDocumentsType attachments, String name) {
        List<DocumentType> attachment = attachments.getAttachment();
        synchronized (attachment) {
            for (Iterator<DocumentType> iter = attachment.iterator(); iter.hasNext();) {
                DocumentType doc = (DocumentType) iter.next();
                if (name.equals(doc.getName())) {
                    iter.remove();
                    break;
                }
            }
        }
    }

    /**
     * Removes the SSN formatting.
     * @param param the ssn submitted
     * @return the unformatted version
     */
    public static String unformatSSN(String param) {
        if (param == null) {
            return null;
        }
        return param.replaceAll("[^\\d]", "");
    }

    /**
     * Formats the SSN.
     * @param ssn the value to be formatted
     * @return the formatted value
     */
    public static String formatSSN(String ssn) {
        if (ssn == null) {
            return null;
        }

        StringBuilder sb = new StringBuilder(ssn);
        if (sb.length() > 3) {
            sb.insert(3, '-');
        }

        if (sb.length() > 6) {
            sb.insert(6, '-');
        }
        return sb.toString();
    }
}
