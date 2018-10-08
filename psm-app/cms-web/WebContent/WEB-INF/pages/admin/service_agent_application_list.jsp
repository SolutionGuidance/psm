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
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:choose>
    <c:when test="${tabName == 'all'}">
      <c:set var="listType" value="All Applications"/>
    </c:when>
    <c:when test="${tabName == 'approved'}">
      <c:set var="listType" value="Approved Applications"/>
    </c:when>
    <c:when test="${tabName == 'rejected'}">
      <c:set var="listType" value="Denied Applications"/>
    </c:when>
    <c:when test="${tabName == 'pending'}">
      <c:set var="listType" value="Pending Applications"/>
    </c:when>
    <c:when test="${tabName == 'draft'}">
      <c:set var="listType" value="Draft Applications"/>
    </c:when>
  </c:choose>
  <c:set var="title" value="${listType}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabApplications" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <%@ include file="/WEB-INF/pages/admin/includes/applications_link.jsp" %>
            <span>${listType}</span>
          </div>
          <h1>${listType}</h1>
          <div class="tabSection" id="applicationSection">
            <c:set var="active_application_tab" value="${tabName}"/>
            <c:set var="applicationSearchFormAction" value="${ctx}/provider/applications/${tabName}?statuses=${Status}"/>
            <c:set var="searchResult" value="${results}"/>
            <%@ include file="/WEB-INF/pages/admin/includes/application_tab_section.jsp" %>
            <%@ include file="/WEB-INF/pages/admin/includes/application_search_form.jsp" %>
            <!-- /.tabHead -->
            <div class="tabContent">
              <div class="pagination">
                <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
                <%@ include file="/WEB-INF/pages/admin/includes/application_buttons.jsp" %>
              </div>
              <%@ include file="/WEB-INF/pages/admin/includes/application_search_filter_panel.jsp" %>
              <c:choose>
              <c:when test="${searchResult.total == 0}">
                <div class="tableWrapper">
                  <div class="tableContainer"></div>
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM red">
                        No matched data found.
                      </div>
                    </div>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div class="tableWrapper">
                  <div class="tableContainer">
                    <c:if test="${active_application_tab == 'all'}">
                      <c:set var="addStatusColumn" value="yes"/>
                    </c:if>
                    <%@ include file="/WEB-INF/pages/admin/includes/application_search_result_table.jsp" %>
                  </div>
                  <!-- /.tableContainer -->
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM">
                        <%@ include file="/WEB-INF/pages/includes/pagination_details_and_links.jsp" %>
                      </div>
                    </div>
                  </div>
                  <!-- /.tabFoot -->
                </div>
              </c:otherwise>
              </c:choose>
            </div>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
