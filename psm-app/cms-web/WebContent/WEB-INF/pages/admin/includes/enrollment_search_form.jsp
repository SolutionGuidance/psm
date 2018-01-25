<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to build the enrollment search form.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<form:form id="searchForm"
  action="${enrollmentSearchFormAction}"
  modelAttribute="searchCriteria"
  method="get">
    <form:hidden cssClass="searchFormPageSize" id="searchFormPageSize" path="pageSize" />
    <form:hidden cssClass="searchFormPageNumber" id="searchFormPageNumber" path="pageNumber" />
    <form:hidden id="searchFormSortColumn" path="sortColumn" />
    <form:hidden id="searchFormAscending" path="ascending" />
    <form:hidden id="searchFormShowFilterPanel" path="showFilterPanel" />

    <form:hidden id="enrollmentNumberSearchField" path="enrollmentNumber" />
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
        <input class="enrollmentStatusValue" type="hidden" name="statuses[${status.index}]" value="${item}"/>
    </c:forEach>
</form:form>
<form:form id="exportForm"
  action="${ctx}/provider/search/exportBatch"
  modelAttribute="searchCriteria"
  method="post">
</form:form>
<form:form id="printForm"
  action="${ctx}/provider/search/print?print=yes"
  target="_blank"
  modelAttribute="searchCriteria"
  method="post">
</form:form>
