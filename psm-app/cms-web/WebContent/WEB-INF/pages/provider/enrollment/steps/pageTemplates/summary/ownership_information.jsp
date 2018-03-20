<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<c:if test="${requestScope['_17_bound'] eq 'Y'}">
<table class="memberInfo">
    <colgroup>
        <col width="135"/>
        <col width="40"/>
        <col width="930"/>
    </colgroup>
    <tbody>

    <c:set var="formName" value="_17_personOwnersSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <tr>
        <c:if test="${status.first}">
            <td class="firstCell colored" rowspan="${requestScope['_17_personOwnersSize']}">Individual</td>
        </c:if>
        <td class="firstCell">${status.count}</td>
        <td>
            <div class="section">
                <div class="leftCol">
                    <div class="row">
                        <label>Type</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_iboType_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Date of Birth</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_iboDOB_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Social Security Number</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_iboSSN_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Home Residence Address</label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="streetAddress" value="_17_iboAddressLine1_${status.index - 1}" />
                        <c:set var="extendedAddress" value="_17_iboAddressLine2_${status.index - 1}" />
                        <c:set var="city" value="_17_iboCity_${status.index - 1}" />
                        <c:set var="state" value="_17_iboState_${status.index - 1}" />
                        <c:set var="postalCode" value="_17_iboZip_${status.index - 1}" />
                        <c:set var="county" value="_17_iboCounty_${status.index - 1}" />
                        <h:address name="home"
                            streetAddress="${requestScope[streetAddress]}"
                            extendedAddress="${requestScope[extendedAddress]}"
                            city="${requestScope[city]}"
                            state="${requestScope[state]}"
                            postalCode="${requestScope[postalCode]}"
                            county="${requestScope[county]}" />
                    </div>
                </div>
                <div class="rightCol">
                    <div class="row">
                        <label>Name</label>
                        <span class="floatL"><b>:</b></span>
                        <span>
                            <c:set var="formName" value="_17_iboFirstName_${status.index - 1}"></c:set>
                            ${requestScope[formName]}&nbsp;<c:set var="formName" value="_17_iboMiddleName_${status.index - 1}"></c:set><c:if test="${not empty requestScope[formName]}"><c:out value="${requestScope[formName]}"></c:out></c:if>
                            <c:set var="formName" value="_17_iboLastName_${status.index - 1}"></c:set>&nbsp;${requestScope[formName]}
                        </span>
                    </div>
                    <div class="row">
                        <label>Hire Date</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_iboHireDate_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label class="multiLine">Relationship to any other listed person</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_iboRelationship_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                </div>
                <div class="clearFixed"></div>
            </div>
        </td>
    </tr>
    </c:forEach>

    <c:set var="formName" value="_17_corpOwnersSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <tr class="last">
        <c:if test="${status.first}">
            <td class="firstCell colored" rowspan="${requestScope['_17_corpOwnersSize']}">Individual</td>
        </c:if>
        <td class="firstCell">${status.count}</td>
        <td>

            <div class="section">
                <div class="leftCol">
                    <div class="row">
                        <label>Type</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_cboType_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Full Legal Name</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_cboLegalName_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Business Address</label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="streetAddress" value="_17_cboAddressLine1_${status.index - 1}" />
                        <c:set var="extendedAddress" value="_17_cboAddressLine2_${status.index - 1}" />
                        <c:set var="city" value="_17_cboCity_${status.index - 1}" />
                        <c:set var="state" value="_17_cboState_${status.index - 1}" />
                        <c:set var="postalCode" value="_17_cboZip_${status.index - 1}" />
                        <c:set var="county" value="_17_cboCounty_${status.index - 1}" />
                        <h:address name="business"
                            streetAddress="${requestScope[streetAddress]}"
                            extendedAddress="${requestScope[extendedAddress]}"
                            city="${requestScope[city]}"
                            state="${requestScope[state]}"
                            postalCode="${requestScope[postalCode]}"
                            county="${requestScope[county]}" />
                    </div>
                </div>
                <div class="rightCol">
                    <div class="row">
                        <label>FEIN</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_17_cboFEIN_${status.index - 1}"></c:set>
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
