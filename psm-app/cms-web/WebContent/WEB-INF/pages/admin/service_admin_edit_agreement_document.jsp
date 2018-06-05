 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin agreement document edit/create page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Edit Agreement Document - Functions (Service Admin)"/>
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
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuAgreement" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabAgreement">
              <c:choose>
              <c:when test="${agreementDocument.id==0}">
                <c:set var="actionPath" value="${ctx}/admin/createAgreementDocument"/>
              </c:when>
              <c:otherwise>
                <c:set var="actionPath" value="${ctx}/admin/updateAgreementDocument"/>
              </c:otherwise>
              </c:choose>
              <form:form modelAttribute="agreementDocument" action='${actionPath}' id="agreementDocumentForm" method="post">
                <form:hidden path="id" />
                <form:hidden path="type" />
                <div id="addAgreementPanel">
                  <div class="sideBorder">
                    <c:choose>
                    <c:when test="${agreementDocument.id==0}"><h3>Add Agreement Document</h3></c:when>
                    <c:otherwise><h3>Edit Agreement Document</h3></c:otherwise>
                    </c:choose>
                  </div>
                  <div class="newEnrollmentPanel">
                    <div class="section">
                      <div class="wholeCol">
                        <div class="row">
                          <label for="editAgreementDocumentAgreementTitle">Agreement Title</label>
                          <span class="floatL"><b>:</b></span>
                          <form:input id="editAgreementDocumentAgreementTitle" path="title" cssClass="text longInput"/>
                        </div>
                        <div class="row">
                          <label>Content</label>
                          <span class="floatL"><b>:</b></span>
                          <form:textarea path="text" rows="20" cols="50" cssClass="longTextArea text"/>
                        </div>
                      </div>
                    </div>
                    <div class="bl"></div>
                    <div class="br"></div>
                  </div>
                  <div class="buttons">
                    <a href="${ctx}/admin/viewAgreementDocuments" class="cancelAddAgreementBtn greyBtn">Cancel</a>
                    <button class="greyBtn" type="submit">Save</button>
                  </div>
                </div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
    <script>
      (function($) {
        $(document).ready(function() {
          $('#text').wysiwyg();
        });
      })(jQuery);
    </script>
  </body>
</html>
