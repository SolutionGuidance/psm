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
<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="stepWidget ${viewModel.individual ? 'stepWidget5Item' : 'stepWidget6Item'}">
    <ul>
        <c:set var="activeIdx" value="1"></c:set>
        <c:set var="isSubmissionPage" value="${false}" />
        <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
            <c:if test="${viewModel.currentTab eq tabName}"><c:set var="activeIdx" value="${status.count}"></c:set></c:if>
        </c:forEach>
        <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
            <%-- For some reason prototype developer set different classes per tab --%>
            <c:set var="tabCls" value=""></c:set>
            <c:set var="tabLabel" value=""></c:set>
            <c:set var="tabActiveCls" value=""></c:set>
            <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/tab_name_mapping.jsp" %>
            <c:choose>
                <c:when test="${status.count == activeIdx}"><c:set var="tabActiveCls" value="active"></c:set></c:when>
                <c:when test="${status.count + 1 == activeIdx}"><c:set var="tabActiveCls" value="activeNear"></c:set></c:when>
                <c:when test="${status.count + 1 < activeIdx}"><c:set var="tabActiveCls" value="activePrev"></c:set></c:when>
            </c:choose>
            <c:if test="${viewModel.currentTab eq tabName}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
            <c:if test="${viewModel.currentTab == tabName and status.last}">
              <c:set var="isSubmissionPage" value="${true}" />
            </c:if>
            <li class="${status.first ? 'firstStep' : ''} ${status.last ? 'lastStep' : ''} ${tabCls} ${tabActiveCls}">
               <span><strong>${status.count}. ${tabLabel}</strong></span>
            </li>
        </c:forEach>
    </ul>
    <div class="clearFixed"></div>
</div>
