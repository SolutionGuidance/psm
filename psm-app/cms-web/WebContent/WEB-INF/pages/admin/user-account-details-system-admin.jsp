<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The user account details page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set value="User Account Details (System Admin)" var="title"></c:set>
  <c:set value="true" var="systemPage"></c:set>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}" />
      <div id="mainContent" <c:if test='${isUpdateUser}'>class="detailPage"</c:if>>
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>

<div class="breadCrumb">
    <a href="<c:url value='/system/user/list' />">User Accounts</a>
    <span>User Account Details</span>
</div>
<div class="head">
    <h1 class="text">User Account Details</h1>
    <a href="javascript:;" class="greyBtn deleteUserAccountModalBtnSingle" rel="${user.userId}"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-x-red.png" class="delIcon" alt=""/>Delete User Account</span></span></a>
    <a href="<c:url value='/system/user/edit?role=${role}&userId=${user.userId}' />" class="purpleBtn"><span class="btR"><span class="btM">Edit User Account</span></span></a>
</div>
<div class="tabSection" id="myProfile">
    <div class="detailPanel">
        <div class="section">
            <div class="wholeCol">
                <div class="row">
                    <label>Username</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.username}</span>
                </div>
                <div class="row">
                    <label>Password</label>
                    <span class="floatL"><b>:</b></span>
                    <span>********</span>
                </div>
                <div class="row">
                    <label>Last Name</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.lastName}</span>
                </div>
                <div class="row">
                    <label>First Name</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.firstName}</span>
                </div>
                <div class="row">
                    <label>Middle Name</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.middleName}</span>
                </div>
                <div class="row">
                    <label>Email</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.email}</span>
                </div>
                <div class="row">
                    <label>User Role</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${user.role.description}</span>
                </div>
            </div>
        </div>
        <!-- /.section -->
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
<!-- /.tabSection -->

<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>

<input type="hidden" value="<c:url value='/system/user/delete' />" id="deleteAccountsURL" />
