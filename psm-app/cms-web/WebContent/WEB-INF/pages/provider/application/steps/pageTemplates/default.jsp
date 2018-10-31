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
  <c:set var="showExportNavigation" value="${false}" />
  <c:set var="isTopNavigation" value="${true}" />
  <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

  <div class="requiredInfo">
    <span class="required">*</span> Indicates Required Fields
  </div>

  <%@include file="/WEB-INF/pages/provider/application/steps/errors.jsp" %>

  <c:forEach var="formName" items="${viewModel.currentFormNames}">
    <c:forEach var="entry" items="${viewRegistry}">
      <c:if test="${formName eq entry.key}">
        <jsp:include page="${entry.value}" />
      </c:if>
    </c:forEach>
  </c:forEach>

  <c:set var="isTopNavigation" value="${false}" />
  <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

</form>
