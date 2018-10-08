<%--
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
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="${pageTitle}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <c:set var="selectedMarkup" value='selected="selected"'/>
  <body>
    <div id="wrapper" class="${viewModel.individual ? '' : 'homeHealthAgency'}">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabApplications" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->

          <c:choose>
            <c:when test="${isRenewalApplication}">
              <div class="breadCrumb">
                <%@ include file="/WEB-INF/pages/admin/includes/applications_link.jsp" %>
                <span>Application Renewal</span>
              </div>
              <div class="head">
                <h1>Application Renewal</h1>
              </div>
            </c:when>
            <c:otherwise>
              <div class="breadCrumb">
                <%@ include file="/WEB-INF/pages/admin/includes/applications_link.jsp" %>
                <span>Register New Application</span>
              </div>
              <div class="head">
                <c:choose>
                  <c:when test="${pageName eq 'Provider Type Page'}">
                    <h1>Select Provider Type</h1>
                  </c:when>
                  <c:otherwise>
                    <h1><c:out value="${requestScope['_01_providerType']}"/>
                      Application</h1>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:otherwise>
          </c:choose>

          <c:if test="${not empty requestScope['flash_info']}">
            <div class="info">
              <c:out value="${requestScope['flash_info']}"></c:out>
            </div>
          </c:if>

          <c:choose>
            <c:when test="${pageName eq 'Provider Type Page'}">
              <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/select_type.jsp" %>
            </c:when>
            <c:when test="${pageName eq 'Summary Information'}">
              <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/summary.jsp" %>
            </c:when>
            <c:otherwise>
              <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/default.jsp" %>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->

    <!-- /#modalBackground-->
    <div id="modalBackground"></div>
    <div id="new-modal">
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/save_as_draft.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/practice_lookup.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/stale_application.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/superseded_application.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/submit_application.jsp" %>

      <c:set var="userHelpModalId" value="user-help-modal"/>
      <h:handlebars template="includes/userhelp/user_help_modal" context="${pageContext}" />

    </div>
    <c:if test="${not empty requestScope['flash_popup']}">
      <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
    </c:if>
  </body>
</html>
