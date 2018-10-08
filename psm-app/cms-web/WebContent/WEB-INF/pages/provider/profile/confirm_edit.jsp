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
  <c:set var="title" value="Confirm Action"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabProfile" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/search/approved?statuses=Approved" />">Applications</a>
            <span>Confirm Edit</span>
          </div>

          <div class="head">
            <h1>Confirm Edit</h1>
          </div>
          <div class="clearFixed"></div>
          <h:handlebars template="includes/flash" context="${pageContext}"/>

          <div class="dashboardPanel">
            <div class="tableDataButtons buttonBox">
              <div class="newApplicationPanel">
                <p class="confirm">
                  We found an existing ${requestType} draft for this profile. How do you wish to proceed?
                </p>
                <div class="br"></div>
                <div class="tr"></div>
                <div class="tl"></div>
                <div class="bl"></div>
              </div>

              <c:url var="reuseEditProfileLink" value="/provider/application/view">
                <c:param name="id" value="${applicationId}"></c:param>
              </c:url>

              <c:url var="newEditProfileLink" value="/provider/application/edit">
                <c:param name="profileId" value="${profileId}"></c:param>
              </c:url>
              <c:if test="${requestType eq 'Renewal'}">
                <c:url var="newEditProfileLink" value="/provider/application/renew">
                  <c:param name="profileId" value="${profileId}"></c:param>
                </c:url>
              </c:if>

              <a href="${reuseEditProfileLink}" class="purpleBtn">
                Continue Editing
              </a>
              <a href="${newEditProfileLink}" class="purpleBtn">
                Start A New Draft
              </a>

              <div class="clearFixed"></div>
              <div class="tl"></div>
              <div class="tr"></div>
            </div>
          </div>
          <!-- /.dashboardPanel -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
