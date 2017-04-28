/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment.sync;

import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;

import java.io.ByteArrayInputStream;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This reads the flat file and merges any changes.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FlatFileImporter {

    /**
     * The class logger.
     */
    private Log log = LogUtil.getLog(getClass().getName());
    
    /**
     * Lookup service for code values.
     */
    private final ProviderEnrollmentService enrollmentService;

    /**
     * Empty constructor.
     */
    public FlatFileImporter() {
        enrollmentService = new CMSConfigurator().getEnrollmentService();
    }
    
    /**
     * Performs the legacy id update.
     * @param bytes the bytes from the MQ message
     * @throws PortalServiceException for any errors encountered.
     */
    public void importContent(byte[] bytes) throws PortalServiceException {
        ByteArrayInputStream stream = new ByteArrayInputStream(bytes);
        String mode = readString(stream, ColumnDef.HEADER_MODE.getWidth());
        String ticketId = readString(stream, ColumnDef.HEADER_PROFILE_ID.getWidth());
        String legacyId = readString(stream, ColumnDef.HEADER_LEGACY_ID.getWidth());
        String sysErr = readString(stream, ColumnDef.HEADER_SYS_ERR.getWidth());
        String dataErr = readString(stream, ColumnDef.HEADER_DATA_ERR.getWidth());
        log.log(Level.INFO, "HEADER_SYS_ERR: " + sysErr);
        if (sysErr.trim().length() > 0) {
            log.log(Level.ERROR, dataErr);
        } else {
            log.log(Level.INFO, "ticketId: " + ticketId);
            log.log(Level.INFO, "legacyId: " + legacyId);
            if (!Util.isDigits(ticketId) && Util.isDigits(legacyId)) {
                log.log(Level.ERROR, "Invalid header. Cannot Process this message.");
            } else {
                try {
                    enrollmentService.updateLegacyId(Long.parseLong(ticketId), legacyId);
                } catch (NumberFormatException e) {
                    throw new PortalServiceException("Invalid profile id.", e);
                }
            }
        }
    }

    /**
     * Reads the next field.
     * @param stream the stream
     * @param len the length of the next field
     * @return the next field.
     */
    private String readString(ByteArrayInputStream stream, int len) {
        byte[] buf = new byte[len];
        stream.read(buf, 0, len);
        return new String(buf).trim();
    }

}