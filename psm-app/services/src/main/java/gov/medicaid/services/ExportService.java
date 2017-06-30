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
package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.UserRequest;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * This represents the service API to export enrollment data for the given user
 * 
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface ExportService {

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
    void export(List<UserRequest> requests, String status, OutputStream outputStream) throws PortalServiceException;

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
    void export(CMSUser currentUser, EnrollmentType enrollment, Map<String, Object> model, OutputStream outputStream)
            throws PortalServiceException, IOException;

}
