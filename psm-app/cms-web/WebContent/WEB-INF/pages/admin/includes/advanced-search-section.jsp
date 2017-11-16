<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The advanced search section jsp.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="false" var="hasArrow"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set value="Advanced Search (System Admin)" var="title"></c:set>
  <c:set value="true" var="systemPage"></c:set>
  <h:handlebars template="includes/html_head" context="${pageContext}" />

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="breadCrumb">
    <span class="text">Advanced Search</span>
</div>
<h1>Advanced Search</h1>
<div class="systemAdminFrom">
    <form:form cssClass="tabSection" id="advancedSearch" action="${ctx}/system/search/list" modelAttribute="criteria" method="post">
        <div class="detailPanel">
            <div class="section">
                <div class="leftCol">
                    <div class="row">
                        <label>Username</label>
                        <span class="floatL"><b>:</b></span>
                        <form:input cssClass="normalInput" path="username"/>
                    </div>
                    <div class="row">
                        <label>Last Name</label>
                        <span class="floatL"><b>:</b></span>
                        <form:input cssClass="normalInput" path="lastName"/>
                    </div>
                    <div class="row">
                        <label>First Name</label>
                        <span class="floatL"><b>:</b></span>
                        <form:input cssClass="normalInput" path="firstName"/>
                    </div>
                </div>
                <!-- /.leftCol -->
                <div class="rightCol">
                    <div class="row checkRow">
                        <label>Email</label>
                        <span class="floatL"><b>:</b></span>
                        <div class="checkWrapper">
                          <form:input cssClass="normalInput" path="email"/>
                        </div>
                    </div>
                    <div class="row checkRow">
                        <label>Role</label>
                        <span class="floatL"><b>:</b></span>
                        <div class="checkMain">
                          <div class="checkWrapper">
                            <input type="checkbox" name="requestType" class="checkAll" <c:if test="${fn:length(criteria.roles) eq 4}">checked="checked"</c:if> />
                            <span class="minWidth">All</span>
                            <input type="checkbox" name="roles" value="Service Agent" <c:if test="${fn:indexOf(roles, 'Service Agent') ge 0}">checked="checked"</c:if> />
                            <span class="label">Service Agent</span>
                            <input type="checkbox" name="roles" value="System Administrator" <c:if test="${fn:indexOf(roles, 'System Administrator') ge 0}">checked="checked"</c:if> />
                            <span class="label">System Administrator</span>
                            <div class="clearFixed"></div>
                            <input type="checkbox" name="roles" value="Provider" <c:if test="${fn:indexOf(roles, 'Provider') ge 0}">checked="checked"</c:if> />
                            <span class="minWidth">Provider</span>
                            <input type="checkbox" name="roles" value="Service Administrator" <c:if test="${fn:indexOf(roles, 'Service Administrator') ge 0}">checked="checked"</c:if> />
                            <span class="label">Service Administrator</span>
                          </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="and" name="and" value="true" />
                <form:hidden id="pageSize" path="pageSize" />
                <form:hidden id="pageNumber" path="pageNumber" />
                <form:hidden id="sortColumn" path="sortColumn" />
                <form:hidden id="ascending" path="ascending" />
                <form:hidden id="showFilterPanel" path="showFilterPanel" />
                <!-- /.rightCol -->
                <div class="clearFixed"></div>
            </div>
            <!-- /.section -->
            <div class="tl"></div>
            <div class="tr"></div>
        </div>
        <div class="clearFixed"></div>
        <div class="buttons">
            <a href="javascript:;" class="purpleBtn advancedSearchBtn"><span class="btR"><span class="btM"><span class="icon">Search</span><span class="arrow"></span></span></span></a>
        </div>
    </form:form>
<!-- /.tabSection -->
</div>
