<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_38_bound'] eq 'Y'}">
<div class="section">
    <div class="wholeCol">
        <div class="row">
            <label>Does your facility provide physical or occupational therapy to community residents?</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_38_therapyIndicator']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>Bed Count</label>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>SKILLED NURSING FACILITY (TITLE 18 ONLY)</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_38_title18BedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>NURSING FACILITY (TITLE 19 ONLY)</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_38_title19BedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>SKILLED NURSING FACILITY DUAL CERTIFIED (TITLE 18/19)</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_38_dualCertBedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>ICF/DD</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_38_icfBedCount']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>