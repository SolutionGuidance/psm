<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_29_bound'] eq 'Y'}">

<c:set var="formName" value="_16_qpSize"></c:set>
<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <div class="section">
        <div class="leftCol">
            <div class="row">
                <label>QP Type</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_qpType_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Name</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_name_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>NPI</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_npi_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Date of Employment</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_startDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <!-- /.leftCol -->
        <div class="rightCol">
            <div class="row">
                <label>Date of Birth</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_dob_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Social Security Number</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_ssn_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>The affiliation has ended</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_ended_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Termination Date</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_endDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="">
            <div class="row">
                <label>Home Residence Address</label>
                <span class="floatL"><b>:</b></span>
                <span class="address">
                    <c:set var="formName" value="_29_addressLine2_${status.index - 1}"></c:set>
                     ${requestScope[formName]}<br />
                    <c:set var="formName" value="_29_city_${status.index - 1}"></c:set>
                    <c:set var="city" value="${requestScope[formName]}"></c:set>
                    ${city}
                    <c:set var="formName" value="_29_state_${status.index - 1}"></c:set>
                    <c:set var="state" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty state}">,</c:if>
                    ${state}
                    <c:set var="formName" value="_29_zip_${status.index - 1}"></c:set>
                    <c:set var="zip" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty zip}">,</c:if>
                    ${zip}
                    <c:set var="formName" value="_29_county_${status.index - 1}"></c:set>
                    <c:set var="county" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty county}">,</c:if>
                    ${county}
                </span>
            </div>
        </div>

        <div class="leftCol">
            <div class="row requireField">
                <label>BGS ID NUMBER<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_29_bgsNumber_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="rightCol">
            <div class="row requireField">
                <label>BGS Clearance Date<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <c:set var="formName" value="_29_bgsClearanceDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="clearFixed"></div>
</c:forEach>
</c:if>
