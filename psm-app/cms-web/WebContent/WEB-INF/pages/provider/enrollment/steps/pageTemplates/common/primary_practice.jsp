<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<div class="row">
    <label>Primary Practice Name</label>
    <span class="floatL"><b>:</b></span>
    <span id="primaryPracticeName">${requestScope['_06_name']}</span>
</div>
<div class="row">
    <label>Group <abbr title="National Provider Identifier">NPI</abbr>/<abbr title="Unique Minnesota Provider Identifier">UMPI</abbr></label>
    <span class="floatL"><b>:</b></span>
    <span id="groupNPI">${requestScope['_06_npi']}</span>
</div>
<div class="row">
    <label>State Medicaid ID</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_06_stateMedicaidId']}</span>
</div>
<div class="row">
    <label>Effective Date</label>
    <span class="floatL"><b>:</b></span>
    <span id="effectiveDate">${requestScope['_06_effectiveDate']}</span>
</div>
<div class="row">
    <label>Practice Address</label>
    <span class="floatL"><b>:</b></span>
    <h:address name="practice"
        streetAddress="${requestScope['_06_addressLine1']}"
        extendedAddress="${requestScope['_06_addressLine2']}"
        city="${requestScope['_06_city']}"
        state="${requestScope['_06_state']}"
        postalCode="${requestScope['_06_zip']}"
        county="${requestScope['_06_county']}" />
</div>
<div class="row">
    <label>Practice Phone Number</label>
    <span class="floatL"><b>:</b></span>
    <span id="practicePhoneNumber">
    ${requestScope['_06_phone1']}<c:if test="${requestScope['_06_phone2'] ne ''}"> - </c:if>${requestScope['_06_phone2']}<c:if test="${requestScope['_06_phone3'] ne ''}"> - </c:if>${requestScope['_06_phone3']}<c:if test="${requestScope['_06_phone4'] ne ''}"> ext. </c:if>${requestScope['_06_phone4']}
    </span>
</div>
<div class="row">
    <label>Practice Fax Number</label>
    <span class="floatL"><b>:</b></span>
    <c:set var="formName" value="_06_faxNumber"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <span id="practiceFaxNumber">
    ${requestScope['_06_fax1']}<c:if test="${requestScope['_06_fax2'] ne ''}"> - </c:if>${requestScope['_06_fax2']}<c:if test="${requestScope['_06_fax3'] ne ''}"> - </c:if>${requestScope['_06_fax3']}
    </span>
</div>
<div class="row">
    <label>Reimbursement Address</label>
    <span class="floatL"><b>:</b></span>
    <c:if test="${requestScope['_06_reimbursementSameAsPrimary'] eq 'Y'}">
        <span id="billingSameAsPrimary">Same As Above</span>
    </c:if>
    <c:if test="${requestScope['_06_reimbursementSameAsPrimary'] ne 'Y'}">
        <h:address name="billing"
            streetAddress="${requestScope['_06_reimbursementAddressLine1']}"
            extendedAddress="${requestScope['_06_reimbursementAddressLine2']}"
            city="${requestScope['_06_reimbursementCity']}"
            state="${requestScope['_06_reimbursementState']}"
            postalCode="${requestScope['_06_reimbursementZip']}" />
    </c:if>
</div>
