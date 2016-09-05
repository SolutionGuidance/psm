<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="row">
    <label>Private Practice Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_name']}</span>
</div>
<div class="row">
    <label>Effective Date</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_effectiveDate']}</span>
</div>
<div class="row">
    <label>Group NPI/UMPI</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_npi']}</span>
</div>
<div class="row">
    <label>Practice Address</label>
    <span class="floatL"><b>:</b></span>
    <span>
		<c:if test="${not empty requestScope['_05_addressLine1']}"><c:out value="${requestScope['_05_addressLine1']}" /><br /></c:if>
		<c:out value="${requestScope['_05_addressLine2']}" /><br />
		<c:set var="city" value="${requestScope['_05_city']}" /><c:out value="${city}" /> 
		<c:set var="state" value="${requestScope['_05_state']}" /><c:if test="${not empty state}">,</c:if>${state}
		<c:set var="zip" value="${requestScope['_05_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
		<c:set var="county" value="${requestScope['_05_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
    </span>
</div>
<div class="row">
    <label>Practice Phone Number</label>
    <span class="floatL"><b>:</b></span>
    <span>
    ${requestScope['_05_phone1']}<c:if test="${requestScope['_05_phone2'] ne ''}"> - </c:if>${requestScope['_05_phone2']}<c:if test="${requestScope['_05_phone3'] ne ''}"> - </c:if>${requestScope['_05_phone3']}<c:if test="${requestScope['_05_phone4'] ne ''}"> ext. </c:if>${requestScope['_05_phone4']}
    </span>
</div>
<div class="row">
    <label>Practice Fax Number</label>
    <span class="floatL"><b>:</b></span>
    <c:set var="formName" value="_05_faxNumber"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <span>
    ${requestScope['_05_fax1']}<c:if test="${requestScope['_05_fax2'] ne ''}"> - </c:if>${requestScope['_05_fax2']}<c:if test="${requestScope['_05_fax3'] ne ''}"> - </c:if>${requestScope['_05_fax3']}
    </span>
</div>
<div class="row">
    <label>Billing Address</label>
    <span class="floatL"><b>:</b></span>
    
    <c:if test="${requestScope['_05_billingSameAsPrimary'] eq 'Y'}">
        <span>Same As Above</span>
    </c:if>
    <c:if test="${requestScope['_05_billingSameAsPrimary'] ne 'Y'}">
        <span>
			<c:if test="${not empty requestScope['_05_addressLine1']}"><c:out value="${requestScope['_05_billingAddressLine1']}" /><br /></c:if>
			<c:out value="${requestScope['_05_billingAddressLine2']}" /><br />
			<c:set var="city" value="${requestScope['_05_billingCity']}" /><c:out value="${city}" /> 
			<c:set var="state" value="${requestScope['_05_billingState']}" /><c:if test="${not empty state}">,</c:if>${state}
			<c:set var="zip" value="${requestScope['_05_billingZip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
			<c:set var="county" value="${requestScope['_05_billingCounty']}" /><c:if test="${not empty county}">,</c:if>${county} 
	    </span>
    </c:if>
</div>
<div class="row">
    <label>FEIN</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_fein']}</span>
</div>
<div class="row">
    <label>MN Tax ID</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_stateTaxId']}</span>
</div>
<div class="row">
    <label>Fiscal Year End</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_fye1']}<c:if test="${requestScope['_05_fye2'] ne ''}">/</c:if>${requestScope['_05_fye2']}</span>
</div>
<div class="row">
    <label>EFT Vendor Number</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_05_eftVendorNo']}</span>
</div>
<div class="row">
    <label>Remittance Sequence</label>
    <span class="floatL"><b>:</b></span>
    <c:choose>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER'}">
      <span>Patient Account or Own Reference Number Order</span>
        </c:when>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'DHS_TRANSACTION_CONTROL_ORDER'}">
      <span>DHS Transaction Control Number Order</span>
        </c:when>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'RECIPIENT_MHCP_ID_NUMBER_ORDER'}">
      <span>Recipient MHCP ID Number Order</span>
        </c:when>
    </c:choose>
</div>
