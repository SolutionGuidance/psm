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
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabProfile" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/profile/" />">My Profile</a>
            <span>View Profile Details</span>
          </div>
          <div class="head">
            <h1>View Profile Details</h1>
            <a class="greyBtn iconPdf" href="<c:url value="/provider/application/export" />">
              Export to PDF
            </a>
          </div>

          <div class="tabSection">
            <div class="detailPanel firstRegistrant" style="width: 940px;">
              <div class="section">
                <div class="wholeCol">
                  <label>Provider Type</label>
                  <span>${requestScope['_01_providerType']}</span>
                </div>
              </div>

              <!-- /.section -->
              <div class="tl"></div>
              <div class="tr"></div>
              <div class="bl"></div>
              <div class="br"></div>
            </div>
            <!-- /.detailPanel -->

            <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/readonly_profile.jsp" %>

          </div>
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
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/stale_application.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/superseded_application.jsp" %>
      <%@include file="/WEB-INF/pages/provider/application/steps/modal/submit_application.jsp" %>
      <!-- /#saveAsDraftModal-->
    </div>
    <c:if test="${not empty requestScope['flash_popup']}">
      <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
    </c:if>
  </body>
</html>
