<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The filter panel jsp page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set var="cssClz" value="filterPanel show" />
<c:if test="${!criteria.showFilterPanel}">
    <c:set var="cssClz" value="filterPanel hide" />
</c:if>
<form:form id="searchUserAccountsForm" cssClass="${cssClz}" action="${ctx}/system/user/search?role=${role}" modelAttribute="criteria" method="post">
    <div class="floatW">
        <div class="leftCol">
            <div class="row">
                <label>Username</label>
                <span class="floatL"><b>:</b></span>
                <form:input cssClass="normalInput" path="username" />
            </div>
            <div class="row">
                <label>Email</label>
                <span class="floatL"><b>:</b></span>
                <form:input cssClass="normalInput" path="email"/>
            </div>
        </div>
        <div class="rightCol">
            <div class="row">
                <label>Last Name</label>
                <span class="floatL"><b>:</b></span>
                <form:input cssClass="normalInput" path="lastName" />
            </div>
            <div class="row">
                <label>First Name</label>
                <span class="floatL"><b>:</b></span>
                <form:input cssClass="normalInput" path="firstName" />
            </div>
        </div>
    </div>
    <input type="hidden" id="and" name="and" value="true" />
    <form:hidden id="pageSize" path="pageSize" />
    <form:hidden id="pageNumber" path="pageNumber" />
    <form:hidden id="sortColumn" path="sortColumn" />
    <form:hidden id="ascending" path="ascending" />
    <form:hidden id="showFilterPanel" path="showFilterPanel" />
    <form:hidden id="searchBox" path="searchBox" />
    <input type="hidden" id="initSearchBox" name="initSearchBox" value="false" />
    <form:hidden id="roles" path="roles"/>
    <a href="javascript:;" class="purpleBtn" id="filterBtn"><span class="btR"><span class="btM">Filter</span></span></a>
</form:form>
<!-- /.filterPanel -->