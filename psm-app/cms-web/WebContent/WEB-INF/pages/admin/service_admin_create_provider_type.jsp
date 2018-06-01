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
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabFunctions" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>

          <c:if test="${not empty requestScope['flash_error']}">
            <div class="clear"></div>
            <div class="errorInfo formErrorMarker" style="display: block;">
              <h3>Please correct the following errors:</h3>
              <p class="bindingError"><c:out value="${requestScope['flash_error']}"></c:out></p>
              <div class="tl"></div>
              <div class="tr"></div>
              <div class="bl"></div>
              <div class="br"></div>
            </div>
            <div class="clear"></div>
          </c:if>
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuProviderTypes" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />


            <div class="tabContent" id="tabProviderTypes">
              <form:form id="providerTypeForm" modelAttribute="providerType" action="${ctx}/admin/createProviderType" method="post">
                <div id="addProviderPanel">
                  <div class="sideBorder"><h3>Add Provider Type</h3></div>
                  <%@ include file="/WEB-INF/pages/admin/includes/service_admin_create_edit_provider_type_common.jsp" %>
                </div>
              </form:form>
              <!--/ #addProviderPanel -->
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
