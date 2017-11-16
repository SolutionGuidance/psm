<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The search accounts result page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<c:set value="Advanced Search (System Admin)" var="title"></c:set>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="false" var="hasArrow"></c:set>
<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>
<div class="breadCrumb">
    <span class="text">Search Results</span>
</div>
<h1>Search Results</h1>

<c:set var="hasFilterPanel" value="true" />

<%@ include file="/WEB-INF/pages/admin/includes/search-result-section.jsp" %>

<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>

<input type="hidden" value="<c:url value='/system/user/delete' />" id="deleteAccountsURL" />
