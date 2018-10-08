<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
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
                        <c:set var="formName" value="_20_npi_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Name</label>
                        <c:set var="formName" value="_20_name_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Contact Name</label>
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
                        <c:set var="formName" value="_20_effectiveDate_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Phone Number</label>
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
