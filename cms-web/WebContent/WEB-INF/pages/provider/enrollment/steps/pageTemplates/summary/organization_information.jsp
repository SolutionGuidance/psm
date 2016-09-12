<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_15_bound'] eq 'Y'}">
<c:set var="askEffectiveDate" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['askEffectiveDate']}"></c:set>
<c:set var="askFiscalYear" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['askFiscalYear']}"></c:set>
<c:set var="askTaxPayerName" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['askTaxPayerName']}"></c:set>
<c:set var="askDBAName" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['askDBAName']}"></c:set>
<c:set var="useEDILayout" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['useEDILayout']}"></c:set>
<c:set var="useEducationPlanLayout" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['useEducationPlanLayout']}"></c:set>
<c:set var="useNursingFacilityLayout" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['useNursingFacilityLayout']}"></c:set>
<c:set var="askUMPI" value="${viewModel.tabModels['Organization Information'].formSettings['Organization Information Form'].settings['askUMPI']}"></c:set>

<c:choose>
    <c:when test="${useNursingFacilityLayout}">
        <div class="section">
            <div class="wholeCol">
            <div class="row">
                <label>Name of Facility</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_name']}</span>
            </div>
            <div class="row">
                <label>NPI</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_npi']}</span>
            </div>
            <div class="row">
                <label>Street Address</label>
                <span class="floatL"><b>:</b></span>
			    <span>
			        <c:if test="${not empty requestScope['_15_addressLine1']}"><c:out value="${requestScope['_15_addressLine1']}" /><br /></c:if>
			        <c:out value="${requestScope['_15_addressLine2']}" /><br />
			        <c:set var="city" value="${requestScope['_15_city']}" /><c:out value="${city}" /> 
			        <c:set var="state" value="${requestScope['_15_state']}" /><c:if test="${not empty state}">,</c:if>${state}
			        <c:set var="zip" value="${requestScope['_15_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
			        <c:set var="county" value="${requestScope['_15_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
			    </span>
            </div>
            <div class="row">
                <label>Federal Employer ID (FEIN)</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_fein']}</span>
            </div>
            <div class="row">
                <label>TaxPayer Name</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_legalName']}</span>
            </div>
            <div class="row">
                <label>MN TAX ID </label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_stateTaxId']}</span>
            </div>
            <div class="row">
                <label>Fiscal Year End</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_fye1']}</span>
            </div>
            <div class="row">
                <label>Office Phone Number</label>
                <span class="floatL"><b>:</b></span>
                <span>
                ${requestScope['_15_phone1']}<c:if test="${requestScope['_15_phone2'] ne ''}"> - </c:if>${requestScope['_15_phone2']}<c:if test="${requestScope['_15_phone3'] ne ''}"> - </c:if>${requestScope['_15_phone3']}<c:if test="${requestScope['_15_phone4'] ne ''}"> ext. </c:if>${requestScope['_15_phone4']}
                </span>
            </div>
            <div class="row">
                <label>Office Fax Number</label>
                <span class="floatL"><b>:</b></span>
                <span>
                ${requestScope['_15_fax1']}<c:if test="${requestScope['_15_fax2'] ne ''}"> - </c:if>${requestScope['_15_fax2']}<c:if test="${requestScope['_15_fax3'] ne ''}"> - </c:if>${requestScope['_15_fax3']}
                </span>
            </div>
            <div class="row">
                <label>Facility County</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_orgCountyName']}</span>
            </div>
            </div>
            <div class="clearFixed"></div>
        </div>
    </c:when>
    
    <c:when test="${useEducationPlanLayout}">
        <div class="section">
            <div class="wholeCol">
            <div class="row">
                <label>Complete Provider Name</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_name']}</span>
            </div>
            <div class="row">
                <label>NPI</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_npi']}</span>
            </div>
            <div class="row">
                <label>Actual Street Address</label>
                <span class="floatL"><b>:</b></span>
                <span>
                    <c:if test="${not empty requestScope['_15_addressLine1']}"><c:out value="${requestScope['_15_addressLine1']}" /><br /></c:if>
                    <c:out value="${requestScope['_15_addressLine2']}" /><br />
                    <c:set var="city" value="${requestScope['_15_city']}" /><c:out value="${city}" /> 
                    <c:set var="state" value="${requestScope['_15_state']}" /><c:if test="${not empty state}">,</c:if>${state}
                    <c:set var="zip" value="${requestScope['_15_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
                    <c:set var="county" value="${requestScope['_15_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
                </span>
            </div>
            <div class="row">
                <label>County</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_orgCountyName']}</span>
            </div>
            <div class="row">
                <label>Federal Employer ID (FEIN)</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_fein']}</span>
            </div>
            <div class="row">
                <label>Legal Name According to the IRS</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_legalName']}</span>
            </div>
            <div class="row">
                <label>MN TAX ID </label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_stateTaxId']}</span>
            </div>
            <div class="row">
                <label>Fiscal Year End</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_fye1']}</span>
            </div>
            <div class="row">
                <label>Phone Number</label>
                <span class="floatL"><b>:</b></span>
                <span>
                ${requestScope['_15_phone1']}<c:if test="${requestScope['_15_phone2'] ne ''}"> - </c:if>${requestScope['_15_phone2']}<c:if test="${requestScope['_15_phone3'] ne ''}"> - </c:if>${requestScope['_15_phone3']}<c:if test="${requestScope['_15_phone4'] ne ''}"> ext. </c:if>${requestScope['_15_phone4']}
                </span>
            </div>
            <div class="row">
                <label>Fax Number</label>
                <span class="floatL"><b>:</b></span>
                <span>
                ${requestScope['_15_fax1']}<c:if test="${requestScope['_15_fax2'] ne ''}"> - </c:if>${requestScope['_15_fax2']}<c:if test="${requestScope['_15_fax3'] ne ''}"> - </c:if>${requestScope['_15_fax3']}
                </span>
            </div>
            <div class="row">
                <label>Requested Enrollment Date</label>
                <span class="floatL"><b>:</b></span>
                <span>${requestScope['_15_effectiveDate']}</span>
            </div>
            </div>
            <div class="clearFixed"></div>
        </div>
    </c:when>
    
    <c:when test="${useEDILayout}">
		<div class="section">
		    <div class="leftCol">
		        <div class="row">
		            <label>Type</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_subType']}</span>
		        </div>
		        <div class="row">
		            <label>Organization Name</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_name']}</span>
		        </div>
		        <div class="row">
		            <label>Federal Employer ID (FEIN)</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_fein']}</span>
		        </div>
		        <div class="row">
		            <label>MN Tax Id</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_stateTaxId']}</span>
		        </div>
		        <div class="row">
		            <label>Legal Name</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_legalName']}</span>
		        </div>
		        <div class="row">
		            <label>Address</label>
		            <span class="floatL"><b>:</b></span>
	                <span>
	                    <c:if test="${not empty requestScope['_15_addressLine1']}"><c:out value="${requestScope['_15_addressLine1']}" /><br /></c:if>
	                    <c:out value="${requestScope['_15_addressLine2']}" /><br />
	                    <c:set var="city" value="${requestScope['_15_city']}" /><c:out value="${city}" /> 
	                    <c:set var="state" value="${requestScope['_15_state']}" /><c:if test="${not empty state}">,</c:if>${state}
	                    <c:set var="zip" value="${requestScope['_15_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
	                    <c:set var="county" value="${requestScope['_15_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
	                </span>
		        </div>
		        <div class="row">
		            <label>Phone Number</label>
		            <span class="floatL"><b>:</b></span>
		            <span>
                        ${requestScope['_15_phone1']}<c:if test="${requestScope['_15_phone2'] ne ''}"> - </c:if>${requestScope['_15_phone2']}<c:if test="${requestScope['_15_phone3'] ne ''}"> - </c:if>${requestScope['_15_phone3']}<c:if test="${requestScope['_15_phone4'] ne ''}"> ext. </c:if>${requestScope['_15_phone4']}
		            </span>
		        </div>
		    </div>
		    <!-- /.leftCol -->
		    <div class="rightCol">
		        <div class="row">
		            <label>&nbsp;</label>
		            <span class="address">&nbsp;<br/>&nbsp;</span>
		        </div>
		        <div class="row">
		            <label>Legal Name</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_legalName']}</span>
		        </div>
		        <div class="row">
		            <label>Fax Number</label>
		            <span class="floatL"><b>:</b></span>
		            <span>
                    ${requestScope['_15_fax1']}<c:if test="${requestScope['_15_fax2'] ne ''}"> - </c:if>${requestScope['_15_fax2']}<c:if test="${requestScope['_15_fax3'] ne ''}"> - </c:if>${requestScope['_15_fax3']}
		            </span>
		        </div>
		        <div class="row">
		            <label>UMPI</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_npi']}</span>
		        </div>
		        <c:if test="${showNameOfPersonFillingTheForm}">
			        <div class="row">
			            <label>Name of person completing this form</label>
			            <span class="floatL"><b>:</b></span>
			            <span>${requestScope['_15_personCompletingForm']}</span>
			        </div>
			    </c:if>
		    </div>
		    <div class="clearFixed"></div>
        </div>
    </c:when>
    <c:otherwise>
		<div class="section">
		    <div class="leftCol">
		        <div class="row">
			        <c:choose>
			        	<c:when test="${askUMPI}">
			        		<label>UMPI</label>
			        	</c:when>
			        	<c:otherwise>
			        		<label>NPI</label>
			        	</c:otherwise>
			        </c:choose>	
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_npi']}</span>
		        </div>
		        <div class="row">
		            <label>${askDBAName ? 'DBA Name' : 'Doing Business As'}</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_name']}</span>
		        </div>
		        <div class="row">
		            <label>Practice Address</label>
		            <span class="floatL"><b>:</b></span>
                    <span>
                        <c:if test="${not empty requestScope['_15_addressLine1']}"><c:out value="${requestScope['_15_addressLine1']}" /><br /></c:if>
                        <c:out value="${requestScope['_15_addressLine2']}" /><br />
                        <c:set var="city" value="${requestScope['_15_city']}" /><c:out value="${city}" /> 
                        <c:set var="state" value="${requestScope['_15_state']}" /><c:if test="${not empty state}">,</c:if>${state}
                        <c:set var="zip" value="${requestScope['_15_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
                        <c:set var="county" value="${requestScope['_15_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
                    </span>
		        </div>
		        <div class="row">
		            <label>Office Phone Number</label>
		            <span class="floatL"><b>:</b></span>
		
				    <span>
                        ${requestScope['_15_phone1']}<c:if test="${requestScope['_15_phone2'] ne ''}"> - </c:if>${requestScope['_15_phone2']}<c:if test="${requestScope['_15_phone3'] ne ''}"> - </c:if>${requestScope['_15_phone3']}<c:if test="${requestScope['_15_phone4'] ne ''}"> ext. </c:if>${requestScope['_15_phone4']}
				    </span>
		        </div>
		        <div class="row">
		            <label>Federal Employer ID (FEIN)</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_fein']}</span>
		        </div>
	            <c:if test="${askFiscalYear}">
		            <div class="row">
		                <label>Fiscal Year End</label>
		                <span class="floatL"><b>:</b></span>
		                <span>${requestScope['_15_fye1']}</span>
		            </div>
	            </c:if>
		    </div>
		    <!-- /.leftCol -->
		    <div class="rightCol">
	            <c:if test="${askEffectiveDate}">
			        <div class="row">
			            <label>Effective Date</label>
			            <span class="floatL"><b>:</b></span>
			            <span>${requestScope['_15_effectiveDate']}</span>
			        </div>
		        </c:if>
		        <div class="row">
		            <label>${askTaxPayerName ? 'Taxpayer Name' : 'Legal Name'}</label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_legalName']}</span>
		        </div>
		        <div class="row">
		            <label>&nbsp;</label>
		            <span class="address">&nbsp;<br/>&nbsp;</span>
		        </div>
		        <div class="row">
		            <label>Office Fax Number</label>
		            <span class="floatL"><b>:</b></span>
		            <span>
                        ${requestScope['_15_fax1']}<c:if test="${requestScope['_15_fax2'] ne ''}"> - </c:if>${requestScope['_15_fax2']}<c:if test="${requestScope['_15_fax3'] ne ''}"> - </c:if>${requestScope['_15_fax3']}
		            </span>
		        </div>
		        <div class="row">
		            <label>MN TAX ID </label>
		            <span class="floatL"><b>:</b></span>
		            <span>${requestScope['_15_stateTaxId']}</span>
		        </div>
		    </div>
		    <div class="clearFixed"></div>
		</div>
    </c:otherwise>
