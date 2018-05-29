<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Screenings"/>
  <c:set var="adminPage" value="true" />
  <c:set var="activeTabScreenings" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
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
              <form
                action="${ctx}/agent/screenings"
                :method "get"
              >
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
                      value=""
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
                      value=""
                    />
                  </span>
                  <input
                    type="submit"
                    value="Update Dates"
                    class="purpleBtn screeningsTabDatesBtn"
                  />
                </div>
              </form>
            </div>

          <div class="tabSection" id="enrollmentSection">
            <c:set var="active_screenings_tab" value="all"/>
            <%@ include file="/WEB-INF/pages/admin/includes/screenings_tab_section.jsp" %>
            <!-- /.tabHead -->
            <div class="tabContent">
              <div class="pagination">
                <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                <%@ include file="/WEB-INF/pages/admin/includes/enrollment_buttons.jsp" %>
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
                        <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
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
