<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Applications by Reviewer"/>
  <c:set var="adminPage" value="true" />
  <c:set var="includeD3" value="true" />
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
            <a href="<c:url value='/admin/reports' />">Reports</a>
            <span>Applications by Reviewer</span>
          </div>
          <div class="head">
            <h1 class="text">Applications by Reviewer</h1>
          </div>
          <div class="tabSection">
            <div class="detailPanel">
              <form action="${ctx}/admin/reports/enrollmentapproval.csv">
                <div class="row">
                  Enter a date range or leave both dates blank to include all
                  historical data.
                </div>
                <div class="row rowDateRange">
                  <span class="dateWrapper floatL">
                    <input
                      name="startDate"
                      id="startDate"
                      class="date hasDatePicker inputBox"
                      title="Date Start"
                      placeholder="Start Date"
                      class="date"
                      type="text"
                      readonly="readonly"
                    />
                  </span>
                  <span class="floatL">-</span>
                  <span class="dateWrapper floatL">
                    <input
                      name="endDate"
                      id="endDate"
                      class="date hasDatePicker inputBox"
                      title="Date End"
                      placeholder="End Date"
                      class="date"
                      type="text"
                      readonly="readonly"
                    />
                  </span>
                </div>
                <div class="row">
                  <input
                    type="submit"
                    value="Download CSV File"
                    class="purpleBtn downloadApplicationsByReviewerButton"
                  />
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
