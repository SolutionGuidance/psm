 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types create page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Create Provider Type - Functions (Service Admin)"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabFunctions" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>
          <div class="tabSection">
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>
          </div>
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuProviderTypes" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabProviderTypes">
              <div class="sideBorder"><h3>Add Provider Type</h3></div>
              <c:set var="editCreateProviderTypeFormAction" value="${ctx}/admin/createProviderType" />
              <%@ include file="/WEB-INF/pages/admin/includes/service_admin_create_edit_provider_type_common.jsp" %>
            </div>
          </div>
        </div>
      <!-- /#mainContent -->
      </div>
      <h:handlebars template="includes/footer" context="${pageContext}"/>
    <!-- /#wrapper -->
    </div>
  </body>
</html>
