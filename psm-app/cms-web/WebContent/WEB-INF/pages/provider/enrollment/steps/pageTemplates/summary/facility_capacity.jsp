<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_24_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>NAME OF RESPONSIBLE BILLING PERSON</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_24_billingContactName']}</span>
        </div>
        <div class="row">
            <label>TITLE</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_24_billingContactTitle']}</span>
        </div>
        <div class="row">
            <label>DATE OF EMPLOYMENT</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_24_billingContactHireDate']}</span>
        </div>
        <div class="row">
            <label>SOCIAL SECURITY NUMBER</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_24_billingContactSSN']}</span>
        </div>
        <div class="row">
            <label>DATE OF BIRTH</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_24_billingContactDOB']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
