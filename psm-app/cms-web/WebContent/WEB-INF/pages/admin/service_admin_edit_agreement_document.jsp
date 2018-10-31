<%--
  Copyright 2012 TopCoder Inc.
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
 <%--
  - Description: This is the admin agreement document edit/create page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Edit Agreement Document - Functions (Service Admin)"/>
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
          <div class="tabSection functionTab" id="applicationSection">
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
                  <div class="newApplicationPanel">
                    <div class="section">
                      <div class="wholeCol">
                        <div class="row">
                          <label for="editAgreementDocumentAgreementTitle">Agreement Title</label>
                          <form:input id="editAgreementDocumentAgreementTitle" path="title" cssClass="text longInput"/>
                        </div>
                        <div class="row">
                          <label>Content</label>
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
