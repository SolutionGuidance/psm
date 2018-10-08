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
<div class="tabHead" style="width: 958px;">
    <div class="tabR">
        <div class="tabM">
            <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
                <c:if test="${tabName ne 'Summary Information'}">
                    <c:set var="tabLabel" value=""></c:set>
                    <c:set var="tabCls" value=""></c:set>
                    <c:set var="tabActiveCls" value=""></c:set>
                    <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/tab_name_mapping.jsp" %>
                    <c:if test="${viewModel.currentTab eq tabName}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
                    <c:url var="tabLink" value="/provider/application/jump"><c:param name="page" value="${tabName}"></c:param></c:url>
                    <a href="${tabLink}" class="tab ${tabCls} ${tabActiveCls}">
                      <span class="aR">
                        <span class="aM">${tabLabel}</span>
                      </span>
                    </a>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${pageName eq 'Personal Information'}">
        <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/view_personal_info.jsp" %>
    </c:when>
    <c:when test="${pageName eq 'Practice Information'}">
        <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/view_practice_info.jsp" %>
    </c:when>
    <c:when test="${pageName eq 'Provider Statement'}">
        <c:if test="${viewModel.individual}">
            <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/view_individual_disclosure.jsp" %>
        </c:if>
        <c:if test="${not viewModel.individual}">
            <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/view_organization_disclosure.jsp" %>
        </c:if>

    </c:when>
    <c:otherwise>
        <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/view_default.jsp" %>
    </c:otherwise>
</c:choose>
