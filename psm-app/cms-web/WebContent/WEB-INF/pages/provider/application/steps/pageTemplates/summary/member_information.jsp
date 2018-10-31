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
<c:if test="${requestScope['_16_bound'] eq 'Y'}">
<table class="memberInfo">
    <colgroup>
        <col width="40"/>
        <col width="935"/>
    </colgroup>
    <tbody>
    <c:set var="formName" value="_16_memberSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <tr class="${status.last ? 'last' : ''}">
        <td class="firstCell">${status.count}</td>
        <td>

            <div class="section">
                <div class="leftCol">
                    <div class="row">
                        <label>NPI</label>
                        <c:set var="formName" value="_16_npi_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Individual Provider Type</label>
                        <c:set var="formName" value="_16_providerType_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Date of Birth</label>
                        <c:set var="formName" value="_16_dob_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Start Date</label>
                        <c:set var="formName" value="_16_startDate_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                </div>
                <div class="rightCol">
                    <div class="row">
                        <label>Name</label>
                        <c:set var="formName" value="_16_name_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <div class="row">
                        <label>Social Security Number</label>
                        <c:set var="formName" value="_16_ssn_${status.index - 1}"></c:set>
                        <span>${requestScope[formName]}</span>
                    </div>
                    <c:set var="formName" value="_16_bgsStudyId_${status.index - 1}"></c:set>
                    <c:if test="${not empty formName}">
                        <div class="row">
                            <label>BGS Study ID</label>
                            <c:set var="formName" value="_16_bgsStudyId_${status.index - 1}"></c:set>
                            <span>${requestScope[formName]}</span>
                        </div>
                        <div class="row">
                            <label>BGS Clearance Date</label>
                            <c:set var="formName" value="_16_bgsClearanceDate_${status.index - 1}"></c:set>
                            <span>${requestScope[formName]}</span>
                        </div>
                    </c:if>
                </div>
                <div class="clearFixed"></div>
            </div>
        </td>
    </tr>
    </c:forEach>
    </tbody>
</table>
</c:if>
