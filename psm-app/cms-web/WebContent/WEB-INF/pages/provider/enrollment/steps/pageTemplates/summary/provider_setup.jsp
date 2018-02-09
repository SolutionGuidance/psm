<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_20_bound'] eq 'Y'}">
<table class="memberInfo">
    <colgroup>
        <col width="40"/>
        <col width="935"/>
    </colgroup>
    <tbody>
    <c:set var="formName" value="_20_payToSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <tr class="${status.last ? 'last' : ''}">
        <td class="firstCell">${status.count}</td>
        <td>

            <div class="section">
                <div class="leftCol">
                    <div class="row">
                        <label>NPI</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_20_npi_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Name</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_20_name_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Contact Name</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_20_contactName_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                </div>
                <div class="rightCol">
                    <div class="row">
                        <label>&nbsp;</label>
                        <span>&nbsp;</span>
                    </div>
                    <div class="row">
                        <label>Effective Date</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_20_effectiveDate_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Phone Number</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="phone1" value="_20_phone1_${status.index - 1}"></c:set>
                        <c:set var="phone2" value="_20_phone2_${status.index - 1}"></c:set>
                        <c:set var="phone3" value="_20_phone3_${status.index - 1}"></c:set>
                        <c:set var="phone4" value="_20_phone4_${status.index - 1}"></c:set>
                        <span>
                            ${requestScope[phone1]}<c:if test="${requestScope[phone2] ne ''}">-</c:if>${requestScope[phone2]}<c:if test="${requestScope[phone3] ne ''}">-</c:if>${requestScope[phone3]}<c:if test="${requestScope[phone4] ne ''}">ext.</c:if>${requestScope[phone4]}
                        </span>
                    </div>
                    <div class="row">
                        <label>Type</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_20_type_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                </div>
                <div class="clearFixed"></div>
            </div>
        </td>
    </tr>
    </c:forEach>
    </tbody>
</table>
</c:if>
