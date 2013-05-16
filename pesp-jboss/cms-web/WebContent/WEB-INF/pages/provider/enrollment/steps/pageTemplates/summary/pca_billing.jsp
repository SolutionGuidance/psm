<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_27_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>Number of Beds</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_27_numberOfBeds']}</span>
        </div>
        <div class="row">
            <label>Effective Date</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_27_effectiveDate']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>