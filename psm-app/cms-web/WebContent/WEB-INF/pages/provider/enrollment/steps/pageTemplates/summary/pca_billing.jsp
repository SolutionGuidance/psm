<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_24_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>Name of Responsible Billing Person</label>
            <span >${requestScope['_24_billingContactName']}</span>
        </div>
        <div class="row">
            <label>Title</label>
            <span >${requestScope['_24_billingContactTitle']}</span>
        </div>
        <div class="row">
            <label>Date of Employment</label>
            <span >${requestScope['_24_billingContactHireDate']}</span>
        </div>
        <div class="row">
            <label>Social Security Number</label>
            <span >${requestScope['_24_billingContactSSN']}</span>
        </div>
        <div class="row">
            <label>Date of Birth</label>
            <span >${requestScope['_24_billingContactDOB']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
