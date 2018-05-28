<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Reports"/>
  <c:set var="adminPage" value="true" />
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
            Reports
          </div>
          <div class="head">
            <h1 class="text">Reports</h1>
          </div>
          <div class="tabSection">
            <div class="detailPanel">
              <div class="row"><h3>Select a Report</h3></div>
              <div class="row">
                <a href="${ctx}/admin/reports/applications-by-reviewer/"
                  class="applicationsByReviewerLink"
                >
                  Applications by Reviewer
                </a>
              </div>
              <div class="row">
                <a href="${ctx}/admin/reports/draft-applications/"
                  class="draftApplicationsLink"
                >
                  Draft Applications
                </a>
              </div>
              <div class="row">
                <a href="${ctx}/admin/reports/time-to-review/"
                  class="timeToReviewLink"
                >
                  Time to Review
                </a>
              </div>
              <div class="row">
                <a href="${ctx}/admin/reports/provider-types/"
                  class="providerTypesLink"
                >
                  Provider Types
                </a>
              </div>
              <div class="row">
                <a href="${ctx}/admin/reports/reviewed-documents/"
                  class="reviewedDocumentsLink"
                >
                  Reviewed Documents
                </a>
              </div>
              <div class="row">
                <a href="${ctx}/admin/reports/risk-levels/"
                  class="riskLevelsLink"
                >
                  Risk Levels
                </a>
              </div>
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