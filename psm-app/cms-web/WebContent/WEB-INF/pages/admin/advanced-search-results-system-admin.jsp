<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The advanced search results page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ include file="/WEB-INF/pages/admin/includes/advanced-search-section.jsp" %>

<c:set var="hasFilterPanel" value="false" />
<%@ include file="/WEB-INF/pages/admin/includes/search-result-section.jsp" %>

<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>

<input type="hidden" value="<c:url value='/system/search/delete' />" id="deleteAccountsURL" />
