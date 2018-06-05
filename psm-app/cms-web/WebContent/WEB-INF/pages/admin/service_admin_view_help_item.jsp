 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin help topic view page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="View Help Topic - Functions (Service Admin)"/>
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
            <c:set var="functionsServiceActiveMenuHelpTopics" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabHelpTopics">
              <div id="viewHelpTopicPanel">
                <div>
                  <div class="sideBorder">
                    <h3><c:out value="${helpItem.title}"/></h3>
                    <a href="javascript:;" class="deleteHelpTopicBtn greyBtn">Delete</a>
                    <a href="${ctx}/admin/editHelpItem?helpItemId=${helpItem.id}" class="editHelpTopicBtn purpleBtn">Edit</a>
                  </div>
                  <div class="newEnrollmentPanel">
                    <div class="section">
                      <div class="wholeCol">
                        <c:out value="${helpItem.description}"/>
                      </div>
                    </div>
                    <div class="bl"></div>
                    <div class="br"></div>
                  </div>
                  <div class="buttons">
                    <a href="${ctx}/admin/searchHelp" class="greyBtn">Back</a>
                  </div>
                </div>
                <!-- /#viewHelpTopicPanel -->
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
    <!-- modal -->
    <div id="modalBackground"></div>
    <div id="modal">
      <div class="modal" id="deleteHelpTopicModal">
        <div class="modalHeader">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <a href="javascript:;" class="closeModal">CLOSE</a>
                <h2>Delete Help</h2>
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalHeader -->
        <div class="modalBody">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <div class="container">
                  <p>Are you sure you want to delete "<c:out value='${helpItem.title}'/>""?</p>
                  <div class="buttons">
                    <a href="javascript:;" rel="${ctx}/admin/deleteHelpItem?helpItemId=${helpItem.id}" class="purpleBtn deleteOKBtn">Delete</a>
                    <a href="javascript:;" class="greyBtn closeModal cancelBtn">Cancel</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalBody -->
        <div class="modalFooter">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalFooter -->
      </div>
    </div>
  </body>
</html>
