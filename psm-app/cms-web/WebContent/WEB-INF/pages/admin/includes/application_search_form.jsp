<%--
  Copyright 2012 TopCoder Inc.
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
<%--
  - Description: it is used to build the application search form.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<form:form
  id="searchForm"
  cssClass="paginationForm"
  action="${applicationSearchFormAction}"
  modelAttribute="searchCriteria"
  method="get">
    <form:hidden cssClass="searchFormPageSize" id="searchFormPageSize" path="pageSize" />
    <form:hidden cssClass="searchFormPageNumber" id="searchFormPageNumber" path="pageNumber" />
    <form:hidden id="searchFormSortColumn" path="sortColumn" />
    <form:hidden id="searchFormAscending" path="ascending" />
    <form:hidden id="searchFormShowFilterPanel" path="showFilterPanel" />

    <form:hidden id="applicationNumberSearchField" path="applicationNumber" />
    <form:hidden id="npiSearchField" path="npi" />
    <form:hidden id="providerTypeSearchField" path="providerType" />
    <form:hidden id="providerNameSearchField" path="providerName" />
    <form:hidden id="submissionDateStartSearchField" path="submissionDateStart" />
    <form:hidden id="submissionDateEndSearchField" path="submissionDateEnd" />

    <c:forEach varStatus="status" var="item" items="${searchCriteria.riskLevels}">
        <input class="riskLevelValue" type="hidden" name="riskLevels[${status.index}]" value="${item}"/>
    </c:forEach>

    <c:forEach varStatus="status" var="item" items="${searchCriteria.requestTypes}">
        <input class="requestTypeValue" type="hidden" name="requestTypes[${status.index}]" value="${item}"/>
    </c:forEach>

    <c:forEach varStatus="status" var="item" items="${searchCriteria.statuses}">
        <input class="applicationStatusValue" type="hidden" name="statuses[${status.index}]" value="${item}"/>
    </c:forEach>
</form:form>
<form:form id="exportForm"
  action="${ctx}/provider/search/exportBatch"
  modelAttribute="searchCriteria"
  method="get">
</form:form>
