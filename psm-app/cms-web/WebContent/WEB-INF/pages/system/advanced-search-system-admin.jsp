<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The advanced search results page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="false" var="hasArrow"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set value="Advanced Search (System Admin)" var="title"></c:set>
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
  <span class="text">Advanced Search</span>
</div>
<h1>Advanced Search</h1>
<div class="systemAdminFrom">
  <form cssClass="tabSection" id="advancedSearch" action="${ctx}/system/search/list" method="post">
    <sec:csrfInput />
    <div class="detailPanel">
      <div class="section">
        <div class="leftCol">
          <div class="row">
            <label>Username</label>
            <span class="floatL"><b>:</b></span>
            <input type="text" class="normalInput" name="username"/>
          </div>
          <div class="row">
            <label>Last Name</label>
            <span class="floatL"><b>:</b></span>
            <input type="text" class="normalInput" name="lastName"/>
          </div>
          <div class="row">
            <label>First Name</label>
            <span class="floatL"><b>:</b></span>
            <input type="text" class="normalInput" name="firstName"/>
          </div>
        </div>
        <!-- /.leftCol -->
        <div class="rightCol">
          <div class="row checkRow">
            <label>Email</label>
            <span class="floatL"><b>:</b></span>
            <div class="checkWrapper">
              <input type="text" class="normalInput" name="email"/>
            </div>
          </div>
          <div class="row checkRow">
            <label>Role</label>
            <span class="floatL"><b>:</b></span>
            <div class="checkMain">
              <div class="checkWrapper">
                <input type="checkbox" id="requestType" class="checkAll" />
                <span class="minWidth">All</span>
                <input type="checkbox" name="roles" value="Service Agent" />
                <span class="label">Service Agent</span>
                <input type="checkbox" name="roles" value="System Administrator" />
                <span class="label">System Administrator</span>
                <div class="clearFixed"></div>
                <input type="checkbox" name="roles" value="Provider" />
                <span class="minWidth">Provider</span>
                <input type="checkbox" name="roles" value="Service Administrator" />
                <span class="label">Service Administrator</span>
              </div>
            </div>
          </div>
        </div>
        <input type="hidden" id="and" name="and" value="true" />
        <input type="hidden" id="pageSize" name="pageSize" value="10" />
        <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
        <input type="hidden" id="sortColumn" name="sortColumn" value="" />
        <input type="hidden" id="ascending" name="ascending" value="true" />
        <input type="hidden" id="showFilterPanel" name="showFilterPanel" value="false" />
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
  </form>
  <!-- /.tabSection -->
</div>
<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>
