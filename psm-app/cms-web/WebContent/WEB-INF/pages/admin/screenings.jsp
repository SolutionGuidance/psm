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
  <c:set var="title" value="Screenings"/>
  <c:set var="activeTabScreenings" value="true" />
  <fmt:formatDate value="${startDate}" pattern="MM/dd/yyyy" var="searchStartDate" />
  <fmt:formatDate value="${endDate}" pattern="MM/dd/yyyy" var="searchEndDate" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Screenings
          </div>
          <div class="head">
            <h1 class="text">Screenings</h1>
          </div>
          <div class="clearFixed"></div>

            <div class="detailPanel screeningsDateRange">
              <form:form
                id="screening_form"
                action="${ctx}/agent/screenings"
                cssClass="paginationForm"
                modelAttribute="criteria"
                method="get"
              >

                <form:hidden path="pageSize" />
                <form:hidden path="pageNumber" />

                <input
                  type="hidden"
                  id="status"
                  name="status"
                  value="${activeTab}"
                />
                <div class="row rowDateRange">
                  <span class="dateWrapper floatL">
                    <input
                      name="startDate"
                      id="startDate"
                      class="date hasDatePicker inputBox"
                      title="Start Date"
                      placeholder="Start Date"
                      class="date"
                      type="text"
                      value="${searchStartDate}"
                    />
                  </span>
                  <span class="floatL">-</span>
                  <span class="dateWrapper floatL">
                    <input
                      name="endDate"
                      id="endDate"
                      class="date hasDatePicker inputBox"
                      title="End Date"
                      placeholder="End Date"
                      class="date"
                      type="text"
                      value="${searchEndDate}"
                    />
                  </span>
                  <input
                    type="submit"
                    value="Update Dates"
                    class="purpleBtn screeningsTabDatesBtn"
                  />
                </div>
              </form:form>
            </div>

          <div class="tabSection" id="applicationSection">
            <c:set var="active_screenings_tab" value="all"/>
            <%@ include file="/WEB-INF/pages/admin/includes/screenings_tab_section.jsp" %>
            <!-- /.tabHead -->
            <div class="tabContent">
              <div class="pagination">
                <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
                <%@ include file="/WEB-INF/pages/admin/includes/application_buttons.jsp" %>
              </div>
                <%@ include file="/WEB-INF/pages/admin/includes/screenings_filter_panel.jsp" %>
              <c:choose>
              <c:when test="${screenings.size() == 0}">
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
                    <%@ include file="/WEB-INF/pages/admin/includes/screenings_table.jsp" %>
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
    </div>
    <!-- /#wrapper -->
  </body>
</html>
