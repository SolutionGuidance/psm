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
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

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
<input type="hidden" name="formNames" value="<%= ViewStatics.HIGHEST_DEGREE_FORM %>">
<div class="newApplicationPanel" style="display: ${isActivated ? 'block' : 'none'}">
    <c:if test="${not empty specialtyTrigger}">
        <input type="hidden" name="specialtyTrigger" value="${specialtyTrigger}">
    </c:if>
    <div class="section">
        <div class="wholeCol">
            <div class="row requireField">
                <c:set var="formName" value="_14_highestDegreeEarned"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="highestDegree_${formName}" >Highest Degree Earned <span class="required">*</span></label>
                <select id="highestDegree_${formName}" class="bigSelect" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_14_degreeTypes']}">
                        <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_14_degreeAwardDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="degreeAwardDate_${formName}">Degree Award Date <span class="required">*</span></label>
                <span class="dateWrapper floatL">
                    <input id="degreeAwardDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}" maxlength="10"/>
                </span>
            </div>
            <div class="row">
                <label>Copy of Highest Degree Earned</label>
                <span class="floatL">
                    <c:set var="formName" value="_14_copyOfHighestDegree" />
                    <h:attachment
                        name="${formName}"
                        title="Copy of Highest Degree Earned"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
    </div>
    <!-- /.section -->

    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.newApplicationPanel -->
