<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_22_bound'] eq 'Y'}">
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<table cellpadding="0" cellspacing="0" class="generalTable noInput">
    <colgroup>
        <col width="28"/>
        <col width="284"/>
    </colgroup>
    <thead>
        <tr>
            <th class="alignCenter">#<span class="sep"></span></th>
            <th>CLIA #<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_22_attachmentSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_22_licenseNumber_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- /.section -->
<div class="clearFixed"></div>
</c:if>