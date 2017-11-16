<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The user accounts page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set value="User Account (System Admin)" var="title"></c:set>
  <c:set value="true" var="systemPage"></c:set>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}" />
      <div id="mainContent" <c:if test='${isUpdateUser}'>class="detailPage"</c:if>>
        <div class="contentWidth">

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="breadCrumb">
    User Accounts
</div>
<h1>User Accounts</h1>
<div class="tabSection" id="userAccountsTab">
    <div class="tabHead">
        <div class="tabR">
            <div class="tabM">
                <a class="tabLink <c:choose>
                <c:when test='${role eq "Provider" }'>active"</c:when>
                <c:otherwise>" href="<c:url value='/system/user/search?role=Provider' />"</c:otherwise>
                </c:choose>
                ><span class="aR"><span class="aM">Providers</span></span></a>
                <a class="tabLink <c:choose>
                <c:when test='${role eq "Service Agent" }'>active"</c:when>
                <c:otherwise>" href="<c:url value='/system/user/search?role=Service Agent' />"</c:otherwise>
                </c:choose>
                ><span class="aR"><span class="aM">Service Agents</span></span></a>
                <a class="tabLink <c:choose>
                <c:when test='${role eq "Service Administrator" }'>active"</c:when>
                <c:otherwise>" href="<c:url value='/system/user/search?role=Service Administrator' />"</c:otherwise>
                </c:choose>
                ><span class="aR"><span class="aM">Service Administrators</span></span></a>
                <a class="tabLink <c:choose>
                <c:when test='${role eq "System Administrator" }'>active"</c:when>
                <c:otherwise>" href="<c:url value='/system/user/search?role=System Administrator' />"</c:otherwise>
                </c:choose>
                ><span class="aR"><span class="aM">System Administrators</span></span></a>
                <a class="purpleBtn" href="<c:url value='/system/user/new?role=${role}' />"><span class="btR"><span class="btM">Create New User Account</span></span></a>
            </div>
        </div>
    </div>
    <!-- /.tabHead -->
    <c:if test='${role eq "Provider" }'>
    <div class="tabContent" id="tabProviders">
        <%@ include file="/WEB-INF/pages/admin/includes/accountsTab.jsp" %>
    </div>
    </c:if>
    <!-- /#tabProviders -->
    <c:if test='${role eq "Service Agent" }'>
    <div class="tabContent " id="tabServiceAgents">
        <%@ include file="/WEB-INF/pages/admin/includes/accountsTab.jsp" %>
    </div>
    </c:if>
    <!-- /#tabServiceAgents -->
    <c:if test='${role eq "Service Administrator" }'>
    <div class="tabContent " id="tabServiceAdministrators">
        <%@ include file="/WEB-INF/pages/admin/includes/accountsTab.jsp" %>
    </div>
    </c:if>
    <!-- /#tabServiceAdministrators -->
    <c:if test='${role eq "System Administrator" }'>
    <div class="tabContent " id="tabSystemAdministrators">
        <%@ include file="/WEB-INF/pages/admin/includes/accountsTab.jsp" %>
    </div>
    </c:if>
    <!-- /#tabSystemAdministrators -->
</div>

<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>

<input type="hidden" value="<c:url value='/system/user/delete' />" id="deleteAccountsURL" />
