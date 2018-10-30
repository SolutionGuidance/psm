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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<c:choose>
  <c:when test="${principalUser ne null}">
    <html lang="en-US">
      <c:set var="title" value="Server Error"/>
      <h:handlebars template="includes/html_head" context="${pageContext}"/>
      <body>
        <div id="wrapper">
          <h:handlebars template="includes/header" context="${pageContext}"/>
          <!-- /#header -->

          <div id="mainContent">
            <div class="contentWidth">
              <div class="mainNav">
                <h:handlebars template="includes/logo" context="${pageContext}"/>
                <h:handlebars template="includes/banner" context="${pageContext}"/>
                <c:set var="activeTabDashboard" value="true"/>
                <h:handlebars template="includes/nav" context="${pageContext}"/>
              </div>
              <!-- /.mainNav -->
              <div class="breadCrumb">&nbsp;</div>
              <h1>Error</h1>
              <div class="tabSection">
                <div class="detailPanel">
                  <div class="section" id="updateProfile">
                    <div class="wholeCol">
                      <div class="row">
                        <h3>Server Error</h3>
                        <pre>Exception: ${exception}</pre>
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
            </div>
          </div>
          <!-- /#mainContent -->

          <h:handlebars template="includes/footer" context="${pageContext}"/>
          <!-- #footer -->
          <div class="clear"></div>
        </div>
        <!-- /#wrapper -->

      </body>
    </html>
  </c:when>
  <c:otherwise>
    <%@page import="org.springframework.security.web.WebAttributes"%>
    <html lang="en-US">
      <c:set var="title" value="Login"/>
      <c:set var="ctx" value="${pageContext.request.contextPath}"/>
      <h:handlebars template="includes/html_head" context="${pageContext}"/>
      <body>
        <div id="wrapper">
          <div id="header">
            <div class="contentWidth"></div>
            <!-- /.contentWidth -->
          </div>
          <!-- /#header -->
          <!-- start of error message -->
          <div id="errorbar">
            <div class="contentWidth">
              An error has occurred while processing your request, please contact 1-800-1010-2010 for any concerns.
            </div>
          </div>
          <!-- end of error message -->

          <div id="mainContent">
            <div class="contentWidth">
              <div class="mainNav">
                <h:handlebars template="includes/logo" context="${pageContext}"/>
                <h:handlebars template="includes/banner" context="${pageContext}"/>
              </div>
              <!-- /.mainNav -->

              <%@ include file="/WEB-INF/pages/login_form.jsp" %>

            </div>
          </div>
          <!-- /#mainContent -->

          <h:handlebars template="includes/footer" context="${pageContext}"/>
        </div>
        <!-- /#wrapper -->
      </body>
    </html>
  </c:otherwise>
</c:choose>
