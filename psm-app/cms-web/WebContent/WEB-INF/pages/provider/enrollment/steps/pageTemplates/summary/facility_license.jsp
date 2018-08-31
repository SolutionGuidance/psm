<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_21_bound'] eq 'Y'}">
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<table class="generalTable noInput">
    <colgroup>
        <col width="28"/>
        <col width="284"/>
        <col width="148"/>
        <col width="128"/>
        <col width="128"/>
        <col width="164"/>
    </colgroup>
    <thead>
        <tr>
            <th class="alignCenter">#<span class="sep"></span></th>
            <th>Type of License/Certification<span class="sep"></span></th>
            <th>License/Certification #<span class="sep"></span></th>
            <th>Original Issue Date<span class="sep"></span></th>
            <th>Renewal End Date<span class="sep"></span></th>
            <th>Issuing State/Territory<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_21_attachmentSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_21_licenseType_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_21_licenseNumber_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_21_originalIssueDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_21_renewalDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_21_issuingState_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- /.section -->
<div class="clearFixed"></div>
</c:if>
