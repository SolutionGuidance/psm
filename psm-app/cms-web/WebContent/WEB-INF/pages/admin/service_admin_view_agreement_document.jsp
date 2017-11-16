 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin agreement document view page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set var="title" value="Functions (Service Admin)"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTab" value="4"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuAgreement" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabAgreement">
              <div id="viewAgreementPanel">
                <div class="sideBorder">
                  <h3><c:out value="${agreementDocument.title}"/></h3>
                  <a href="${ctx}/admin/viewAgreementDocuments" class="closeViewAgreementBtn greyBtn"><span class="btR"><span class="btM">Close</span></span></a>
                  <a href="javascript:window.print();" class="greyBtn printBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-print.png" alt="" />Print</span></span></a>
                </div>
                <div class="newEnrollmentPanel">
                  <div class="section">
                    <div class="wholeCol">
                      ${agreementDocument.text}
                    </div>
                  </div>
                  <div class="bl"></div>
                  <div class="br"></div>
                </div>
              </div>
              <!-- /#viewAgreementPanel -->
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