</c:choose>
<c:if test="${not useEDILayout}">
<div class="section line">
    <div class="leftCol">
        <div class="row">
            <label>Billing Address</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_15_billingSameAsPrimary'] eq 'Y'}">Same As Above</c:if>
            <c:if test="${requestScope['_15_billingSameAsPrimary'] ne 'Y'}">
                <span>
                    <c:if test="${not empty requestScope['_15_billingAttention']}"><c:out value="${requestScope['_15_billingAttention']}" /><br /></c:if>
                    <c:if test="${not empty requestScope['_15_billingAddressLine1']}"><c:out value="${requestScope['_15_billingAddressLine1']}" /><br /></c:if>
                    <c:out value="${requestScope['_15_billingAddressLine2']}" /><br />
                    <c:set var="city" value="${requestScope['_15__billingCity']}" /><c:out value="${city}" /> 
                    <c:set var="state" value="${requestScope['_15__billingState']}" /><c:if test="${not empty state}">,</c:if>${state}
                    <c:set var="zip" value="${requestScope['_15__billingZip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
                    <c:set var="county" value="${requestScope['_15__billingCounty']}" /><c:if test="${not empty county}">,</c:if>${county} 
                </span>
            </c:if>
        </div>
        <div class="row">
            <label>1099 Address</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_15_ten99SameAsPrimary'] eq 'Y'}">Same As Above</c:if>
            <c:if test="${requestScope['_15_ten99SameAsPrimary'] ne 'Y'}">
                <span>
                    <c:if test="${not empty requestScope['_15_ten99Attention']}"><c:out value="${requestScope['_15_ten99Attention']}" /><br /></c:if>
                    <c:if test="${not empty requestScope['_15_ten99AddressLine1']}"><c:out value="${requestScope['_15_ten99AddressLine1']}" /><br /></c:if>
                    <c:out value="${requestScope['_15_ten99AddressLine2']}" /><br />
                    <c:set var="city" value="${requestScope['_15__ten99City']}" /><c:out value="${city}" /> 
                    <c:set var="state" value="${requestScope['_15__ten99State']}" /><c:if test="${not empty state}">,</c:if>${state}
                    <c:set var="zip" value="${requestScope['_15__ten99Zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
                    <c:set var="county" value="${requestScope['_15__ten99County']}" /><c:if test="${not empty county}">,</c:if>${county} 
                </span>
            </c:if>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
