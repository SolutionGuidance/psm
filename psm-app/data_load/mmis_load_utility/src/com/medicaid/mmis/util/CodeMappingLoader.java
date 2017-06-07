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
package com.medicaid.mmis.util;

import gov.medicaid.entities.LegacySystemMapping;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.impl.SequenceGeneratorBean;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

/**
 * This is the code mapping loader implementation.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CodeMappingLoader {

    /**
     * The logger.
     */
    private static Logger logger;

    /**
     * Reads the code mapping xls and inserts any unmapped row to the legacy mapping table.
     * @throws InvalidFormatException if the input file is not recognized
     */
    @SuppressWarnings("unchecked")
    public static void main(String[] args) throws IOException, PortalServiceException, InvalidFormatException {
        PropertyConfigurator.configure("log4j.properties");
        logger = Logger.getLogger(CodeMappingLoader.class);
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cms-data-load");
        EntityManager em = emf.createEntityManager();

        Workbook workbook = WorkbookFactory.create(new File("mapping/CodeMapping.xlsx"));
        SequenceGeneratorBean sequence = new SequenceGeneratorBean();
        sequence.setEm(em);

        try {
            em.getTransaction().begin();
            List<LegacySystemMapping> rs = em.createQuery("Select l from LegacySystemMapping l").getResultList();
            for (LegacySystemMapping mapping : rs) {
                em.remove(mapping);
            }
            importSheet(em, sequence, workbook, "ENROLLMENT_STATUS");
            importSheet(em, sequence, workbook, "RISK_LEVEL");
            importSheet(em, sequence, workbook, "SPECIALTY_CODE");
            importSheet(em, sequence, workbook, "LICENSE_TYPE");
            importSheet(em, sequence, workbook, "ISSUING_BOARD");
            importSheet(em, sequence, workbook, "PROVIDER_TYPE");
            importSheet(em, sequence, workbook, "COUNTY_CODE");
            importSheet(em, sequence, workbook, "BEN_OWNER_TYPE");
            importSheet(em, sequence, workbook, "LICENSE_STATUS");
            importSheet(em, sequence, workbook, "COS");
            em.getTransaction().commit();
        } catch (Throwable t) {
            em.getTransaction().rollback();
            logger.error("Could not complete import", t);
            throw new PortalServiceException("Error during import", t);
        }
    }

    private static void importSheet(EntityManager em, SequenceGeneratorBean sequence, Workbook workbook,
        String sheetName) {
        logger.info("Importing legacy mapping from worksheet: " + sheetName);
        Sheet sheet = workbook.getSheet(sheetName);
        Iterator<Row> rowIterator = sheet.rowIterator();
        int total = 0;
        while (rowIterator.hasNext()) {
            Row row = (Row) rowIterator.next();
            if (row.getRowNum() < 1) {
                continue;
            }

            Cell systemIdCell = row.getCell(0);
            Cell codeTypeCell = row.getCell(1);
            Cell internalCodeCell = row.getCell(2);
            Cell externalCodeCell = row.getCell(4);
            if (systemIdCell == null || StringUtils.isBlank(systemIdCell.getStringCellValue())) {
                continue;
            }
            if (codeTypeCell == null || StringUtils.isBlank(codeTypeCell.getStringCellValue())) {
                continue;
            }
            if (internalCodeCell == null || StringUtils.isBlank(internalCodeCell.getStringCellValue())) {
                continue;
            }
            if (externalCodeCell == null || StringUtils.isBlank(externalCodeCell.getStringCellValue())) {
                continue;
            }

            LegacySystemMapping mapping = new LegacySystemMapping();
            mapping.setId(sequence.getNextValue("LEGACY_MAPPING"));
            mapping.setSystemName(systemIdCell.getStringCellValue());
            mapping.setExternalCode(externalCodeCell.getStringCellValue());
            mapping.setInternalCode(internalCodeCell.getStringCellValue());
            mapping.setCodeType(codeTypeCell.getStringCellValue());
            logger.debug("Inserting mapping: " + mapping);
            em.persist(mapping);
            total++;
        }
        logger.info("Total records imported from sheet: " + total);
        System.out.println("Total records imported from sheet[" + sheetName + "] : " + total);
    }
}
