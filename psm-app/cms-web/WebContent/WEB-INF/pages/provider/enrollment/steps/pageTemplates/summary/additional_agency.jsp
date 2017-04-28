<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<table cellpadding="0" cellspacing="0" class="generalTable noInput">
    <colgroup>
        <col width="22" />
        <col width="300" />
        <col width="200" />
        <col width="200" />
        <col width="100" />
    </colgroup>
    <thead>
        <tr>
            <th class="firstTheader">#<span class="sep"></span></th>
            <th>Organization/Agency Name<span class="sep"></span></th>
            <th>NPI / UMPI<span class="sep"></span></th>
            <th>Study ID<span class="sep"></span></th>
            <th>Clearance Date<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_12_additonalLocationSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_12_name_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_12_npi_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_12_studyId_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_12_clearanceDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="clear"></div>
