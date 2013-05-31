/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.epls.www.epls.services.EPLSSearchWebService.EPLSSearchWebService;
import gov.epls.www.epls.services.EPLSSearchWebService.EPLSSearchWebServiceService;
import gov.epls.www.epls.services.EPLSSearchWebService.EPLSSearchWebServiceServiceLocator;
import gov.medicaid.entities.SAMAction;
import gov.medicaid.entities.SAMAddress;
import gov.medicaid.entities.SAMAgency;
import gov.medicaid.entities.SAMReference;
import gov.medicaid.entities.SAMResponse;
import gov.medicaid.entities.SAMSearchCriteria;
import gov.medicaid.sam.EPLSAction;
import gov.medicaid.sam.EPLSAddress;
import gov.medicaid.sam.EPLSAgencyUID;
import gov.medicaid.sam.EPLSReference;
import gov.medicaid.sam.EPLSSearchResponse;
import gov.medicaid.sam.EPLSSearchResult;
import gov.medicaid.sam.OperationSearch;
import gov.medicaid.sam.OperationSsnSearch;
import gov.medicaid.screening.dao.SAMSearchDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import javax.ejb.Local;
import javax.ejb.Stateless;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * This defines the logic for searching for SAM records.
 * 
 * @author flexme
 * @version 1.0
 */
@Stateless
@Local(SAMSearchDAO.class)
public class SAMSearchDAOBean extends BaseDAO implements SAMSearchDAO {
    /**
     * Empty constructor.
     */
    public SAMSearchDAOBean() {
    }

    /**
     * Search the SAM records.
     * 
     * @param criteria
     *            the searching criteria.
     * @return the records.
     * @throws ServiceException
     *             for any exceptions encountered
     */
    public List<SAMResponse> doSearch(SAMSearchCriteria criteria) throws ServiceException {
        String signature = "SAMSearchDAOBean#doSearch";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        if (criteria == null) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        if (Util.isBlank(criteria.getFirstName()) && Util.isBlank(criteria.getMiddleName())
                && Util.isBlank(criteria.getLastName()) && Util.isBlank(criteria.getPartialName())) {
            throw new ServiceException(ErrorCode.MITA10005.getDesc());
        }

        try {
            EPLSSearchWebServiceService service = new EPLSSearchWebServiceServiceLocator();
            EPLSSearchWebService port = service.getEPLSSearchWebService();
            OperationSearch operation = new OperationSearch();
            if (Util.isNotBlank(criteria.getPartialName())) {
                operation.setPartialName(criteria.getPartialName());
            } else {
                operation.setFirst(criteria.getFirstName());
                operation.setMiddle(criteria.getMiddleName());
                operation.setLast(criteria.getLastName());
            }
            return LogUtil.traceExit(getLog(), signature, convertResult(port.doSearch(operation)));
        } catch (javax.xml.rpc.ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (RemoteException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }

    /**
     * Converts the result from <code>EPLSSearchResponse</code> to the list of <code>SAMResponse</code>.
     * 
     * @param response
     *            the original result.
     * @return the converted results.
     */
    private List<SAMResponse> convertResult(EPLSSearchResponse response) {
        List<SAMResponse> results = new ArrayList<SAMResponse>();
        if (response.getResults() != null) {
            for (EPLSSearchResult r : response.getResults()) {
                SAMResponse result = new SAMResponse();
                result.setName(r.getName());
                result.setClassification(r.getClassification());
                result.setExclusionType(r.getExclusionType());

                // convert actions
                EPLSAction[] actions = r.getAction();
                List<SAMAction> resultActions = null;
                if (actions != null) {
                    resultActions = new ArrayList<SAMAction>();
                    for (EPLSAction a : actions) {
                        SAMAction action = new SAMAction();
                        action.setActionDate(a.getActionDate() == null ? null : a.getActionDate().getTime());
                        action.setAgencyComponent(a.getAgencyComponent());
                        action.setCtCode(a.getCtCode());
                        action.setTermDate(a.getTermDate() == null ? null : a.getTermDate().getTime());
                        action.setTermType(a.getTermType());
                        resultActions.add(action);
                    }
                }
                result.setActions(resultActions);

                // convert addresses
                EPLSAddress[] addresses = r.getAddress();
                List<SAMAddress> resultAddresses = null;
                if (addresses != null) {
                    resultAddresses = new ArrayList<SAMAddress>();
                    for (EPLSAddress a : addresses) {
                        SAMAddress address = new SAMAddress();
                        address.setCity(a.getCity());
                        address.setDuns(a.getDuns());
                        address.setProvince(a.getProvince());
                        address.setState(a.getState());
                        address.setStreet1(a.getStreet1());
                        address.setStreet2(a.getStreet2());
                        address.setZip(a.getZip());
                        resultAddresses.add(address);
                    }
                }
                result.setAddresses(resultAddresses);

                // convert agency UID
                EPLSAgencyUID[] uids = r.getAgencyUID();
                List<SAMAgency> resultAgencies = null;
                if (uids != null) {
                    resultAgencies = new ArrayList<SAMAgency>();
                    for (EPLSAgencyUID id : uids) {
                        if (id != null) {
                            SAMAgency agency = new SAMAgency();
                            agency.setUidType(id.getUidType());
                            agency.setUidValue(id.getUidValue());
                            resultAgencies.add(agency);
                        }
                    }
                }
                result.setAgencies(resultAgencies);

                // convert references
                EPLSReference[] references = r.getReference();
                List<SAMReference> resultReferences = null;
                if (response != null) {
                    resultReferences = new ArrayList<SAMReference>();
                    for (EPLSReference ref : references) {
                        SAMReference reference = new SAMReference();
                        reference.setName(ref.getName());
                        reference.setType(ref.getType());
                        resultReferences.add(reference);
                    }
                }
                result.setReferences(resultReferences);

                result.setDescriptions(r.getDescription() == null ? null : Arrays.asList(r.getDescription()));
                results.add(result);
            }
        }

        return results;
    }

    /**
     * Verifies the provider using SSN.
     * 
     * @param ssn
     *            provider ssn
     * @param name
     *            provider name
     * @return return @return true if valid, false if not
     * @throws ServiceException
     *             if any error occur
     */
    public boolean verify(String ssn, String name) throws ServiceException {
        String signature = "SAMSearchDAOBean#doSearch";
        LogUtil.traceEntry(getLog(), signature, new String[] { "ssn", "name" }, new Object[] { ssn, name });
        try {
            EPLSSearchWebServiceService service = new EPLSSearchWebServiceServiceLocator();
            EPLSSearchWebService port = service.getEPLSSearchWebService();
            OperationSsnSearch query = new OperationSsnSearch();
            query.setSsnOrTin(ssn);
            query.setExactName(name);
            EPLSSearchResponse response = port.doSsnSearch(query);
            return LogUtil.traceExit(getLog(), signature, response.getCount() > 0);
        } catch (javax.xml.rpc.ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        } catch (RemoteException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA50001.getDesc(), e);
        }
    }
}
