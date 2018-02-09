<div class="row">
    <label>Last Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_lastName']}</span>
</div>
<div class="row">
    <label>First Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_firstName']}</span>
</div>
<div class="row">
    <label>Middle Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_middleName']}</span>
</div>
<div class="row">
    <label>Social Security Number</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_ssn']}</span>
</div>
<div class="row address">
    <label>Residential Address</label>
    <span class="floatL"><b>:</b></span>
    <span>
        <c:if test="${not empty requestScope['_10_addressLine1']}"><c:out value="${requestScope['_10_addressLine1']}" /><br /></c:if>
        <c:out value="${requestScope['_10_addressLine2']}" /><br />
        <c:set var="city" value="${requestScope['_10_city']}" /><c:out value="${city}" />
        <c:set var="state" value="${requestScope['_10_state']}" /><c:if test="${not empty state}">,</c:if>${state}
        <c:set var="zip" value="${requestScope['_10_zip']}" /><c:if test="${not empty zip}">,</c:if>${zip}
        <c:set var="county" value="${requestScope['_10_county']}" /><c:if test="${not empty county}">,</c:if>${county}
    </span>
</div>

<div class="row">
    <label>UMPI</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_npi']}</span>
</div>

<div class="row">
    <label>Date of Birth</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_10_dob']}</span>
</div>

<div class="row">
    <label>Phone Number</label>
    <span class="floatL"><b>:</b></span>
    <span>
    ${requestScope['_10_phone1']}<c:if test="${requestScope['_10_phone2'] ne ''}">-</c:if>${requestScope['_10_phone2']}<c:if test="${requestScope['_10_phone3'] ne ''}">-</c:if>${requestScope['_10_phone3']}<c:if test="${requestScope['_10_phone4'] ne ''}">ext.</c:if>${requestScope['_10_phone4']}
    </span>
</div>

<div class="row">
    <label>Are you 18 years or older?</label>
    <span class="floatL"><b>&nbsp;</b></span>
    <span><c:choose>
        <c:when test="${requestScope['_10_adultInd'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_10_adultInd'] eq 'N'}">No</c:when>
    </c:choose></span>
</div>