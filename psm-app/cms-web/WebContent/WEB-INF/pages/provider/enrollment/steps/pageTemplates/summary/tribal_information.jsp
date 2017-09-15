<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_13_bound'] eq 'Y'}">

<div class="practiceSection">
    <div class="wholeCol">
        <div class="row">
            <label>Is applicant a provider at a Public Health Service (PHS) Indian Hospital?</label>
            <span class="floatL"><b>:</b></span>
            <span id="worksOnReservation"><c:choose>
                <c:when test="${requestScope['_13_worksOnReservation'] eq 'Y'}">Yes</c:when>
                <c:when test="${requestScope['_13_worksOnReservation'] eq 'N'}">No</c:when>
            </c:choose></span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>

<c:if test="${requestScope['_13_worksOnReservation'] eq 'Y'}">
<table cellpadding="0" cellspacing="0" class="generalTable noInput">
    <colgroup>
        <col width="28"/>
        <col width="180"/>
        <col width="148"/>
        <col width="128"/>
        <col width="128"/>
        <col width="164"/>
    </colgroup>
    <thead>
        <tr>
            <th class="alignCenter">#<span class="sep"></span></th>
            <th>Reservation<span class="sep"></span></th>
            <th>License/Certification #<span class="sep"></span></th>
            <th>Original Issue Date<span class="sep"></span></th>
            <th>Renewal End Date<span class="sep"></span></th>
            <th>Issuing State<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_13_attachmentSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_13_tribalCode_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_13_licenseNumber_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_13_originalIssueDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_13_renewalDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_13_issuingState_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</c:if>

<!-- /.section -->
<div class="clearFixed"></div>

</c:if>