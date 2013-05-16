<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="row">
    <label>Primary Practice Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_06_name']}</span>
</div>
<div class="row">
    <label>Group NPI/UMPI</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_06_npi']}</span>
</div>
<div class="row">
    <label>Effective Date</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_06_effectiveDate']}</span>
</div>
<div class="row">
    <label>Practice Address</label>
    <span class="floatL"><b>:</b></span>
    <span>
        <c:if test="${not empty requestScope['_06_addressLine1']}"><c:out value="${requestScope['_06_addressLine1']}" /><br /></c:if>
        <c:out value="${requestScope['_06_addressLine2']}" /><br />
        <c:set var="city" value="${requestScope['_06_city']}" /><c:out value="${city}" /> 
        <c:set var="state" value="${requestScope['_06_state']}" /><c:if test="${not empty state}">,</c:if>${state}
        <c:set var="zip" value="${requestScope['_06_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
        <c:set var="county" value="${requestScope['_06_county']}" /><c:if test="${not empty county}">,</c:if>${county} 
    </span>
</div>
<div class="row">
    <label>Practice Phone Number</label>
    <span class="floatL"><b>:</b></span>
    <span>
    ${requestScope['_06_phone1']}<c:if test="${requestScope['_06_phone2'] ne ''}"> - </c:if>${requestScope['_06_phone2']}<c:if test="${requestScope['_06_phone3'] ne ''}"> - </c:if>${requestScope['_06_phone3']}<c:if test="${requestScope['_06_phone4'] ne ''}"> ext. </c:if>${requestScope['_06_phone4']}
    </span>
</div>
<div class="row">
    <label>Practice Fax Number</label>
    <span class="floatL"><b>:</b></span>
    <c:set var="formName" value="_06_faxNumber"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <span>
    ${requestScope['_06_fax1']}<c:if test="${requestScope['_06_fax2'] ne ''}"> - </c:if>${requestScope['_06_fax2']}<c:if test="${requestScope['_06_fax3'] ne ''}"> - </c:if>${requestScope['_06_fax3']}
    </span>
</div>
<div class="row">
    <label>Reimbursement Address</label>
    <span class="floatL"><b>:</b></span>
    <c:if test="${requestScope['_06_reimbursementSameAsPrimary'] eq 'Y'}">
        <span>Same As Above</span>
    </c:if>
    <c:if test="${requestScope['_06_reimbursementSameAsPrimary'] ne 'Y'}">
	    <span>
	        <c:if test="${not empty requestScope['_06_reimbursementAddressLine1']}"><c:out value="${requestScope['_06_reimbursementAddressLine1']}" /><br /></c:if>
	        <c:out value="${requestScope['_06_reimbursementAddressLine2']}" /><br />
	        <c:set var="city" value="${requestScope['_06_reimbursementCity']}" /><c:out value="${city}" /> 
	        <c:set var="state" value="${requestScope['_06_reimbursementState']}" /><c:if test="${not empty state}">,</c:if>${state}
	        <c:set var="zip" value="${requestScope['_06_reimbursementZip']}" /><c:if test="${not empty zip}">,</c:if>${zip} 
	        <c:set var="county" value="${requestScope['_06_reimbursementCounty']}" /><c:if test="${not empty county}">,</c:if>${county} 
	    </span>
    </c:if>
</div>
