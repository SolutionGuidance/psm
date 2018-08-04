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
<c:if test="${requestScope['_14_bound'] eq 'Y'}">

<c:set var="specialtyTrigger" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Highest Degree Form'].settings['specialtyTrigger']}"></c:set>
<c:set var="isActivated" value="${true}"></c:set>
<c:if test="${not empty specialtyTrigger}">
    <c:set var="isActivated" value="${false}"></c:set>
    <c:set var="formName" value="_09_attachmentSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
        <c:set var="formName" value="_09_specialtyType_${status.index - 1}"></c:set>
        <c:if test="${requestScope[formName] eq specialtyTrigger}">
            <c:set var="isActivated" value="${true}"></c:set>
        </c:if>
    </c:forEach>
</c:if>

<c:if test="${isActivated}">
<div class="practiceSection">
    <div class="wholeCol">
        <div class="row">
            <label>Highest Degree Earned</label>
            <span>${requestScope['_14_highestDegreeEarned']}</span>
        </div>
        <div class="row">
            <label>Degree Award Date</label>
            <span>${requestScope['_14_degreeAwardDate']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>

<!-- /.section -->
<div class="clearFixed"></div>

</c:if>
