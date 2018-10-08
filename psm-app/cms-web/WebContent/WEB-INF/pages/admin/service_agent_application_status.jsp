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
  - Description: This is the application status service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Status Query"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabDashboard" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <a href="${ctx}/agent/application/viewDashboard">Dashboard</a>
            <span>Application Status</span>
          </div>
          <div class="head">
            <h1>Application Status</h1>
          </div>
          <div class="tabSection">
            <div class="detailPanel">
              <div class="section">
                <div class="wholeCol">
                  <div class="row">
                    <label>NPI / UMPI</label>
                    <a href="${ctx}/provider/application/view?id=${profile.applicationId}">${profile.npi}</a>
                  </div>
                  <div class="row">
                    <label>Date Submitted</label>
                    <span><fmt:formatDate value="${profile.submissionDate}" pattern="MM/dd/yyyy"/></span>
                  </div>
                  <div class="row">
                    <label>Provider Type</label>
                    <span><c:out value="${profile.providerType}"/></span>
                  </div>
                  <div class="row">
                    <label>Provider Name</label>
                    <span><c:out value="${profile.providerName}"/></span>
                  </div>
                  <div class="row">
                    <label>Request Type</label>
                    <span><c:out value="${profile.requestType}"/></span>
                  </div>
                  <div class="row">
                    <label>Status</label>
                    <c:choose>
                    <c:when test="${fn:toLowerCase(profile.status)=='approved'}"><span class="green">Approved</span></c:when>
                    <c:when test="${fn:toLowerCase(profile.status)=='rejected'}"><span class="red">Denied</span></c:when>
                    <c:otherwise>${profile.status}</c:otherwise>
                    </c:choose>
                  </div>
                  <div class="row">
                    <label>Risk Level</label>
                    <c:choose>
                    <c:when test="${fn:toLowerCase(profile.riskLevel)=='limited'}"><span class="green">Limited</span></c:when>
                    <c:when test="${fn:toLowerCase(profile.riskLevel)=='high'}"><span class="red">High</span></c:when>
                    <c:otherwise>${profile.riskLevel}</c:otherwise>
                    </c:choose>
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
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
