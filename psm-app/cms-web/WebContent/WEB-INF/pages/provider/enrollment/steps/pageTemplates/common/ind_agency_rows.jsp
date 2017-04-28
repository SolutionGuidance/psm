<div class="row">
    <label>Agency Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_name']}</span>
</div>
<div class="row">
    <label>Agency Id</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_agencyId']}</span>
</div>
<div class="row">
    <label>Agency NPI/UMPI</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_npi']}</span>
</div>
<div class="row">
    <label>Fax Number</label>
    <span class="floatL"><b>:</b></span>
    <span>
        ${requestScope['_11_fax1']}<c:if test="${requestScope['_11_fax2'] ne ''}">-</c:if>${requestScope['_11_fax2']}<c:if test="${requestScope['_11_fax3'] ne ''}">-</c:if>${requestScope['_11_fax3']}
    </span>
</div>
<div class="row">
    <label>Agency Contact Name</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_contactName']}</span>
</div>
<div class="row">
    <label>Background Study ID</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_bgsId']}</span>
</div>
<div class="row">
    <label>Clearance Date</label>
    <span class="floatL"><b>:</b></span>
    <span>${requestScope['_11_clearanceDate']}</span>
</div>
<div class="row">
    <label>Has this individual maintained continuous employment with your agency since this BGS was completed?</label>
    <span class="floatL"><b>&nbsp;</b></span>
    <span><c:choose>
        <c:when test="${requestScope['_11_continuousEmployment'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_11_continuousEmployment'] eq 'N'}">No</c:when>
    </c:choose></span>            
</div>
<div class="row">
    <label> You have the option to affiliate/enroll the individual PCA  with other agencies you own without completing another 
            application and agreement. Do you want to affiliate this individual PCA with any other agency(ies) you own?</label>
    <span class="floatL"><b>&nbsp;</b></span>
    <span><c:choose>
        <c:when test="${requestScope['_11_additionalAgency'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_11_additionalAgency'] eq 'N'}">No</c:when>
    </c:choose></span>            
</div>
