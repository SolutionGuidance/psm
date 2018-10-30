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
<c:if test="${requestScope['_13_bound'] eq 'Y'}">

<div class="practiceSection">
    <div class="wholeCol">
        <div class="row">
            <label>Is applicant a provider at a Public Health Service (PHS) Indian Hospital?</label>
            <span id="worksOnReservation"><c:choose>
                <c:when test="${requestScope['_13_worksOnReservation'] eq 'Y'}">Yes</c:when>
                <c:when test="${requestScope['_13_worksOnReservation'] eq 'N'}">No</c:when>
            </c:choose></span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>

<c:if test="${requestScope['_13_worksOnReservation'] eq 'Y'}">
<table class="generalTable noInput">
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
            <th>Issuing State/Territory<span class="sep"></span></th>
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