<div class="section line">
    <div class="leftCol">
        <div class="row">
            <label>Contact Name</label>
            <span class="floatL"><b>:</b></span>
            <span class="address">${requestScope['_15_contactName']}</span>
        </div>
        <div class="row">
            <label>Contact Phone Number</label>
            <span class="floatL"><b>:</b></span>
            <span>
            ${requestScope['_15_contactPhone1']}<c:if test="${requestScope['_15_contactPhone2'] ne ''}"> - </c:if>${requestScope['_15_contactPhone2']}<c:if test="${requestScope['_15_contactPhone3'] ne ''}"> - </c:if>${requestScope['_15_contactPhone3']}<c:if test="${requestScope['_15_contactPhone4'] ne ''}"> ext. </c:if>${requestScope['_15_contactPhone4']}
            </span>
        </div>
        <div class="row">
            <label>Contact Fax Number</label>
            <span class="floatL"><b>:</b></span>
            <span>
            ${requestScope['_15_contactFax1']}<c:if test="${requestScope['_15_contactFax2'] ne ''}"> - </c:if>${requestScope['_15_contactFax2']}<c:if test="${requestScope['_15_contactFax3'] ne ''}"> - </c:if>${requestScope['_15_contactFax3']}
            </span>
        </div>
        <div class="row">
            <label>Contact Email Address</label>
            <span class="floatL"><b>:</b></span>
            <span>${requestScope['_15_contactEmail']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>