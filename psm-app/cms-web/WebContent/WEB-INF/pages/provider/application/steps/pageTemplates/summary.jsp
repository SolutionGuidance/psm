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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="clearFixed"></div>
<%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/tabs.jsp" %>
<form action="<c:url value="/provider/application/page" />"
    id="applicationForm"
    method="post"
    enctype="multipart/form-data">
  <sec:csrfInput />

  <input type="hidden" name="pageName" value="${pageName}"/>
  <c:set var="showExportNavigation" value="${true}" />
  <c:set var="isTopNavigation" value="${true}" />
  <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

  <div class="personalPanel summaryPageWrapper">
    <c:set var="afterSummary" value="${false}"></c:set>
    <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
      <c:if test="${tabName ne pageName and not afterSummary}">
        <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/summary/header.jsp" %>
      </c:if>
      <c:choose>
      <c:when test="${tabName eq 'Personal Information'}">
        <jsp:include page="pageTemplates/summary/personal_info.jsp" />
      </c:when>
      <c:when test="${tabName eq 'Practice Information'}">
        <jsp:include page="pageTemplates/summary/practice_info.jsp" />
      </c:when>
      <c:otherwise>
        <c:forEach var="formName" items="${viewModel.tabModels[tabName].formNames}">
          <c:forEach var="entry" items="${summaryViewRegistry}">
            <c:if test="${formName eq entry.key}">
              <jsp:include page="${entry.value}" />
            </c:if>
          </c:forEach>
        </c:forEach>
      </c:otherwise>
      </c:choose>
      <c:if test="${tabName eq pageName}"><c:set var="afterSummary" value="${true}"></c:set></c:if>
    </c:forEach>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
  </div>

  <c:set var="isTopNavigation" value="${false}"></c:set>
  <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

</form>
